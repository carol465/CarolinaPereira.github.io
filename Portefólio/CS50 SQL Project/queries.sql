-- In this SQL file, write (and comment!) the typical SQL queries users will run on your database

-- Dados tabela utilizadores
INSERT INTO utilizadores (id_utilizador, username, password, email, descricao) VALUES
(1, 'joaocosta', 'pass123', 'joao.costa@example.com', 'Leitor ávido de ficção científica.'),
(2, 'mariasilva', 'securepass', 'maria.silva@example.com', 'Interessada em literatura clássica e história.'),
(3, 'pedrogomes', 'gomespass', 'pedro.gomes@example.com', 'Colecionador de livros raros.'),
(4, 'anarita', 'anapass', 'ana.rita@example.com', 'Gosta de romances e thrillers.'),
(5, 'carlosalmeida', 'carlospass', 'carlos.almeida@example.com', 'Fã de fantasia e aventura.');

-- Dados tabela alteracao_user
INSERT INTO alteracao_user (id_alteracao_user, id_utilizador, tipo_alteracao, username_antigo, username_novo, password_antigo, password_nova, email_antigo, email_novo, descricao_antigo, descricao_novo) VALUES
(1, 1, 'Inserido', NULL, 'joaocosta', NULL, 'pass123', NULL, 'joao.costa@example.com', NULL, 'Leitor ávido de ficção científica.'),
(2, 2, 'Inserido', NULL, 'mariasilva', NULL, 'securepass', NULL, 'maria.silva@example.com', NULL, 'Interessada em literatura clássica e história.'),
(3, 1, 'Alterado', 'joaocosta', 'joaocosta_novo', 'pass123', 'nova_pass', 'joao.costa@example.com', 'joao.costa_novo@example.com', 'Leitor ávido de ficção científica.', 'Leitor ávido de ficção científica e romance.' );

-- Dados tabela editoras
INSERT INTO editoras (id_editora, nome) VALUES
(1, 'Porto Editora'),
(2, 'Bertrand Editora'),
(3, 'Presença'),
(4, 'Leyabooks'),
(5, 'Penguin Random House');

--Dados tabela genero
INSERT INTO generos (id_genero, nome) VALUES
(1, 'Ficção Científica'),
(2, 'Fantasia'),
(3, 'Romance'),
(4, 'Thriller'),
(5, 'História'),
(6, 'Clássico'),
(7, 'Aventura');

-- Dados tabela linguas
INSERT INTO linguas (id_lingua, nome) VALUES
(1, 'Português'),
(2, 'Inglês'),
(3, 'Espanhol'),
(4, 'Francês');

-- Dados tabela livros
INSERT INTO livros (id_livro, id_dono_livro, id_editora, id_genero, id_lingua, titulo, edicao, isbn, formato, paginas, disp) VALUES
(1, 1, 1, 1, 1, '1984', '2ª Edição', '978-972-0-06190-2', 'Capa Dura', 328, 'Disponível'),
(2, 2, 2, 6, 2, 'Orgulho e Preconceito', '1ª Edição', '978-0-14-143951-8', 'Capa Mole', 432, 'Disponível'),
(3, 3, 3, 2, 1, 'O Senhor dos Anéis: A Irmandade do Anel', 'Edição de Bolso', '978-972-23-4567-8', 'Capa Mole', 576, 'Disponível'),
(4, 1, 4, 4, 1, 'Os Crimes ABC', '3ª Edição', '978-989-661-000-1', 'Capa Dura', 288, 'Indisponível'),
(5, 4, 5, 3, 2, 'Cem Anos de Solidão', 'Edição Comemorativa', '978-0-06-088328-7', 'Capa Dura', 448, 'Disponível'),
(6, 5, 1, 2, 1, 'Harry Potter e a Pedra Filosofal', '1ª Edição Portuguesa', '978-972-23-2868-8', 'Capa Mole', 264, 'Disponível');

-- Dados tabelas autores
INSERT INTO autores (id_autor, nome) VALUES
(1, 'George Orwell'),
(2, 'Jane Austen'),
(3, 'J.R.R. Tolkien'),
(4, 'Agatha Christie'),
(5, 'Gabriel Garcia Marquez'),
(6, 'J.K. Rowling');

--Dados tabelas livros_autores
INSERT INTO livros_autores (id_livro, id_autor) VALUES
(1, 1), -- 1984 - George Orwell
(2, 2), -- Orgulho e Preconceito - Jane Austen
(3, 3), -- O Senhor dos Anéis - J.R.R. Tolkien
(4, 4), -- Os Crimes ABC - Agatha Christie
(5, 5), -- Cem Anos de Solidão - Gabriel Garcia Marquez
(6, 6); -- Harry Potter - J.K. Rowling

