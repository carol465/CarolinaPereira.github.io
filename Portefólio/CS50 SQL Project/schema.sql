CREATE TABLE utilizadores (
id_utilizador INT,
username TEXT NOT NULL UNIQUE, -- não convém se PK devida tabela login, vou ter info repetida e este pode ser mudada e pode se perder dados
password TEXT NOT NULL,
email TEXT NOT NULL UNIQUE,
descricao TEXT,
PRIMARY KEY (id_utilizador)
);

CREATE TABLE alteracao_user (
id_alteracao_user INT, --id_login são ações que o utilizador faz, o mesmo utilizador poder ter duas ações login
id_utilizador INT, -- pode ser nula quando se cria um novo utilizador
tipo_alteracao TEXT NOT NULL CHECK (tipo_alteracao IN ('Inserido', 'Alterado', 'Eliminado')),
username_antigo TEXT,
username_novo TEXT, -- estes podem ser nulos dependendo do tipo de operação
password_antigo TEXT,
password_nova TEXT,
email_antigo TEXT,
email_novo TEXT,
descricao_antigo TEXT,
descricao_novo TEXT,
PRIMARY KEY(id_alteracao_user),
FOREIGN KEY(id_utilizador) REFERENCES utilizadores(id_utilizador) --  um histórico de algo que permita registar múltiplos logins para o mesmo utilizador ao longo do tempo
);

CREATE TABLE livros (
id_livro INT,
id_dono_livro INT NOT NULL,
id_editora INT NOT NULL,
id_genero INT NOT NULL,
id_lingua INT NOT NULL,
titulo TEXT NOT NULL,
edicao TEXT,
isbn TEXT,
formato TEXT,
paginas INT NOT NULL,
disp TEXT NOT NULL CHECK (disp IN ('Disponível', 'Indisponível')),
PRIMARY KEY (id_livro),
FOREIGN KEY (id_dono_livro) REFERENCES utilizadores(id_utilizador),
FOREIGN KEY (id_editora) REFERENCES editoras(id_editora),
FOREIGN KEY (id_genero) REFERENCES generos(id_genero),
FOREIGN KEY (id_lingua) REFERENCES linguas(id_lingua)
);

CREATE TABLE autores(
id_autor INT,
nome TEXT NOT NULL, --drop para mais que uma opção
PRIMARY KEY (id_autor)
);

CREATE TABLE livros_autores(
    id_livro INT NOT NULL,
    id_autor INT NOT NULL, -- o livro é sempre imtroduzido primeiro
    PRIMARY KEY (id_livro, id_autor),
    FOREIGN KEY (id_livro) REFERENCES livros(id_livro),
    FOREIGN KEY (id_autor) REFERENCES autores(id_autor)
    );
)

CREATE TABLE editoras(
id_editora INT,
nome TEXT NOT NULL,
PRIMARY KEY (id_editora)
);

CREATE TABLE generos(
id_genero INT,
nome TEXT NOT NULL,
PRIMARY KEY (id_genero)
);

CREATE TABLE linguas(
id_lingua INT,
nome TEXT NOT NULL,
PRIMARY KEY (id_lingua)
);

CREATE TABLE emprestimos (
id_emprestimo INT,
id_livro INT NOT NULL,
id_faz INT NOT NULL,
id_recebe INT NOT NULL,
id_ponto_entrega INT NOT NULL,
id_ponto_recolha INT NOT NULL,
data_inicio DATE NOT NULL,
data_fim_prevista DATE NOT NULL,
data_fim_real,
situacao TEXT NOT NULL CHECK (situacao IN ('Ativo', 'Finalizado', 'Cancelado', 'Atrasado')),
PRIMARY KEY (id_emprestimo),
FOREIGN KEY (id_livro) REFERENCES livros(id_livro),
FOREIGN KEY (id_faz) REFERENCES utilizadores(id_utilizador),
FOREIGN KEY (id_recebe) REFERENCES utilizadores(id_utilizador),
FOREIGN KEY (id_ponto_entrega) REFERENCES ponto_encontro(id_ponto_encontro),
FOREIGN KEY (id_ponto_recolha) REFERENCES ponto_encontro(id_ponto_encontro)
);

CREATE TABLE ponto_encontro ( -- antes e depois de entregar o livro
id_ponto_encontro INT,
pais TEXT NOT NULL,
cidade TEXT NOT NULL,
rua TEXT NOT NULL,
numero INT NOT NULL,
cod_postal TEXT NOT NULL, -- pode ter hífens
nome TEXT NOT NULL,
PRIMARY KEY (id_ponto_encontro)
);


CREATE TABLE renovacoes (
id_renovacao INT,
id_emprestimo INT NOT NULL,
data_renovacao DATE NOT NULL, -- várias datas de renovação max 3
data_nova DATE NOT NULL,
PRIMARY KEY (id_renovacao),
FOREIGN KEY (id_emprestimo) REFERENCES emprestimos(id_emprestimo)
);

