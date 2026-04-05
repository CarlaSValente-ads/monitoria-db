
-- ============================================================
INSERT INTO ies (nome, endereco, telefone, status) VALUES
    ('Universidade Católica do Salvador',
     'Av. pinto aguiar, 2461 - Pituaçu, Salvador - BA',
     '(71) 3272-2000',
     'ativo');


INSERT INTO escola (nome, coordenador, ies_id, status) VALUES
    ('Escola de Tecnologia e Inovação',        'Prof. Roberto Almeida',  1, 'ativo'),
    ('Escola de Negócios e Gestão',            'Profa. Ana Mendes',    1, 'ativo'),
    ('Escola de Saúde e Bem-Estar',            'Prof. Fernando Costa',   1, 'ativo'),
    ('Escola de Humanidades e Ciências Sociais','Profa. Juliana Reis',   1, 'ativo');


INSERT INTO professor (matricula, nome, email, telefone, escola_id, status) VALUES
    ('PROF-001', 'Ana Paula Silveira',  'ana.silveira@ucsal.edu.br',   '(71) 99111-1111', 1, 'ativo'),
    ('PROF-002', 'Carlos Eduardo Lima', 'carlos.lima@ucsal.edu.br',    '(71) 99222-2222', 1, 'ativo'),
    ('PROF-003', 'Mariana Souza',       'mariana.souza@ucsal.edu.br',  '(71) 99333-3333', 1, 'ativo'),
    ('PROF-004', 'João Ferreira',       'joao.ferreira@ucsal.edu.br',  '(71) 99444-4444', 2, 'ativo'),
    ('PROF-005', 'Patrícia Nunes',      'patricia.nunes@ucsal.edu.br', '(71) 99555-5555', 2, 'ativo'),
    ('PROF-006', 'Ricardo Barros',      'ricardo.barros@ucsal.edu.br', '(71) 99666-6666', 3, 'ativo');

-- ────────────────────────────────────────────────────────────

-- ────────────────────────────────────────────────────────────
INSERT INTO curso (sigla, descricao, turno, coordenador, escola_id, status) VALUES
    ('ADS', 'Análise e Desenvolvimento de Sistemas', 'noturno',  'Ana Paula Silveira',  1, 'ativo'),
    ('SI',  'Sistemas de Informação',                'matutino', 'Carlos Eduardo Lima', 1, 'ativo'),
    ('ADM', 'Administração',                         'noturno',  'João Ferreira',       2, 'ativo'),
    ('ENF', 'Enfermagem',                            'integral', 'Ricardo Barros',      3, 'ativo');

-- ────────────────────────────────────────────────────────────

-- ────────────────────────────────────────────────────────────
INSERT INTO disciplina (sigla, descricao, carga_horaria, escola_id, status) VALUES
    ('BD1',  'Banco de Dados I',                60, 1, 'ativo'),
    ('POO',  'Programação Orientada a Objetos', 80, 1, 'ativo'),
    ('ALG',  'Algoritmos e Lógica',             60, 1, 'ativo'),
    ('ENG',  'Engenharia de Software',          60, 1, 'ativo'),
    ('MATH', 'Matemática para Computação',      60, 1, 'ativo'),
    ('CONT', 'Contabilidade Geral',             60, 2, 'ativo'),
    ('MKTG', 'Marketing Empresarial',           60, 2, 'ativo'),
    ('ANAT', 'Anatomia Humana',                 80, 3, 'ativo');

-- ────────────────────────────────────────────────────────────
-- ────────────────────────────────────────────────────────────
INSERT INTO matriz (nome, descricao, curso_id, status) VALUES
    ('Matriz ADS 2024',  'Grade ADS vigente a partir de 2024',  1, 'ativo'),
    ('Matriz SI 2024',   'Grade SI vigente a partir de 2024',   2, 'ativo'),
    ('Matriz ADM 2024',  'Grade ADM vigente a partir de 2024',  3, 'ativo');

-- ────────────────────────────────────────────────────────────

-- ────────────────────────────────────────────────────────────
INSERT INTO matriz_disciplina (matriz_id, disciplina_id, pre_requisito_id) VALUES
    (1, 3, NULL),  -- ADS: ALG sem pré-requisito
    (1, 2, 3),     -- ADS: POO exige ALG
    (1, 1, 2),     -- ADS: BD1 exige POO
    (1, 4, 2),     -- ADS: ENG exige POO
    (1, 5, NULL),  -- ADS: MATH sem pré-requisito
    (2, 3, NULL),  -- SI: ALG
    (2, 2, 3),     -- SI: POO exige ALG
    (2, 1, 2),     -- SI: BD1 exige POO
    (2, 5, NULL),  -- SI: MATH
    (3, 6, NULL),  -- ADM: CONT
    (3, 7, NULL);  -- ADM: MKTG

-- ────────────────────────────────────────────────────────────
-- ────────────────────────────────────────────────────────────
INSERT INTO aluno_monitor
    (matricula, nome, disciplina_id, professor_id, semestre, tipo_monitoria, local, data_inicio, data_fim, status)
VALUES
    ('ALU-2025-001', 'Lucas Andrade',   1, 1, '2025.1', 'bolsista',   'Lab. Informática 02', '2025-02-10', '2025-07-31', 'ativo'),
    ('ALU-2025-002', 'Fernanda Castro', 2, 2, '2025.1', 'voluntario', 'Sala 305',             '2025-02-10', '2025-07-31', 'ativo'),
    ('ALU-2025-003', 'Pedro Henrique',  3, 3, '2025.1', 'bolsista',   'Lab. Informática 01', '2025-02-10', '2025-07-31', 'ativo'),
    ('ALU-2025-004', 'Camila Rocha',    6, 4, '2025.1', 'voluntario', 'Sala 210',             '2025-02-10', '2025-07-31', 'ativo');

-- ────────────────────────────────────────────────────────────

-- ────────────────────────────────────────────────────────────
INSERT INTO monitoria_relatorio (aluno_id, semestre, qtd_alunos, ocorrencias, parecer) VALUES
    (1, '2025.1', 18, 'Dificuldades em SQL JOIN.', 'Monitor com bom desempenho. Recomendado para renovação.'),
    (2, '2025.1', 22, 'Dúvidas sobre herança e polimorfismo.', 'Monitor dedicado, boa didática.'),
    (3, '2025.1', 15, 'Turma com dificuldades em lógica.', 'Realizou sessões extras. Desempenho excelente.');

-- ────────────────────────────────────────────────────────────

-- ────────────────────────────────────────────────────────────
INSERT INTO role (nome) VALUES
    ('ROLE_ADMIN'),
    ('ROLE_PROFESSOR');

-- ────────────────────────────────────────────────────────────

-- ────────────────────────────────────────────────────────────
INSERT INTO usuario (username, password, email, status, professor_id, role_id) VALUES
    ('admin',
     '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy',
     'admin@ucsal.edu.br',
     'ativo',
     NULL,
     1),   

    ('ana.silveira',
     '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy',
     'ana.silveira@ucsal.edu.br',
     'ativo',
     1,
     2),   

    ('carlos.lima',
     '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy',
     'carlos.lima@ucsal.edu.br',
     'ativo',
     2,
     2);   
