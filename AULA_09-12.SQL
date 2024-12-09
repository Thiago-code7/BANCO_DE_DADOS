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

insert into filme (nome, id_genero)
values('Batman - o retorno', 3), ('Moana',7),
('Pato Donald', 1), ('Hulk',2),('Tropa de Elite', 6);

insert into GENERO (ID,NOME)
values (6,'Documentario'), (7,'Suspense')
--QUESTÃO 06
select nome from filme where ID_GENERO = 2;
--QUESTÃO 07
select nome from filme where ID_GENERO = 2 or ID_GENERO=4;

