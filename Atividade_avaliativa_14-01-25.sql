


--1. Quantidade de bibliotecários responsáveis por cada unidade.
select * from unidade;
select * from bibliotecario;
  SELECT 
    unidade.nome AS unidade,
    COUNT(bibliotecario.id_unidade) AS quantidade_bibliotecario
FROM 
    unidade 
JOIN  bibliotecario on unidade.id = bibliotecario.id_unidade
  
GROUP BY 
    unidade.nome
ORDER BY 
    quantidade_bibliotecario DESC;
	
--2. Quantidade de livros disponíveis em cada unidade.

select * from unidade;
select * from livro;

select unidade.nome as unidade, count(livro.id_unidade) as quantidade_livro
from unidade
join livro on unidade.id = livro.id_unidade
group by unidade.nome
order by quantidade_livro desc;

--3. Quantidade de empréstimos realizados em cada unidade.

 select * from unidade;
 select * from emprestimo;
 
 select unidade.nome as unidade, count(emprestimo.id) as quantidade_emprestimo
 from unidade
 join livro on unidade.id = livro.id_unidade
 join emprestimo on livro.id = emprestimo.id_livro
 group by unidade.nome;
 
    






--5. Quantidade total de usuários cadastrados no sistema.

 select * from usuario;
 
 select count(*) as total_usuario
 from usuario;



--6. Quantidade total de livros cadastrados no sistema.

select * from livro;

select count(*) as total_livro
from livro;


--7. Quantidade de livros emprestados por cada usuário. Ordene pelo total encontrado e em
--ordem decrescente. 

 select * from usuario;
 select * from livro;
 select * from emprestimo;
 
select usuario.nome as usuario, count(emprestimo.id_usuario) as quantidade_livro_emprestado
from usuario  
join emprestimo on usuario.id = emprestimo.id_usuario
group by usuario.nome
order by quantidade_livro_emprestado desc;
 
    



--8. Quantidade de empréstimos realizados por mês. Use EXTRACT(MONTH FROM
--data_emprestimo) para extrair o mês.

select from emprestimo;
 
select  extract(month from data_emprestimo) as mes, count(*) as quantidade_emprestimo
from  emprestimo
group by extract(month from data_emprestimo)   
order by mes;


--9. Média do número de páginas dos livros cadastrados no sistema.
 select * from livro;

 select round(avg(numero_paginas), 2) as media_paginas 
 from livro;


--10. Quantidade de livros cadastrados em cada categoria.

 select * from livro;
 select * from categoria;

 select categoria.nome as categoria, count(livro.id) as livro_cadastrado
 from categoria
 join livro on categoria.id = livro.id_categoria
 group by categoria.nome;

--11. Liste os livros cujos autores possuem nacionalidade americana.

  select * from livro;
  select * from autor;

  select livro.titulo as livro, autor.nome as autor
  from livro
  join autor on livro.id_autor = autor.id
  where autor.nacionalidade = 'Americana'
  order by livro.titulo;
  
 
--12. Quantidade de livros emprestados atualmente (não devolvidos).

 select * from emprestimo;
 select * from livro;
 
 select count(*) as quantidade_livros_emprestados
 from emprestimo
 where data_devolucao is null;
    




--13. Unidades com mais de 60 livros cadastrados.

 select * from livro;
 select * from unidade;

 select unidade.nome as unidade, count(livro.id) as quantidade_livro
 from unidade
 join livro on unidade.id = livro.id_unidade
 group by unidade.nome
 having count(livro.id) > 60
 order by quantidade_livro desc;






--14. Quantidade de livros por autor. Ordene pelo total e em ordem decrescente.
select * from livro;
select * from autor;

select autor.nome as autor, count(livro.id) as total_livros
from autor
join livro on livro.id_autor = autor.id
group by autor.nome
order by total_livros desc;
    





--15. Categorias que possuem mais de 5 livros disponíveis atualmente.

select * from categoria;
select * from livro;
select categoria.nome as categoria, count(livro.id) as total_livros_disponiveis
from categoria
join livro on livro.id_categoria = categoria.id
group by categoria.nome
having count(livro.disponivel) > 5;





--16. Unidades com pelo menos um empréstimo em aberto.

select unidade.nome as unidade
from unidade
join emprestimo on emprestimo.id_usuario = unidade.id
where emprestimo.devolvido = 'false'
group by unidade.nome
having count(emprestimo.id) >=1;


