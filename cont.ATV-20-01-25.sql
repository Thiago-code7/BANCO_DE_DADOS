--4. Crie uma view que mostre os empréstimos atrasados com os nomes dos usuários e 
--os títulos dos livros.

CREATE VIEW emprestimos_atrasados AS
SELECT 
    usuario.nome AS nome_usuario,
    livro.titulo AS titulo_livro,
    emprestimo.data_devolucao AS data_prevista,
    CURRENT_DATE AS data_atual
FROM 
    emprestimo 
JOIN 
    usuario ON emprestimo.id_usuario = usuario.id
JOIN 
    livro ON emprestimo.id_livro = livro.id
WHERE 
    emprestimo.data_devolucao < CURRENT_DATE 
     
select*from emprestimos_atrasados;
select*from usuario;
select*from emprestimo;
select*from livro;

--5. Crie uma view para exibir o nome das unidades e o total de livros disponíveis em 
--cada uma.

CREATE VIEW unidades_livros_disponiveis AS
SELECT 
    unidade.nome AS nome_unidade,
    COUNT(livro.id) AS total_livros_disponiveis
FROM 
    unidade 
JOIN 
    livro ON unidade.id = livro.id_unidade
WHERE 
    livro.disponivel = TRUE 
GROUP BY 
    unidade.nome;


--6. Crie uma view que exiba todos os autores com o número total de livros publicados.

  CREATE VIEW autores_total_livros AS
  SELECT autor.nome AS nome_autor,
  COUNT(livro.id) AS total_livros_publicados
  FROM autor
  JOIN livro ON autor.id = livro.id_autor
  group by autor.nome;

  SELECT*FROM autores_total_livros;
  
  

--7. Crie uma view para listar todos os empréstimos com o status de devolução 
--(devolvido ou não).

CREATE VIEW emprestimos_status_devolucao AS
SELECT 
    emprestimo.id AS emprestimo_id,
    usuario.nome AS nome_usuario,
    livro.titulo AS titulo_livro,
    emprestimo.data_emprestimo,
    emprestimo.data_devolucao AS data_prevista,
    emprestimo.devolvido AS data_efetiva_devolucao,
    CASE 
        WHEN emprestimo.devolvido IS NOT NULL THEN 'Devolvido'
        ELSE 'Não devolvido'
    END AS status_devolucao
FROM 
    emprestimo
JOIN 
    usuario ON emprestimo.id_usuario = usuario.id
JOIN 
    livro ON emprestimo.id_livro = livro.id;

SELECT*FROM emprestimos_status_devolucao;

--8. Crie uma view para listar os livros categorizados por ano de publicação, ordenados 
--do mais recente para o mais antigo.

  CREATE VIEW livros_por_ano_publicacao AS
  SELECT 
    livro.titulo AS titulo_livro,
    livro.ano_publicacao,
    categoria.nome AS categoria
  FROM 
    livro
  JOIN 
    categoria ON livro.id_categoria = categoria.id
  ORDER BY 
    livro.ano_publicacao DESC;
	
  SELECT*FROM livro;
  SELECT*FROM categoria;
  SELECT*FROM livros_por_ano_publicacao;
--9. Crie uma view que mostre os bibliotecários e as unidades às quais estão associados.

  CREATE VIEW bibliotecarios_unidades_associados AS
  SELECT
  bibliotecario.nome AS nome_bibliotecario,
  unidade.nome AS nome_unidade
  FROM bibliotecario
  JOIN unidade ON bibliotecario.id_unidade = unidade.id;

  SELECT*FROM bibliotecario;
  SELECT*FROM unidade;
  SELECT*FROM bibliotecarios_unidades_associados;
  
--10. Crie uma view para exibir os usuários que nunca realizaram empréstimos.

  CREATE VIEW usuarios_sem_emprestimos as
  SELECT 
  usuario.nome AS nome_usuario
  FROM
  usuario
  JOIN
  emprestimo ON usuario.id = emprestimo.id_usuario
  WHERE
  emprestimo.id IS NULL;

  SELECT*FROM usuarios_sem_emprestimos;

  
--1. Crie uma procedure para adicionar um novo autor ao banco de dados.

   
 CREATE OR REPLACE PROCEDURE inserir_novo_autor(
 nome varchar,
 nacionalidade varchar,
 data_nascimento date
 ) LANGUAGE SQL
 AS $$
 INSERT INTO autor(nome, nacionalidade, data_nascimento) 

 VALUES(nome, nacionalidade, data_nascimento)
 $$;

 CALL inserir_novo_autor('Thiago monteiro', 'Brasileira', '1982-04-07')

 SELECT*FROM AUTOR;

--2. Crie uma procedure para registrar um novo empréstimo, verificando se o livro está 
--disponível.

  CREATE OR REPLACE PROCEDURE registrar_emprestimo(
    p_id_usuario INT,
    p_id_livro INT,
    p_data_emprestimo DATE,
    p_data_devolucao DATE
)
LANGUAGE plpgsql
AS $$
BEGIN
    -- Verifica se o livro está disponível
    IF EXISTS (
        SELECT 1
        FROM emprestimo
        WHERE id_livro = p_livro_id
          AND devolvido IS NULL
    ) THEN
        RAISE EXCEPTION 'O livro solicitado (ID: %) já está emprestado.', p_livro_id;
    END IF;

    -- Insere o novo empréstimo
    INSERT INTO emprestimo (id_usuario, id_livro, data_emprestimo, data_devolucao)
    VALUES (p_usuario_id, p_livro_id, p_data_emprestimo, p_data_devolucao);

    RAISE NOTICE 'Empréstimo registrado com sucesso para o usuário (ID: %) e livro (ID: %).',
                 p_usuario_id, p_livro_id;
