-- caso precise apagar as tabelas antes de criar
DROP TABLE T_AQ_DIARIO CASCADE CONSTRAINTS;
DROP TABLE T_AQ_PROGRESSO CASCADE CONSTRAINTS;
DROP TABLE T_AQ_MISSAO CASCADE CONSTRAINTS;
DROP TABLE T_AQ_USUARIO CASCADE CONSTRAINTS;

-- 1. Tabela de Usuários (Funcionários)
CREATE TABLE T_AQ_USUARIO (
    id_usuario      NUMBER(10) NOT NULL,
    nm_usuario      VARCHAR2(100) NOT NULL,
    ds_cargo        VARCHAR2(50) NOT NULL,
    ds_email        VARCHAR2(100) NOT NULL,
    nr_nivel        NUMBER(3) DEFAULT 1 NOT NULL,
    qt_xp_total     NUMBER(10) DEFAULT 0 NOT NULL,
    CONSTRAINT PK_AQ_USUARIO PRIMARY KEY (id_usuario),
    CONSTRAINT UK_AQ_EMAIL UNIQUE (ds_email)
);

-- 2. Tabela de Missões (Upskilling e Resiliência)
CREATE TABLE T_AQ_MISSAO (
    id_missao       NUMBER(10) NOT NULL,
    ds_titulo       VARCHAR2(100) NOT NULL,
    ds_descricao    VARCHAR2(200),
    ds_tipo         VARCHAR2(20) NOT NULL,
    qt_xp_recompensa NUMBER(5) NOT NULL,
    dt_criacao      DATE DEFAULT SYSDATE,
    CONSTRAINT PK_AQ_MISSAO PRIMARY KEY (id_missao),
    CONSTRAINT CK_AQ_TIPO_MISSAO CHECK (ds_tipo IN ('UPSKILLING', 'RESILIENCIA'))
);

-- 3. Tabela de Progresso (Relacionamento N:N)
CREATE TABLE T_AQ_PROGRESSO (
    id_progresso    NUMBER(10) NOT NULL,
    id_usuario      NUMBER(10) NOT NULL,
    id_missao       NUMBER(10) NOT NULL,
    dt_conclusao    DATE DEFAULT SYSDATE NOT NULL,
    st_status       VARCHAR2(20) DEFAULT 'CONCLUIDA',
    ds_feedback     VARCHAR2(200),
    CONSTRAINT PK_AQ_PROGRESSO PRIMARY KEY (id_progresso),
    CONSTRAINT FK_PROG_USUARIO FOREIGN KEY (id_usuario) REFERENCES T_AQ_USUARIO(id_usuario),
    CONSTRAINT FK_PROG_MISSAO FOREIGN KEY (id_missao) REFERENCES T_AQ_MISSAO(id_missao)
);

-- 4. tabela Diário de Bem-Estar (Dados para a IA de Burnout)
CREATE TABLE T_AQ_DIARIO (
    id_diario       NUMBER(10) NOT NULL,
    id_usuario      NUMBER(10) NOT NULL,
    nr_nivel_stress NUMBER(2) NOT NULL, 
    nr_horas_sono   NUMBER(4,2),
    ds_humor        VARCHAR2(50),
    dt_registro     DATE DEFAULT SYSDATE NOT NULL,
    CONSTRAINT PK_AQ_DIARIO PRIMARY KEY (id_diario),
    CONSTRAINT FK_DIARIO_USUARIO FOREIGN KEY (id_usuario) REFERENCES T_AQ_USUARIO(id_usuario),
    CONSTRAINT CK_AQ_STRESS CHECK (nr_nivel_stress BETWEEN 1 AND 10)
);

