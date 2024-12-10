
create table if not exists GENERO(
ID SERIAL primary key,
NOME VARCHAR(50) not null unique
); 

create table if not exists FILME(
ID SERIAL primary key,
NOME VARCHAR(60) not null,
ID_GENERO INT not null,
constraint FK_GENERO_FILME foreign key (ID_GENERO) references GENERO(ID)
);

insert into genero (nome)
values ('Animação'), ('Terror'),('Ação'), ('Drama'),('Comédia');

insert into filme(nome, id_genero)
values ('Batman', 3), ('The Battle of the Dark River', 3),
('White Duck', 1), ('Breaking Barriers', 4), ('The Two Hours', 2);

--questão03, criar cinco registros na tabela filme
insert into filme (nome, id_genero)
values('Batman - o retorno', 3), ('Moana',7),
('Pato Donald', 1), ('Hulk',2),('Tropa de Elite', 6);

--questão04, criar dois registros na tabela genero
insert into GENERO (ID,NOME)
values (6,'Documentario'), (7,'Suspense');

--questão05, retorna todos os filmes do genero terror.
select NOME
from FILME
where ID_GENERO = (select id from GENERO where nome = 'Terror');

--questão06, retornar todos os filmes do genero terror ou drama
select nome from filme where ID_GENERO = (select id from genero where nome = 'Terror')
OR ID_GENERO = (select id from genero where nome = 'Drama');

select nome from filme where ID_GENERO = 

select nome from filme where ID_GENERO = 6 OR ID_GENERO = 7;

--questão07, retornar todos os filmes
select * from FILME;
--questão08, retornar todos os generos.
select * from GENERO;

--questão09, retornar todos os filmes que comecem com a letra T.
select * from FILME where nome like  'T%';

select * from FILME where nome like  'M%';
--questão 10, atualizar todos os filmes do genero acão para drama.
update FILME
set id_genero=4
where id_genero=3

update FILME
set id_genero = (select id from genero where nome = 'Ação')
where id_genero = (select id from genero where nome = 'Drama');
--questão 11, criar uma comnsulta que retorne o nome de todos os filmes e o nome do genero.
select FILME.NOME AS NOME_DO_FILME ,  GENERO.NOME AS GENERO from FILME, GENERO
where ID_GENERO = GENERO.ID order by FILME.NOME;

select FILME.NOME AS FILME_NOME, GENERO.NOME AS GENERO_NOME
from FILME JOIN GENERO ON FILME.ID_GENERO = GENERO.ID order by FILME.NOME;
--questão 12, deletar todos os filmes do genero ação.
DELETE FROM FILME 
WHERE ID_GENERO = (SELECT ID FROM GENERO WHERE NOME = 'Ação');