END;
$$;


 SELECT*FROM livro;
 SELECT*FROM emprestimo;

--3. Crie uma procedure para devolver um livro, atualizando o status de devolução e a 
--disponibilidade.

 CREATE OR REPLACE PROCEDURE devolver_livro(
    p_emprestimo_id INT,
    p_data_devolucao DATE
)
LANGUAGE plpgsql
AS $$
BEGIN
    -- Verifica se o empréstimo existe e não foi devolvido
    IF NOT EXISTS (
        SELECT 1
        FROM emprestimo
        WHERE id = p_emprestimo_id
          AND devolvido IS NULL
    ) THEN
        RAISE EXCEPTION 'O empréstimo (ID: %) não existe ou o livro já foi devolvido.', p_emprestimo_id;
    END IF;

    -- Atualiza o status de devolução
    UPDATE emprestimo
    SET devolvido = p_data_devolucao
    WHERE id = p_emprestimo_id;

    RAISE NOTICE 'Livro devolvido com sucesso para o empréstimo (ID: %).', p_emprestimo_id;
END;
$$;






--4. Crie uma procedure para excluir uma unidade, garantindo que os livros relacionados 
--sejam removidos.

 CREATE OR REPLACE PROCEDURE excluir_unidade(
    p_unidade_id INT
)
LANGUAGE plpgsql
AS $$
BEGIN
    -- Verifica se a unidade existe
    IF NOT EXISTS (
        SELECT 1
        FROM unidade
        WHERE id = p_unidade_id
    ) THEN
        RAISE EXCEPTION 'A unidade (ID: %) não existe.', p_unidade_id;
    END IF;

    -- Remove os livros relacionados à unidade
    DELETE FROM livro
    WHERE id_unidade = p_unidade_id;

    -- Remove a unidade
    DELETE FROM unidade
    WHERE id = p_unidade_id;

    RAISE NOTICE 'Unidade (ID: %) e seus livros relacionados foram removidos com sucesso.', p_unidade_id;
END;
$$;
 

--5. Crie uma procedure para adicionar uma nova categoria à tabela de categorias.

  
 CREATE OR REPLACE PROCEDURE inserir_nova_categoria(
 nome varchar,
 descricao text
 ) LANGUAGE SQL
 AS $$
 INSERT INTO categoria(nome, descricao)
 VALUES(nome, descricao)
 $$;

 CALL inserir_nova_categoria('Ficção, literario')
  SELECT*FROM categoria;

--6. Crie uma procedure para atualizar o telefone de um usuário, identificando-o pelo
--ID.

  CREATE OR REPLACE PROCEDURE atualizar_telefone_usuario(
    p_usuario_id INT,
    p_novo_telefone VARCHAR(15)
)
LANGUAGE plpgsql
AS $$
BEGIN
    -- Verifica se o usuário existe
    IF NOT EXISTS (
        SELECT 1
        FROM usuario
        WHERE id = p_usuario_id
    ) THEN
        RAISE EXCEPTION 'O usuário com ID % não existe.', p_usuario_id;
    END IF;

    -- Atualiza o telefone do usuário
    UPDATE usuario
    SET telefone = p_novo_telefone
    WHERE id = p_usuario_id;

    RAISE NOTICE 'Telefone do usuário (ID: %) atualizado com sucesso para %.', p_usuario_id, p_novo_telefone;
END;
$$;

SELECT*FROM usuario;


--7. Crie uma procedure para transferir um livro de uma unidade para outra

 CREATE OR REPLACE PROCEDURE transferir_livro(
    p_livro_id INT,
    p_nova_unidade_id INT
)
LANGUAGE plpgsql
AS $$
BEGIN
    -- Verifica se o livro existe
    IF NOT EXISTS (
        SELECT 1
        FROM livro
        WHERE id = p_livro_id
    ) THEN
        RAISE EXCEPTION 'O livro com ID % não existe.', p_livro_id;
    END IF;

    -- Verifica se a nova unidade existe
    IF NOT EXISTS (
        SELECT 1
        FROM unidade
        WHERE id = p_nova_unidade_id
    ) THEN
        RAISE EXCEPTION 'A unidade com ID % não existe.', p_nova_unidade_id;
    END IF;

    -- Atualiza a unidade do livro
    UPDATE livro
    SET id_unidade = p_nova_unidade_id
    WHERE id = p_livro_id;

    RAISE NOTICE 'O livro (ID: %) foi transferido para a unidade (ID: %).', p_livro_id, p_nova_unidade_id;
END;
$$;



--8. Crie uma procedure para remover um bibliotecário, verificando se ele está 
--associado a alguma unidade.


--9. Crie uma procedure para atualizar a categoria de um livro, identificando-o pelo
--ID.


--10. Crie uma procedure para adicionar um novo usuário ao banco de dados, passando 
--os dados necessários como parâmetros.

  CREATE OR REPLACE PROCEDURE inserir_novo_usuario(
 nome varchar,
 email varchar,
 telefone varchar,
 endereco text,
 data_cadastro timestamp
 ) LANGUAGE SQL
 AS $$
 INSERT INTO usuario(nome, email, telefone, endereco, data_cadastro) 

 VALUES(nome, email, telefone, endereco, data_cadastro)
 $$;

 CALL inserir_novo_usuario('Antonio lourenço', 'antoniolourenço@email.com.br','(84)988776655', 'Rua Açu,135,centro,Natal/RN', '1999-04-07');

 SELECT*FROM usuario;
  
  