-- T_AQ_USUARIO (10 registros)
INSERT INTO T_AQ_USUARIO (id_usuario, nm_usuario, ds_cargo, ds_email, nr_nivel, qt_xp_total) VALUES (1, 'Ana Silva', 'Dev Junior', 'ana@empresa.com', 2, 1500);
INSERT INTO T_AQ_USUARIO (id_usuario, nm_usuario, ds_cargo, ds_email, nr_nivel, qt_xp_total) VALUES (2, 'Bruno Souza', 'Dev Senior', 'bruno@empresa.com', 5, 4500);
INSERT INTO T_AQ_USUARIO (id_usuario, nm_usuario, ds_cargo, ds_email, nr_nivel, qt_xp_total) VALUES (3, 'Carla Dias', 'Data Analyst', 'carla@empresa.com', 3, 2300);
INSERT INTO T_AQ_USUARIO (id_usuario, nm_usuario, ds_cargo, ds_email, nr_nivel, qt_xp_total) VALUES (4, 'Daniel Rocha', 'Scrum Master', 'daniel@empresa.com', 4, 3100);
INSERT INTO T_AQ_USUARIO (id_usuario, nm_usuario, ds_cargo, ds_email, nr_nivel, qt_xp_total) VALUES (5, 'Elena Costa', 'UX Designer', 'elena@empresa.com', 2, 1200);
INSERT INTO T_AQ_USUARIO (id_usuario, nm_usuario, ds_cargo, ds_email, nr_nivel, qt_xp_total) VALUES (6, 'Fabio Lima', 'Dev Pleno', 'fabio@empresa.com', 3, 2800);
INSERT INTO T_AQ_USUARIO (id_usuario, nm_usuario, ds_cargo, ds_email, nr_nivel, qt_xp_total) VALUES (7, 'Gabriela Mota', 'QA Engineer', 'gabi@empresa.com', 1, 800);
INSERT INTO T_AQ_USUARIO (id_usuario, nm_usuario, ds_cargo, ds_email, nr_nivel, qt_xp_total) VALUES (8, 'Hugo Alves', 'DevOps', 'hugo@empresa.com', 4, 3600);
INSERT INTO T_AQ_USUARIO (id_usuario, nm_usuario, ds_cargo, ds_email, nr_nivel, qt_xp_total) VALUES (9, 'Igor Santos', 'Tech Lead', 'igor@empresa.com', 6, 6000);
INSERT INTO T_AQ_USUARIO (id_usuario, nm_usuario, ds_cargo, ds_email, nr_nivel, qt_xp_total) VALUES (10, 'Julia Faria', 'Product Owner', 'julia@empresa.com', 3, 2500);

-- T_AQ_MISSAO (10 registros - misturando Upskilling e Resiliência)
INSERT INTO T_AQ_MISSAO (id_missao, ds_titulo, ds_descricao, ds_tipo, qt_xp_recompensa) VALUES (1, 'Curso Python Básico', 'Completar modulo 1 de Python', 'UPSKILLING', 500);
INSERT INTO T_AQ_MISSAO (id_missao, ds_titulo, ds_descricao, ds_tipo, qt_xp_recompensa) VALUES (2, 'Meditação Guiada', 'Pausa de 10min para mindfulness', 'RESILIENCIA', 100);
INSERT INTO T_AQ_MISSAO (id_missao, ds_titulo, ds_descricao, ds_tipo, qt_xp_recompensa) VALUES (3, 'Certificação AWS', 'Obter Cloud Practitioner', 'UPSKILLING', 1000);
INSERT INTO T_AQ_MISSAO (id_missao, ds_titulo, ds_descricao, ds_tipo, qt_xp_recompensa) VALUES (4, 'Café Virtual', 'Conversar com colega de outro time', 'RESILIENCIA', 150);
INSERT INTO T_AQ_MISSAO (id_missao, ds_titulo, ds_descricao, ds_tipo, qt_xp_recompensa) VALUES (5, 'Code Review', 'Revisar 3 PRs', 'UPSKILLING', 300);
INSERT INTO T_AQ_MISSAO (id_missao, ds_titulo, ds_descricao, ds_tipo, qt_xp_recompensa) VALUES (6, 'Caminhada', 'Caminhar 15 min ao ar livre', 'RESILIENCIA', 100);
INSERT INTO T_AQ_MISSAO (id_missao, ds_titulo, ds_descricao, ds_tipo, qt_xp_recompensa) VALUES (7, 'SQL Avançado', 'Dominar Joins e Subqueries', 'UPSKILLING', 600);
INSERT INTO T_AQ_MISSAO (id_missao, ds_titulo, ds_descricao, ds_tipo, qt_xp_recompensa) VALUES (8, 'Feedback Positivo', 'Elogiar um colega publicamente', 'RESILIENCIA', 200);
INSERT INTO T_AQ_MISSAO (id_missao, ds_titulo, ds_descricao, ds_tipo, qt_xp_recompensa) VALUES (9, 'Workshop IA', 'Participar do workshop de GenAI', 'UPSKILLING', 400);
INSERT INTO T_AQ_MISSAO (id_missao, ds_titulo, ds_descricao, ds_tipo, qt_xp_recompensa) VALUES (10, 'Desconexão', 'Não usar telas por 1h antes de dormir', 'RESILIENCIA', 250);

