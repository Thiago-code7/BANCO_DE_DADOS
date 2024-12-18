begin;
create table autor(
 id serial primary key,
    nome varchar(50) not null,
    data_nascimento date,
  constraint chk_data_nascimento check (data_nascimento <= current_date)
);


create table livro(
id serial primary key,
id_autor integer,
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
 id_livro integer not null,
 id_usuario integer,
 data_emprestimo date not null,
 data_devolucao date not null,
 constraint fk_livro foreign key (id_livro) references livro(id),
 constraint fk_usuario foreign key(id_usuario) references usuario(id),
 constraint chk_data_entrega check(data_emprestimo <= data_devolucao),
 constraint
 );



 
 


);

