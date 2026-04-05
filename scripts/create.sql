
-- ────────────────────────────────────────────────────────────
-- 0. EXTENSÕES
-- ────────────────────────────────────────────────────────────
CREATE EXTENSION IF NOT EXISTS "pgcrypto";   
CREATE EXTENSION IF NOT EXISTS "unaccent";   

-- ────────────────────────────────────────────────────────────
-- 1. IES  
-- ────────────────────────────────────────────────────────────
CREATE TABLE ies (
    id        SERIAL        PRIMARY KEY,
    nome      VARCHAR(200)  NOT NULL,
    endereco  VARCHAR(300),
    telefone  VARCHAR(20),
    status    VARCHAR(10)   NOT NULL DEFAULT 'ativo'
                            CHECK (status IN ('ativo','inativo'))
);

-- ────────────────────────────────────────────────────────────
-- 2. ESCOLA
-- ────────────────────────────────────────────────────────────
CREATE TABLE escola (
    id             SERIAL        PRIMARY KEY,
    nome           VARCHAR(200)  NOT NULL,
    status         VARCHAR(10)   NOT NULL DEFAULT 'ativo'
                                 CHECK (status IN ('ativo','inativo')),
    coordenador    VARCHAR(200),
    ies_id         INT           NOT NULL
                                 REFERENCES ies(id)
);

-- ────────────────────────────────────────────────────────────
-- 3. PROFESSOR
-- ────────────────────────────────────────────────────────────
CREATE TABLE professor (
    id             SERIAL        PRIMARY KEY,
    matricula      VARCHAR(50)   NOT NULL UNIQUE,
    nome           VARCHAR(200)  NOT NULL,
    email          VARCHAR(200)  NOT NULL UNIQUE,
    telefone       VARCHAR(20),
    escola_id      INT           NOT NULL
                                 REFERENCES escola(id),
    data_cadastro  DATE          NOT NULL DEFAULT CURRENT_DATE,
    status         VARCHAR(10)   NOT NULL DEFAULT 'ativo'
                                 CHECK (status IN ('ativo','inativo'))
);

-- ────────────────────────────────────────────────────────────
-- 4. CURSO
-- ────────────────────────────────────────────────────────────
CREATE TABLE curso (
    id             SERIAL        PRIMARY KEY,
    sigla          VARCHAR(20)   NOT NULL,
    descricao      VARCHAR(300)  NOT NULL,
    turno          VARCHAR(20)   NOT NULL
                                 CHECK (turno IN ('matutino','vespertino','noturno','integral')),
    coordenador    VARCHAR(200),
    escola_id      INT           NOT NULL
                                 REFERENCES escola(id),
    status         VARCHAR(10)   NOT NULL DEFAULT 'ativo'
                                 CHECK (status IN ('ativo','inativo'))
);

-- ────────────────────────────────────────────────────────────
-- 5. DISCIPLINA
-- ────────────────────────────────────────────────────────────
CREATE TABLE disciplina (
    id             SERIAL        PRIMARY KEY,
    sigla          VARCHAR(20)   NOT NULL,
    descricao      VARCHAR(300)  NOT NULL,
    carga_horaria  INT           NOT NULL CHECK (carga_horaria > 0),
    escola_id      INT           NOT NULL
                                 REFERENCES escola(id),
    status         VARCHAR(10)   NOT NULL DEFAULT 'ativo'
                                 CHECK (status IN ('ativo','inativo'))
);

-- ────────────────────────────────────────────────────────────
-- 6. MATRIZ 
-- ────────────────────────────────────────────────────────────
CREATE TABLE matriz (
    id             SERIAL        PRIMARY KEY,
    nome           VARCHAR(200)  NOT NULL,
    descricao      TEXT,
    curso_id       INT           NOT NULL
                                 REFERENCES curso(id),
    status         VARCHAR(10)   NOT NULL DEFAULT 'ativo'
                                 CHECK (status IN ('ativo','inativo'))
);

-- ────────────────────────────────────────────────────────────
-- 7. MATRIZ_DISCIPLINA  
-- ────────────────────────────────────────────────────────────
CREATE TABLE matriz_disciplina (
    id                SERIAL   PRIMARY KEY,
    matriz_id         INT      NOT NULL REFERENCES matriz(id),
    disciplina_id     INT      NOT NULL REFERENCES disciplina(id),
    pre_requisito_id  INT               REFERENCES disciplina(id),
    UNIQUE (matriz_id, disciplina_id)
);

-- ────────────────────────────────────────────────────────────
-- 8. ALUNO_MONITOR
-- ────────────────────────────────────────────────────────────
CREATE TABLE aluno_monitor (
    id              SERIAL        PRIMARY KEY,
    matricula       VARCHAR(50)   NOT NULL UNIQUE,
    nome            VARCHAR(200)  NOT NULL,
    disciplina_id   INT           NOT NULL
                                  REFERENCES disciplina(id),
    professor_id    INT           NOT NULL
                                  REFERENCES professor(id),
    semestre        VARCHAR(10)   NOT NULL,   -- ex: '2025.1'
    tipo_monitoria  VARCHAR(50)   NOT NULL
                                  CHECK (tipo_monitoria IN ('bolsista','voluntario')),
    local           VARCHAR(200),
    data_inicio     DATE          NOT NULL,
    data_fim        DATE,
    status          VARCHAR(10)   NOT NULL DEFAULT 'ativo'
                                  CHECK (status IN ('ativo','inativo','encerrado'))
);

-- ────────────────────────────────────────────────────────────
-- 9. MONITORIA_RELATORIO
-- ────────────────────────────────────────────────────────────
CREATE TABLE monitoria_relatorio (
    id           SERIAL   PRIMARY KEY,
    aluno_id     INT      NOT NULL REFERENCES aluno_monitor(id),
    semestre     VARCHAR(10) NOT NULL,
    qtd_alunos   INT      NOT NULL DEFAULT 0 CHECK (qtd_alunos >= 0),
    ocorrencias  TEXT,
    parecer      TEXT
);

-- ────────────────────────────────────────────────────────────
-- ÍNDICES  (performance em buscas frequentes)
-- ────────────────────────────────────────────────────────────
CREATE INDEX idx_escola_ies          ON escola(ies_id);
CREATE INDEX idx_professor_escola    ON professor(escola_id);
CREATE INDEX idx_curso_escola        ON curso(escola_id);
CREATE INDEX idx_disciplina_escola   ON disciplina(escola_id);
CREATE INDEX idx_matriz_curso        ON matriz(curso_id);
CREATE INDEX idx_md_matriz           ON matriz_disciplina(matriz_id);
CREATE INDEX idx_md_disciplina       ON matriz_disciplina(disciplina_id);
CREATE INDEX idx_monitor_disciplina  ON aluno_monitor(disciplina_id);
CREATE INDEX idx_monitor_professor   ON aluno_monitor(professor_id);
CREATE INDEX idx_relatorio_aluno     ON monitoria_relatorio(aluno_id);

-- ============================================================
--  FIM DE create.sql
-- ============================================================