-- T_AQ_PROGRESSO (10 registros - Histórico de quem fez oq)
INSERT INTO T_AQ_PROGRESSO (id_progresso, id_usuario, id_missao, dt_conclusao, st_status) VALUES (1, 1, 1, TO_DATE('2025-11-01', 'YYYY-MM-DD'), 'CONCLUIDA');
INSERT INTO T_AQ_PROGRESSO (id_progresso, id_usuario, id_missao, dt_conclusao, st_status) VALUES (2, 1, 2, TO_DATE('2025-11-02', 'YYYY-MM-DD'), 'CONCLUIDA');
INSERT INTO T_AQ_PROGRESSO (id_progresso, id_usuario, id_missao, dt_conclusao, st_status) VALUES (3, 2, 3, TO_DATE('2025-11-01', 'YYYY-MM-DD'), 'CONCLUIDA');
INSERT INTO T_AQ_PROGRESSO (id_progresso, id_usuario, id_missao, dt_conclusao, st_status) VALUES (4, 3, 1, TO_DATE('2025-11-03', 'YYYY-MM-DD'), 'CONCLUIDA');
INSERT INTO T_AQ_PROGRESSO (id_progresso, id_usuario, id_missao, dt_conclusao, st_status) VALUES (5, 4, 4, TO_DATE('2025-11-04', 'YYYY-MM-DD'), 'CONCLUIDA');
INSERT INTO T_AQ_PROGRESSO (id_progresso, id_usuario, id_missao, dt_conclusao, st_status) VALUES (6, 5, 5, TO_DATE('2025-11-05', 'YYYY-MM-DD'), 'CONCLUIDA');
INSERT INTO T_AQ_PROGRESSO (id_progresso, id_usuario, id_missao, dt_conclusao, st_status) VALUES (7, 6, 7, TO_DATE('2025-11-06', 'YYYY-MM-DD'), 'CONCLUIDA');
INSERT INTO T_AQ_PROGRESSO (id_progresso, id_usuario, id_missao, dt_conclusao, st_status) VALUES (8, 7, 1, TO_DATE('2025-11-07', 'YYYY-MM-DD'), 'CONCLUIDA');
INSERT INTO T_AQ_PROGRESSO (id_progresso, id_usuario, id_missao, dt_conclusao, st_status) VALUES (9, 8, 9, TO_DATE('2025-11-08', 'YYYY-MM-DD'), 'CONCLUIDA');
INSERT INTO T_AQ_PROGRESSO (id_progresso, id_usuario, id_missao, dt_conclusao, st_status) VALUES (10, 9, 10, TO_DATE('2025-11-09', 'YYYY-MM-DD'), 'CONCLUIDA');

