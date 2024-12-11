CREATE TABLE IF NOT EXISTS usuarios( 

    id serial primary key, 

    nome varchar(60) NOT NULL, 

    email varchar(100) NOT NULL UNIQUE, 

    senha varchar(16) NOT NULL, 

    data_cadastro DATE DEFAULT(CURRENT_DATE) 

); 

-- QUESTÃO 02 

-- Criação da tabela categorias 

-- Crie a tabela categorias com os seguintes campos: 

 

-- id (chave primária, auto-incrementada) 

-- descricao (obrigatório) e único. 

 

CREATE TABLE IF NOT EXISTS categorias( 

    id serial primary key, 

    descricao varchar(150) NOT NULL UNIQUE 

); 

-- QUestão 03  

-- Criação da tabela transacoes 

-- Crie a tabela transacoes com os seguintes campos: 

 

-- id (chave primária, auto-incrementada) 

-- u/9-musuario_id (chave estrangeira referenciando usuarios) 

-- categoria_id (chave estrangeira referenciando categorias) 

-- tipo (obrigatório, podendo ser 'Receita' ou 'Despesa') 

-- valor (obrigatório) 

-- data (valor padrão: data atual)  

-- descricao (opcional). 

 

create table if not exists transacao(  

id SERIAL primary key,  

id_usuario int,  

id_categoria int, Tipo char(8) not null check (tipo in ('Receita','Despesa')) not null,  

Valor numeric (10,2) not null,  

Data DATE DEFAULT(CURRENT_DATE),  

Descricao text, 
Constraint fk_usuario foreign key (id_usuario) references usuarios(id) on delete cascade,  

Constraint fk_categoria foreign key (id_categoria) references categorias(id) on delete SET NULL ); 

 

 

--Questão 04 -Adicionar constraint para evitar descrições repetidas nas transações 

--Adicione uma constraint que proíba transações do mesmo usuário com a mesma descrição na mesma data. 

 

ALTER TABLE TRANSACAO ADD CONSTRAINT BLOQUEAR_TRANSACAO_REPETIDA UNIQUE (id_usuario, descricao, data); 

 

 

--Adicione uma constraint para proibir que transações do tipo 'Despesa' tenham valor superior a 10.000. 

 

ALTER TABLE TRANSACAO ADD  

CONSTRAINT BLOQUEAR_DESPESA  

CHECK (tipo = 'Receita' or tipo = 'Despesa' AND VALOR <= 10000); 

 

-- Inserir registros na tabela usuarios (3 REGISTROS) 

 

 

Insert into usuarios (id, nome, email, senha) 

Values (1, ’João’, ‘joao@gmail.com’, ‘0123456’), (2, ‘Pedro’, ‘pedro@gmail.com’, ‘1234567’), (3, ‘Gabriel’, ‘gabriel@gmail.com’, ‘23456789’); 

-- Questão 06 Inserir registros na tabela categorias (Salário, Alimentação, Transporte, Educação, Lazer) 

 

 

Insert  into categorias (id, descricao) 

Values (1, ‘Salário’), (2, ‘Alimentação’), (3,’Transporte’), (4,’Educação’), (5,’Lazer’); 

 

--Questão 7 - inserir 3 resgistros em transações usuario 01 valor de R$3000, vinculada à categoria Salário, Receita. 

 

 

Insert into transacao(id_usuario, id_categoria, tipo, valor, descricao) 

Values(1, 1, ‘Receita’, 3000, ‘Salario mensal’), (1, 2, ‘Despesa’, 500, ‘Alimentação’), (1, 2, ‘Despesa’, 1000, ‘Carro’); 

 

Liste todas as transações realizadas pelo usuário João (Trazer o nome e transações) 

 

SELECT * FROM TRANSACAO JOIN  

USUARIOS ON TRANSACAO.id_usuario = USUARIOS.id 

WHERE USUARIOS.NOME =  ‘João’; 

 

Exiba a descrição da categoria e o valor de todas as despesas. 

 

Select categorias.descricao, valor  

From transacoes JOIN 

CATEGORIAS ON id_categoria  = categoria.id 

 

WHERE TIPO = ‘Despesa’; 

 

ÃO 

 

-- Liste todas as transações, ordenando pelo valor em ordem decrescente. (DAVId) 

 

Select *  

from transacao 

Where order by transacao.valor (desc) 

 

-- Calcule o total de despesas registradas. (GABRIEL) 

SELECT (valor) FROM transacao 

WHRE tipo.transacao = despesas; 

 

 

 

 

 

 

 

 

 

 

OI 
