10 Views
--1. Crie uma view para listar todos os livros com seus autores e categorias.

  CREATE OR REPLACE VIEW livros_autores_categorias AS
SELECT 
    livro.id AS livro_id,
    livro.titulo AS livro_titulo,
    autor.nome AS autor_nome,
    categoria.nome AS categoria_nome
FROM 
    livro
JOIN 
    autor ON livro.id_autor = autor.id
JOIN 
    categoria ON livro.id_categoria = categoria.id;

	select * from livro;
	select * from autor;
	
--2. Crie uma view que exiba os livros disponíveis com título, unidade e categoria.

 CREATE OR REPLACE VIEW livros_disponiveis AS
SELECT 
    livro.id AS livro_id,
    livro.titulo AS livro_titulo,
    unidade.nome AS unidade_nome,
    categoria.nome AS categoria_nome
FROM 
    livro
JOIN 
    unidade ON livro.id_unidade = unidade.id
JOIN 
    categoria ON livro.id_categoria = categoria.id
where livro.disponivel = true;

	select * from unidade;
	select * from livro;
	select * from categoria;




--3. Crie uma view para listar os usuários e o total de empréstimos realizados por cada
--um.
CREATE OR REPLACE VIEW usuarios_total_emprestimos AS
SELECT 
    
    usuario.nome AS usuario_nome,
    COUNT(emprestimo.id) AS total_emprestimos
FROM 
    usuario
 JOIN 
    emprestimo ON usuario.id = emprestimo.id_usuario
GROUP BY 
     usuario.nome;

	select * from emprestimo;


--4. Crie uma view que mostre os empréstimos atrasados com os nomes dos usuários e
--os títulos dos livros.
CREATE OR REPLACE VIEW emprestimos_atrasados AS
SELECT 
    


--5. Crie uma view para exibir o nome das unidades e o total de livros disponíveis em
--cada uma.
--6. Crie uma view que exiba todos os autores com o número total de livros publicados.
--7. Crie uma view para listar todos os empréstimos com o status de devolução
--(devolvido ou não).
--8. Crie uma view para listar os livros categorizados por ano de publicação, ordenados
--do mais recente para o mais antigo.
--9. Crie uma view que mostre os bibliotecários e as unidades às quais estão associados.
--10. Crie uma view para exibir os usuários que nunca realizaram empréstimos