-- T_AQ_DIARIO (10 registros - Logs de stress)
INSERT INTO T_AQ_DIARIO (id_diario, id_usuario, nr_nivel_stress, nr_horas_sono, ds_humor, dt_registro) VALUES (1, 1, 5, 7.5, 'Normal', SYSDATE-9);
INSERT INTO T_AQ_DIARIO (id_diario, id_usuario, nr_nivel_stress, nr_horas_sono, ds_humor, dt_registro) VALUES (2, 2, 8, 5.0, 'Cansado', SYSDATE-8);
INSERT INTO T_AQ_DIARIO (id_diario, id_usuario, nr_nivel_stress, nr_horas_sono, ds_humor, dt_registro) VALUES (3, 3, 3, 8.0, 'Feliz', SYSDATE-7);
INSERT INTO T_AQ_DIARIO (id_diario, id_usuario, nr_nivel_stress, nr_horas_sono, ds_humor, dt_registro) VALUES (4, 4, 9, 4.5, 'Exausto', SYSDATE-6); 
INSERT INTO T_AQ_DIARIO (id_diario, id_usuario, nr_nivel_stress, nr_horas_sono, ds_humor, dt_registro) VALUES (5, 5, 4, 7.0, 'Bem', SYSDATE-5);
INSERT INTO T_AQ_DIARIO (id_diario, id_usuario, nr_nivel_stress, nr_horas_sono, ds_humor, dt_registro) VALUES (6, 6, 6, 6.5, 'Ansioso', SYSDATE-4);
INSERT INTO T_AQ_DIARIO (id_diario, id_usuario, nr_nivel_stress, nr_horas_sono, ds_humor, dt_registro) VALUES (7, 7, 2, 9.0, 'Otimo', SYSDATE-3);
INSERT INTO T_AQ_DIARIO (id_diario, id_usuario, nr_nivel_stress, nr_horas_sono, ds_humor, dt_registro) VALUES (8, 8, 7, 6.0, 'Estressado', SYSDATE-2);
INSERT INTO T_AQ_DIARIO (id_diario, id_usuario, nr_nivel_stress, nr_horas_sono, ds_humor, dt_registro) VALUES (9, 9, 4, 7.5, 'Focado', SYSDATE-1);
INSERT INTO T_AQ_DIARIO (id_diario, id_usuario, nr_nivel_stress, nr_horas_sono, ds_humor, dt_registro) VALUES (10, 10, 5, 7.0, 'Normal', SYSDATE);

COMMIT;

-- 1. Consulta com ORDER BY
-- listar funcionários com nível de experiência alto para identificar potenciais mentores.
SELECT nm_usuario, ds_cargo, qt_xp_total 
FROM T_AQ_USUARIO
WHERE qt_xp_total > 2000
ORDER BY qt_xp_total DESC;

-- 2. Consulta com (JOIN)
-- relatório de quais missões cada usuário completou e quando.
SELECT 
    u.nm_usuario, 
    m.ds_titulo AS missao, 
    m.ds_tipo AS tipo_missao, 
    p.dt_conclusao
FROM T_AQ_USUARIO u
JOIN T_AQ_PROGRESSO p ON u.id_usuario = p.id_usuario
JOIN T_AQ_MISSAO m ON m.id_missao = p.id_missao
ORDER BY u.nm_usuario;

-- 3. Consulta com (GROUP BY)
-- contar quantos funcionarios temos por nível de senioridade 
SELECT nr_nivel, COUNT(*) as total_funcionarios, AVG(qt_xp_total) as media_xp
FROM T_AQ_USUARIO
GROUP BY nr_nivel
ORDER BY nr_nivel;

-- 4 - consulta  (GROUP BY + HAVING + JOIN)
SELECT 
    u.ds_cargo,
    COUNT(d.id_diario) as qtd_registros,
    AVG(d.nr_nivel_stress) as media_stress
FROM T_AQ_USUARIO u
JOIN T_AQ_DIARIO d ON u.id_usuario = d.id_usuario
GROUP BY u.ds_cargo
HAVING AVG(d.nr_nivel_stress) > 6
ORDER BY media_stress DESC;