CREATE TABLE notificacoes (
id_notificacao INT,
id_emprestimo INT NOT NULL,
data_notificacao DATE NOT NULL, -- Quando o aviso foi criado
tipo_notificacao TEXT NOT NULL CHECK (tipo_notificacao IN('Atraso Livro', 'Lembrete Entrega', 'Livro Recebido', 'Livro Entregue')),
mensagem TEXT NOT NULL,
PRIMARY KEY (id_notificacao),
FOREIGN KEY (id_emprestimo) REFERENCES emprestimos( id_emprestimo)
);

CREATE TABLE avaliacoes (
id_avaliacao INT,
id_emprestimo INT NOT NULL,
pontuacao INT NOT NULL CHECK (pontuacao IN (1, 2, 3, 4, 5)),
comentario TEXT,
PRIMARY KEY (id_avaliacao),
FOREIGN KEY(id_emprestimo) REFERENCES emprestimos(id_emprestimo)
);

CREATE TABLE conquistas (
id_conquista INT,
nome_conquista TEXT NOT NULL, -- 1O_LIVROS_LIDOS, 10_EMPRESTIMOS, DESCOBERTA_DO_MES, TOP_5
descricao TEXT NOT NULL,
PRIMARY KEY (id_conquista)
);

CREATE TABLE conquista_alcancada (
id_conquista INT,
id_utilizador INT,
data_alcancada DATE NOT NULL,
PRIMARY KEY (id_conquista, id_utilizador),
FOREIGN KEY (id_conquista) REFERENCES conquistas(id_conquista),
FOREIGN KEY (id_utilizador) REFERENCES utilizadores(id_utilizador)
);

--Livros Disponíveis
CREATE VIEW livros_disponiveis AS
SELECT
    livros.id_livro,
    livros.titulo,
    autores.nome AS autor,
    generos.nome AS genero,
    linguas.nome AS lingua,
    utilizadores.username AS dono_do_livro
FROM livros
JOIN utilizadores ON livros.id_dono_livro = utilizadores.id_utilizador
JOIN livros_autores la ON livros.id_livro = livros_autores.id_livro
JOIN autores ON livros_autores.id_autor = autores.id_autor
JOIN generos ON livros.id_genero = generos.id_genero
JOIN linguas lg ON livros.id_lingua = linguas.id_lingua
WHERE livros.disp = 'Disponível';

-- Empréstimos Ativos
CREATE VIEW emprestimos_ativos AS
SELECT
    emprestimos.id_emprestimo,
    livros.titulo AS livro,
    quem_empresta.username AS quem_empresta,
    emprestado_a.username AS emprestado_a,
    emprestimos.data_fim_prevista,
    emprestimos.situacao
FROM emprestimos
JOIN livros ON emprestimos.id_livro = livros.id_livro
JOIN utilizadores AS quem_empresta ON emprestimos.id_faz = quem_empresta.id_utilizador
JOIN utilizadores AS emprestado_a ON emprestimos.id_recebe = emprestado_a.id_utilizador
WHERE emprestimos.situacao = 'Ativo' OR emprestimos.situacao = 'Atrasado';

-- Avaliaçóes Emprestimos
CREATE VIEW avaliacoes_emprestimos AS
SELECT
    avaliacoes.id_avaliacao,
    emprestimos.id_emprestimo,
    livros.titulo AS livro_emprestado,
    quem_emprestou.username AS quem_emprestou,
    quem_recebeu.username AS quem_recebeu,
    avaliacoes.pontuacao,
    avaliacoes.comentario
FROM avaliacoes
JOIN emprestimos ON avaliacoes.id_emprestimo = emprestimos.id_emprestimo
JOIN livros ON emprestimos.id_livro = livros.id_livro
JOIN utilizadores AS quem_emprestou ON emprestimos.id_faz = quem_emprestou.id_utilizador
JOIN utilizadores AS quem_recebeu ON emprestimos.id_recebe = quem_recebeu.id_utilizador;

-- Progresso das Conquistas
CREATE VIEW progresso_conquistas AS
SELECT
    utilizadores.username,
    conquistas.nome_conquista,
    conquistas.descricao,
    conquista_alcancada.data_alcancada
FROM conquista_alcancada
JOIN utilizadores ON conquista_alcancada.id_utilizador = utilizadores.id_utilizador
JOIN conquistas ON conquista_alcancada.id_conquista = conquistas.id_conquista;

-- Revovacoes Emprestimos
CREATE VIEW renovacoes_emprestimos AS
SELECT
    renovacoes.id_renovacao,
    renovacoes.id_emprestimo,
    emprestimos.data_inicio,
    emprestimos.data_fim_prevista AS data_fim_prevista_original,
    renovacoes.data_renovacao,
    renovacoes.data_nova AS data_fim_prevista_renovada
FROM renovacoes
JOIN emprestimos ON renovacoes.id_emprestimo = emprestimos.id_emprestimo;