-- Dados tabela ponto_encontro
INSERT INTO ponto_encontro (id_ponto_encontro, pais, cidade, rua, numero, cod_postal, nome) VALUES
(1, 'Portugal', 'Lisboa', 'Rua da Liberdade', 10, '1000-001', 'Café Central'),
(2, 'Portugal', 'Porto', 'Avenida dos Aliados', 50, '4000-002', 'Livraria Foz'),
(3, 'Portugal', 'Coimbra', 'Rua Larga', 25, '3000-003', 'Biblioteca Municipal');

-- Dados tabela emprestimos
-- NOTA: data_fim_real é NULL para empréstimos 'Ativo'
INSERT INTO emprestimos (id_emprestimo, id_livro, id_faz, id_recebe, id_ponto_entrega, id_ponto_recolha, data_inicio, data_fim_prevista, data_fim_real, situacao) VALUES
(1, 1, 1, 2, 1, 1, '2024-07-01', '2024-07-15', '2024-07-14', 'Finalizado'),
(2, 3, 3, 4, 2, 2, '2024-07-10', '2024-07-24', '2024-07-24', 'Finalizado'),
(3, 5, 4, 1, 3, 3, '2024-07-20', '2024-08-03', NULL, 'Ativo'), -- UPDATE emprestimos SET situacao = 'Cancelado' WHERE id_emprestimo = 3;
(4, 6, 5, 2, 1, 2, '2024-07-25', '2024-08-08', NULL, 'Ativo');

-- Dados tabela renovacoes
INSERT INTO renovacoes (id_renovacao, id_emprestimo, data_renovacao, data_nova) VALUES
(1, 3, '2024-08-01', '2024-08-17');

-- Dados tabela notificações
INSERT INTO notificacoes (id_notificacao, id_emprestimo, data_notificacao, tipo_notificacao, mensagem) VALUES
(1, 1, '2024-07-13', 'Lembrete Entrega', 'O livro 1984 deve ser devolvido amanhã.'),
(2, 2, '2024-07-25', 'Livro Recebido', 'O livro Orgulho e Preconceito foi recebido com sucesso.'),
(3, 3, '2024-08-04', 'Atraso Livro', 'O livro Cem Anos de Solidão está atrasado.');

-- Dados tabela avaliações
INSERT INTO avaliacoes (id_avaliacao, id_emprestimo, pontuacao, comentario) VALUES
(1, 1, 5, 'Excelente experiência de empréstimo!'),
(2, 2, 4, 'Livro em ótimo estado, processo simples.'),
(3, 3, 3, NULL);

-- Dados tabela conquistas
INSERT INTO conquistas (id_conquista, nome_conquista, descricao) VALUES
(1, 'Leitor Iniciante', 'Completou o primeiro empréstimo.'),
(2, 'Aventureiro Literário', 'Emprestou 5 livros diferentes.'),
(3, 'Amigo dos Livros', 'Emprestou um livro a outro utilizador.'),
(4, 'Crítico Literário', 'Deixou 3 avaliações.');

-- Dados tabela conquista_alcancada
INSERT INTO conquista_alcancada (id_conquista, id_utilizador, data_alcancada) VALUES
(1, 1, '2024-07-14'), -- João Costa completou o primeiro empréstimo
(1, 2, '2024-07-14'), -- Maria Silva completou o primeiro empréstimo
(3, 1, '2024-07-14'), -- João Costa emprestou um livro
(4, 1, '2024-08-05'); -- João Costa deixou 3 avaliações

-- Livros por género
SELECT generos.nome AS genero, COUNT(livros.id_livro) AS total_livros
FROM livros
JOIN generos ON livros.id_genero = generos.id_genero
GROUP BY generos.nome
ORDER BY total_livros DESC;

-- Selecionar os emails dos utilizadores que receberam o livro '1984'
SELECT email
FROM utilizadores
WHERE id_utilizador IN (
    SELECT id_recebe
    FROM emprestimos
    WHERE id_livro = (
        SELECT id_livro
        FROM livros
        WHERE titulo = '1984')
);

-- Todos os livros que um determinado utilizador tem
SELECT
    livros.titulo,
    generos.nome AS nome_do_genero,
    livros.disp AS disponibilidade
FROM livros
JOIN utilizadores ON livros.id_dono_livro = utilizadores.id_utilizador
JOIN generos ON livros.id_genero = generos.id_genero
WHERE utilizadores.username = 'joaocosta';

-- Emprestimos atrasados de um utilizador
SELECT
    emprestimos.id_emprestimo,
    livros.titulo,
    utilizadores.username AS utilizador_que_recebeu,
    emprestimos.data_inicio,
    emprestimos.data_fim_prevista,
    emprestimos.situacao
FROM emprestimos
JOIN livros ON livros.id_livro = emprestimos.id_livro
JOIN utilizadores ON utilizadores.id_utilizador = emprestimos.id_recebe
WHERE utilizadores.username = 'joaocosta'
AND emprestimos.situacao = 'Ativo';

