

 --procedimentos - procedures
 select * from autor;
 create or replace procedure inserir_novo_autor(
 nome varchar,
 nacionalidade varchar,
 data_nascimento date
 ) language sql
 as $$
 insert into autor(nome, nacionalidade, data_nascimento) 

 values(nome, nacionalidade, data_nascimento)
 $$;

 call inserir_novo_autor('Nome', 'BR', '1990-11-11')

 --1-criar um procedimento para criar uma nova categoria;
 select * from categoria;
 create or replace procedure inserir_nova_categoria(
 nome varchar,
 descricao text
 ) language sql
 as $$
 insert into categoria(nome, descricao)
 values(nome, descricao)
 $$;

 call inserir_nova_categoria('Romance, literario')

 select * from unidade;
 create or replace procedure update_telefone_unidade(
 id_unidade integer,
telefone_unidade varchar
 )language sql
 as $$
 update unidade
 set telefone = telefone_unidade
 where id = id_unidade;
 $$;
--2-crie uma procedure para atualizar o nome do usuario pelo id
select * from usuario;
create or replace procedure atualizar_nome_usuario(
id_usuario integer,
nome_usuario varchar
) language sql
as $$
update usuario
set nome = nome_usuario
where id = id_usuario
$$;

--3-crie uma procedure para excluir um livro pelo id;
delete from livro
where id = 100;
 
 --funcoes - functions