-- Utilizadores com mais Emprestimos
CREATE VIEW utilizadores_mais_emprestimos AS
SELECT
    utilizadores.username,
    COUNT(emprestimos.id_emprestimo) AS total_emprestimos_feitos
FROM utilizadores
JOIN emprestimos ON utilizadores.id_utilizador = emprestimos.id_faz
GROUP BY utilizadores.username
ORDER BY total_emprestimos_feitos DESC;

-- IDX LIVROS
-- Pesquisas por título
CREATE INDEX idx_livros_titulo ON livros (titulo);
-- Pesquisas por autor
CREATE INDEX idx_livros_autor ON autores (nome); -- código para poder inserir mais que um

-- IDX EMPRESTIMOS
-- Pesquisa com utilizadores id_faz e situação
CREATE INDEX idx_emprestimos_faz_situacao ON emprestimos (id_faz, situacao);
-- Pesquisa com utilizadores id_recebe e situação
CREATE INDEX idx_emprestimos_id_recebe_situacao ON emprestimos (id_recebe, situacao);

-- IDX RENOVAÇÕES
-- Para consultas de ordenação por data de renovação
CREATE INDEX idx_renovacoes_data_renovacao ON renovacoes (data_renovacao);

-- IDX AVALIAÇOES
-- Para filtrar por pontuação.
CREATE INDEX idx_avaliacoes_pontuacao ON avaliacoes (pontuacao);

-- IDX PONTO ENCONTRO
-- Para pesquisar por cidade.
CREATE INDEX idx_ponto_encontro_cidade ON ponto_encontro (cidade);

-- IDX CONQUISTAS
-- Para pesquisar por conquista.
CREATE INDEX idx_conquistas_nome_conquista ON conquistas (nome_conquista);

--Trigger Atualização Utilizadores
CREATE TRIGGER alteracao_utilizadores_atualizacao
AFTER UPDATE ON utilizadores
FOR EACH ROW
BEGIN
    INSERT INTO alteracao_user(tipo_alteracao, username_antigo, username_novo, password_antigo, password_nova, email_antigo, email_novo, descricao_antigo, descricao_novo)
    VALUES ('Alterado', OLD.username, NEW.username, OLD.password, NEW.password, OLD.email, NEW.email, OLD.descricao, NEW.descricao);
END;
--O trigger é executada depois de uma atualização na tabela utilizadores.

-- Trigger Eliminação Password/Username
CREATE TRIGGER alteracao_utilizadores_eliminacao
AFTER DELETE ON utilizadores
FOR EACH ROW
BEGIN
    INSERT INTO alteracao_user(tipo_alteracao, username_antigo, username_novo, password_antigo, password_nova, email_antigo, email_novo, descricao_antigo, descricao_novo)
    VALUES ('Eliminado', OLD.username, NULL, OLD.password, NULL, OLD.email, NULL, OLD.descricao);
END;
-- O trigger é executada depois de um DELETE na tabela utilizadores.

-- Trigger Inserir Password/Username
CREATE TRIGGER alteracao_utilizadores_inserido
AFTER INSERT ON utilizadores
FOR EACH ROW
BEGIN
    INSERT INTO alteracao_user(username_antigo, username_novo, password_antigo, password_nova, email_antigo, email_novo, descricao_antigo, descricao_novo)
    VALUES ('Inserido', NULL, NEW.username, NULL, NEW.password, NULL, NEW.email, NULL, NEW.descricao);
END;

-- Trigger para atualizar a disponibilidade do livro depois deste ser finalizado e cancelado
CREATE TRIGGER atualizacao_situacao_livro_finalizado
AFTER UPDATE ON emprestimos
FOR EACH ROW
WHEN NEW.situacao IN ('Finalizado','Cancelado') AND OLD.situacao IN ('Ativo','Atrasado')
BEGIN
    UPDATE livros
    SET disp = 'Disponível'
    WHERE id_livro = NEW.id_livro; -- garante que o livro ( que estava associado ao empréstimo que foi finalizado ou cancelado) seja atualizado.
END;

 UPDATE emprestimos SET situacao = 'Cancelado' WHERE id_emprestimo = 3;

-- qe o empréstimo foi finalizado ou cancelado, atualiza a situação do livro correspondente para 'Disponível'
-- quando a instrução UPDATE é executada numa tabela, o banco de dados armazena os dados da linha antes da alteração numa variável chamada OLD e os dados da linha após a alteração numa variável chamada NEW.
-- instrução UPDATE dentro do TRIGGER usa NEW.id_livro para localizar o livro correspondente na tabela livros e atualizar o seu estado (disp) para 'Disponível'.

/* O que faz: Altera o estado do livro.
Quando: Após um empréstimo ser marcado como 'Finalizado' ou 'Cancelado'.
Como: Define a situação do livro para 'Disponível', usando o ID do livro do empréstimo que foi atualizado. */