-- Calcular a pontuação média de avaliação de um utilizador como emprestador
SELECT utilizadores.username, ROUND(AVG(avaliacoes.pontuacao), 2) AS media
FROM avaliacoes JOIN emprestimos ON avaliacoes.id_emprestimo = emprestimos.id_emprestimo
JOIN utilizadores ON utilizadores.id_utilizador = emprestimos.id_faz
WHERE utilizadores.username = 'joaocosta' GROUP BY utilizadores.username;

-- Calcular a pontuação média de avaliação de um utilizador comoemprestado
SELECT utilizadores.username, ROUND(AVG(avaliacoes.pontuacao), 2) AS media
FROM avaliacoes JOIN emprestimos ON avaliacoes.id_emprestimo = emprestimos.id_emprestimo
JOIN utilizadores ON utilizadores.id_utilizador = emprestimos.id_recebe
WHERE utilizadores.username = 'joaocosta' GROUP BY utilizadores.username;

-- Pesquisar livro/s e ver em que linguagens está disponível
SELECT livros.titulo, linguas.nome
FROM livros
JOIN linguas ON livros.id_lingua = linguas.id_lingua
WHERE livros.titulo LIKE '%Harry Potter%';

-- Identificar utilizadores que mudaram a palavra-passe
SELECT DISTINCT utilizadores.username
FROM utilizadores JOIN alteracao_user ON utilizadores.id_utilizador = alteracao_user.id_utilizador
WHERE alteracao_user.tipo_alteracao = 'Alterado';

-- Utilizadores que alcançaram uma conquista específica
SELECT utilizadores.username, conquistas.nome_conquista, conquista_alcancada.data_alcancada
FROM utilizadores JOIN conquista_alcancada ON utilizadores.id_utilizador = conquista_alcancada.id_utilizador
JOIN conquistas ON conquista_alcancada.id_conquista = conquistas.id_conquista
WHERE conquistas.nome_conquista = 'Amigo dos Livros';

-- Autores com mais livros na plataforma
SELECT autores.nome, COUNT(livros_autores.id_livro) AS total_livros
FROM autores
JOIN livros_autores ON autores.id_autor = livros_autores.id_autor
GROUP BY autores.nome
ORDER BY total_livros DESC;

-- Detalhes de um empréstimo
SELECT
    emprestimos.id_emprestimo,
    livros.titulo,
    u_faz.username AS faz_emprestimo,
    u_recebe.username AS recebe_emprestimo,
    emprestimos.data_inicio,
    emprestimos.data_fim_prevista,
    emprestimos.situacao
FROM emprestimos
JOIN livros ON emprestimos.id_livro = livros.id_livro
JOIN utilizadores u_faz ON emprestimos.id_faz = u_faz.id_utilizador
JOIN utilizadores u_recebe ON emprestimos.id_recebe = u_recebe.id_utilizador
WHERE emprestimos.id_emprestimo = 4;

-- Empréstimos que foram renovados pelo menos uma vez
SELECT DISTINCT
    emprestimos.id_emprestimo,
    livros.titulo,
    u_faz.username AS quem_fez_o_emprestimo,
    u_recebe.username AS quem_recebeu_o_emprestimo
FROM emprestimos
JOIN renovacoes ON emprestimos.id_emprestimo = renovacoes.id_emprestimo
JOIN livros ON emprestimos.id_livro = livros.id_livro
JOIN utilizadores AS u_faz ON emprestimos.id_faz = u_faz.id_utilizador
JOIN utilizadores AS u_recebe ON emprestimos.id_recebe = u_recebe.id_utilizador;

-- Top 5 de Livros mais Emprestados
SELECT
    livros.titulo,
    COUNT(emprestimos.id_livro) AS total_emprestimos
FROM livros
JOIN emprestimos ON livros.id_livro = emprestimos.id_livro
GROUP BY livros.titulo
ORDER BY total_emprestimos DESC LIMIT 5;

-- Utilizadores que mais emprestam livros
SELECT
    utilizadores.username,
    COUNT(emprestimos.id_faz) AS livros_emprestados
FROM utilizadores
JOIN emprestimos ON utilizadores.id_utilizador = emprestimos.id_faz
GROUP BY utilizadores.username
ORDER BY livros_emprestados DESC;

-- Livros disponíveis por género
SELECT
    generos.nome AS genero,
    livros.titulo,
    livros.edicao,
    linguas.nome AS linguagem
FROM livros
JOIN generos ON livros.id_genero = generos.id_genero
JOIN linguas ON livros.id_lingua = linguas.id_lingua
WHERE livros.disp = 'Disponível'
ORDER BY generos.nome, livros.titulo;

