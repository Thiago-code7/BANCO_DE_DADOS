begin;
create table autor(
 id serial primary key,
    nome varchar(50) not null,
    data_nascimento date,
  constraint chk_data_nascimento check (data_nascimento <= current_date)
);


create table livro(
id serial primary key,
id_autor int,
titulo varchar(80) not null,
ano_publicacao smallint,
constraint fk_autor_livro foreign key (id_autor) references autor(id),
constraint chk_ano_publicacao check (ano_publicacao >= 1500 and ano_publicacao <= extract(year from current_date))
);


create table usuario(
 id serial primary key,
 nome varchar(100) not null,
 email varchar(50) unique not null,
 data_adesao date,
 constraint chk_data_adesao check (data_adesao <= current_date)
);

create table emprestimo(
 id serial primary key,
 id_livro integer,
 id_usuario integer,
 data_emprestimo date not null,
 data_devolucao date not null,
 constraint fk_livro foreign key (id_livro) references livro(id),
 constraint chk_data_emprestimo check(data_emprestimo <= data_devolucao),
 constraint uq_livro_emprestimo unique(id_livro,data_emprestimo)
);
commit;
--criando inserções;
begin;
insert into autor (nome,data_nascimento)
values ('paulo josé','1980-08-05'),
       ('ana paula', '1978-10-10'),
	   ('joão pedro', '1990-02-08'),
	   ('ramom freitas', '2001-09-05'),
	   ('joana maria','1966-07-10');
commit;
begin;  
insert into livro(id_autor,titulo,ano_publicacao)
values (6,'a montanha', 1945),
(7,'a menina que roubava livros', 1998),
(8,'vermelho e branco', 2009),
(9,'passaro verde', 1970),
(10,'casa amarela', 1958 );
commit;
rollback;


begin;
insert into usuario (nome, email, data_adesao)
values('mario', 'mario@email.com', '2024-12-09'),
('renata', 'renata@email', '2019-11-08'),
('paula roberta', 'paularoberta@email.com','2022-02-02'),
('carlos', 'carlos@email.com', '2024-08-09'),
('flavio', 'flavio@email.com', '2022-01-13');
select*from usuario;
select*from livro;
select*from autor;
begin;
--isercao da tabela emprestimo;
insert into emprestimo(id_livro, id_usuario, data_emprestimo, data_devolucao)
values(1,1,'2024-06-15','2024-08-15'),
      (2,2,'2024-07-09','2024-09-09'),
	  (3,3,'2024-08-10','2024-10-10'),
	  (4,4,'2024-09-17','2024-11-04'),
	  (5,5,'2024-10-16','2024-12-09');
commit;
select*from emprestimo;
--listar autor
select*from autor;
select*from livro;
select*from emprestimo;
--listar livro
--liste todos os livros com seus respectivos autores;
select livro.titulo, autor.nome from autor
join livro on livro.id_autor = autor.id;
--liste os usuarios e seus emails
select nome, email from usuario;
--mostre todos emprestimos realizados,incluindo as
--informacoes do livro, do usuarios e datas
select usuario.nome, emprestimo.data_emprestimo,emprestimo.data_devolucao from emprestimo
join livro on id_livro = livro.id
join usuario on id_usuario = usuario.id;

--liste os livros que ainda nao foram devolvidos;
select livro.titulo, emprestimo.data_devolucao from emprestimo
join livro on id_livro = livro.id
where data_devolucao = null;

--18encontre os usuarios que pegaram
--emprestado livros do autor
-- "um dos seus autores"
select usuario.nome as nome_usuario, livro.titulo
from emprestimo
join livro on id_livro = livro.id
join usuario on id_usuario = usuario.id
join autor on id_autor = autor.id
where autor.nome = 'paulo josé';