-- Histórico de Alterações de um Utilizador em Específico
SELECT
    alteracao_user.tipo_alteracao,
    alteracao_user.username_antigo,
    alteracao_user.username_novo,
    alteracao_user.email_antigo,
    alteracao_user.email_novo
FROM alteracao_user
WHERE alteracao_user.id_utilizador = 1;

-- Pontos de Encontro Numa Cidade Específica (Porto)
SELECT
    ponto_encontro.nome,
    ponto_encontro.rua,
    ponto_encontro.numero,
    ponto_encontro.cod_postal,
    ponto_encontro.cidade,
    ponto_encontro.pais
FROM ponto_encontro
WHERE ponto_encontro.cidade = 'Porto';

-- Notificações Pendentes para um Empréstimo
SELECT
    notificacoes.tipo_notificacao,
    notificacoes.mensagem,
    notificacoes.data_notificacao,
    emprestimos.id_emprestimo,
    livros.titulo AS livro_associado
FROM notificacoes
JOIN emprestimos ON notificacoes.id_emprestimo = emprestimos.id_emprestimo
JOIN livros ON emprestimos.id_livro = livros.id_livro
WHERE notificacoes.id_emprestimo = 3;

-- Livros que estão Emprestados, quem tem e quem deu
SELECT
    livros.titulo AS titulo_do_livro,
    u_dono.username AS dono_do_livro,
    u_recebe.username AS quem_tem_o_livro_emprestado,
    emprestimos.data_inicio,
    emprestimos.data_fim_prevista
FROM livros
JOIN emprestimos ON livros.id_livro = emprestimos.id_livro
JOIN utilizadores AS u_dono ON livros.id_dono_livro = u_dono.id_utilizador
JOIN utilizadores AS u_recebe ON emprestimos.id_recebe = u_recebe.id_utilizador
WHERE emprestimos.situacao = 'Ativo';

-- Utilizadores que Emprestaram ou Receberam Livros num Ponto de Encontro Específico entrega ou recolha
SELECT DISTINCT
    utilizadores.username,
    utilizadores.email
FROM utilizadores
JOIN emprestimos ON utilizadores.id_utilizador = emprestimos.id_faz OR utilizadores.id_utilizador = emprestimos.id_recebe
JOIN ponto_encontro ON ponto_encontro.id_ponto_encontro IN (emprestimos.id_ponto_entrega, emprestimos.id_ponto_recolha)
WHERE ponto_encontro.nome = 'Livraria Foz';

-- Emprestimo com utilizadores com Avaliação Média abaixo de 4
SELECT
    utilizadores.username,
    AVG(avaliacoes.pontuacao) AS pontuacao_media
FROM utilizadores
JOIN emprestimos ON utilizadores.id_utilizador = emprestimos.id_faz OR utilizadores.id_utilizador = emprestimos.id_recebe
JOIN avaliacoes ON emprestimos.id_emprestimo = avaliacoes.id_emprestimo
GROUP BY utilizadores.username
HAVING AVG(avaliacoes.pontuacao) < 4
ORDER BY pontuacao_media ASC;

-- Autores em que os Livros foram Emprestados Mais de 1 vezes no total
SELECT
    livros.titulo AS livro,
    autores.nome AS autor,
    COUNT(emprestimos.id_emprestimo) AS total_emprestimos_livro
FROM livros_autores
JOIN autores ON autores.id_autor = livros_autores.id_autor
JOIN livros ON livros_autores.id_livro = livros.id_livro
JOIN emprestimos ON livros.id_livro = emprestimos.id_livro
GROUP BY autores.nome, livros.titulo
HAVING COUNT(emprestimos.id_emprestimo) = 1; -- filtrar os resultados por total de emprestimos

-- Atualizar a data de fim real e a situação de um empréstimo finalizado
UPDATE emprestimos
SET data_fim_real = '2025-07-29',
    situacao = 'Finalizado'
WHERE id_emprestimo = 4;

-- Atualizacao da situação do emprestimo
UPDATE livros
SET disp = 'Disponível'
WHERE id_livro IN (
        SELECT id_livro
        FROM emprestimos
        WHERE situacao = 'Finalizado'
    );

-- Atualizar a descrição de um utilizador
UPDATE utilizadores
SET descricao = 'Entusiasta de ficção científica e fantasia.'
WHERE username = 'joaocosta';

-- Eliminar um utilizador
DELETE FROM utilizadores
WHERE id_utilizador = 5;

--Trigger Atualização/Inserir exemplo:
INSERT INTO utilizadores (username, password, email, descricao)
VALUES ('carolina', '1234', 'carolina@email.com', 'usuária inicial');

UPDATE utilizadores
SET email = 'carolina.nova@email.com', descricao = 'usuária atualizada'
WHERE username = 'carolina';

SELECT * FROM alteracao_utilizador;

