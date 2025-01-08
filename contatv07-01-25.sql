begin;
CREATE TABLE IF NOT EXISTS CLIENTE(
id serial primary key,
nome varchar(100) not null,
cpf char(11) unique not null,
email varchar(60) unique not null,
telefone varchar(15) null,
data_cadastro date default(current_date)
);

CREATE TABLE IF NOT EXISTS PRODUTO(
id serial primary key,
nome_produto varchar(100) not null,
descricao_detalhada text null,
preco decimal(10, 2) not null check (preco >= 0),
quantidade_estoque int not null check(quantidade_estoque >= 0),
data_cadastro date default current_timestamp
);

CREATE TABLE IF NOT EXISTS FUNCIONARIO(
id serial primary key,
nome varchar(50) not null,
cpf char(11) not null,
cargo varchar(70) not null,
salario_funcionario decimal(10, 2) not null check (salario_funcionario >=0),
data_admissao date not null,
email varchar(50) unique
);

CREATE TABLE IF NOT EXISTS VENDA(
     id SERIAL PRIMARY KEY,                       
    cliente_id INT NOT NULL,                      
    funcionario_id INT,                           
    data_venda TIMESTAMP DEFAULT CURRENT_TIMESTAMP, 
    total_venda DECIMAL(10, 2) NOT NULL CHECK (total_venda >= 0), 
    FOREIGN KEY (cliente_id) REFERENCES cliente (id)             
        ON DELETE CASCADE                                         
        ON UPDATE CASCADE,                                        
    FOREIGN KEY (funcionario_id) REFERENCES funcionario (id)    
        ON DELETE SET NULL                                        
        ON UPDATE CASCADE                 
);

CREATE TABLE IF NOT EXISTS ITENS_VENDA(
id SERIAL PRIMARY KEY,                        
    venda_id INT NOT NULL,                       
    produto_id INT,                              
    quantidade INT NOT NULL CHECK (quantidade > 0), 
    preco_unitario DECIMAL(10, 2) NOT NULL CHECK (preco_unitario >= 0), 
    FOREIGN KEY (venda_id) REFERENCES venda (id) 
        ON DELETE CASCADE                        
        ON UPDATE CASCADE,                       
    FOREIGN KEY (produto_id) REFERENCES produto (id)
        ON DELETE SET NULL                       
        ON UPDATE CASCADE  

);
commit;
rollback;
begin;
INSERT INTO cliente (nome, cpf, email, telefone) 
VALUES 
('João Silva', '12345678901', 'joao.silva@example.com', '(11) 91234-5678'),
('Maria Santos', '98765432100', 'maria.santos@example.com', '(21) 99876-5432'),
('Carlos Oliveira', '55544433322', 'carlos.oliveira@example.com', '(31) 98888-1111'),
('Paula Souza', '44433322211', 'paula.souza@example.com', '(61) 97777-2222'),
('Fernanda Lima', '77788899900', 'fernanda.lima@example.com', NULL);

INSERT INTO produto (nome_produto, descricao_detalhada, preco, quantidade_estoque) 
VALUES 
('Notebook', 'Notebook 14 polegadas, 8GB RAM, 256GB SSD', 3500.00, 10),
('Mouse', 'Mouse óptico sem fio', 120.00, 50),
('Teclado', 'Teclado mecânico com iluminação RGB', 250.00, 30),
('Monitor', 'Monitor LED Full HD 24 polegadas', 800.00, 15),
('Cadeira Gamer', 'Cadeira ergonômica com ajuste de altura', 950.00, 8);

INSERT INTO funcionario (nome, cpf, cargo, salario_funcionario, data_admissao, email) 
VALUES 
('Ana Costa', '11122233344', 'Vendedora', 2500.00, '2022-01-15', 'ana.costa@example.com'),
('Roberto Lima', '22233344455', 'Gerente', 4500.00, '2020-03-01', 'roberto.lima@example.com'),
('Cláudia Martins', '33344455566', 'Caixa', 2000.00, '2023-05-10', NULL),
('Felipe Souza', '44455566677', 'Estoquista', 1800.00, '2021-09-25', 'felipe.souza@example.com'),
('Laura Almeida', '55566677788', 'Supervisora', 4000.00, '2019-11-20', 'laura.almeida@example.com');

INSERT INTO venda (cliente_id, funcionario_id, total_venda) 
VALUES 
(1, 1, 3500.00), -- João comprou um notebook
(2, 2, 120.00),  -- Maria comprou um mouse
(3, 3, 1050.00), -- Carlos comprou dois teclados e um monitor
(4, NULL, 800.00), -- Paula comprou um monitor sem atendimento específico
(5, 5, 950.00);  -- Fernanda comprou uma cadeira gamer

INSERT INTO itens_venda (venda_id, produto_id, quantidade, preco_unitario) 
VALUES 
(1, 1, 1, 3500.00), -- Venda 1: Notebook
(2, 2, 1, 120.00),  -- Venda 2: Mouse
(3, 3, 2, 250.00),  -- Venda 3: 2 Teclados
(3, 4, 1, 800.00),  -- Venda 3: 1 Monitor
(5, 5, 1, 950.00);  -- Venda 5: Cadeira Gamer



--1. Liste o total de vendas realizadas por cada cliente.

    select * from venda;
select cliente.nome, count(venda.cliente_id) as total_venda
from venda
join cliente on venda.id = cliente.id
group by cliente.nome
order by cliente.nome desc;

--2. Liste o total de vendas realizadas por cada funcionário.

       select * from venda;
select funcionario.nome, count(venda.funcionario_id) as total_venda_funcionario
from venda
join funcionario on venda.id = funcionario.id
group by funcionario.nome
order by funcionario.nome desc;
    
--3. Liste a quantidade total de produtos vendidos por cada venda.
 select * from produto;
 select * from venda;--pedido
 select * from itens_venda;--itens do pedido
 select venda_id, sum(quantidade) as quantidade_total_itens
 from itens_venda
 group by venda_id;
 
--4. Liste a quantidade total de itens vendidos por produto.

 select * from venda;
 
 
--5. Liste os clientes que realizaram mais de 5 compras.

  select * from venda;
  select * from itens_venda;
  select * from cliente;

  select cliente.nome , count(venda.cliente_id) 
  from venda
  join itens_venda on venda.cliente_id = itens_venda.venda_id
  join cliente on cliente.id = venda.cliente_id
  group by nome
  having count(venda.cliente_id) >= 1;
  
--6. Liste os produtos que possuem mais de 50 unidades em estoque.

 select * from produto;

 select nome_produto , quantidade_estoque
 from produto
 where quantidade_estoque >= 50
 order by quantidade_estoque desc
 
--7. Liste os funcionários que participaram de mais de 10 vendas.

  select * from venda;
  select funcionario.nome , count(venda.funcionario_id) as total_venda
  from venda
  join funcionario on funcionario.id = venda.funcionario_id
  group by funcionario.nome
  having count(venda.funcionario_id) >= 1;
  
  
--8. Liste os produtos cujo total vendido (quantidade) seja superior a 100
--unidades.
   select * from itens_venda;
   select produto_id , sum(itens_venda.quantidade) as total_produtos
   from itens_venda
   group by produto_id
   having sum(itens_venda.quantidade) > 10
   order by total_produtos desc
   --order by quantidade desc;
   --acrecentando o join
   
    select * from itens_venda;
   select produto.nome_produto , sum(itens_venda.quantidade) as total_produtos
   from itens_venda
   join produto on produto.id = itens_venda.produto_id
   group by produto.nome_produto
   having sum(itens_venda.quantidade) >= 2
   order by total_produtos desc
   
--9. Calcule o valor total das vendas de cada cliente.

   select * from venda;
   select cliente.nome , sum(venda.total_venda) as total_venda
   from venda
   join cliente on cliente_id = venda.cliente_id
   group by cliente.nome
   order by total_venda desc;

   
10.Calcule o valor total das vendas realizadas por cada funcionário.
11.Calcule o total de itens vendidos por venda.
12.Calcule o total de produtos vendidos agrupados por categoria (se
adicionarmos uma coluna de categoria na tabela de produtos).
13.Calcule o total arrecadado com vendas para cada cliente.
14.Calcule o preço médio dos produtos em estoque.
15.Calcule o preço médio dos produtos vendidos por venda.
16.Calcule a média de salários dos funcionários.
17.Calcule a média do total das vendas por funcionário.
18.Conte quantas vendas foram realizadas por cliente.
19.Conte quantas vendas cada funcionário participou.
20.Conte quantos produtos estão cadastrados no banco.
21.Conte quantas vendas foram realizadas em cada dia.
22.Liste os clientes que realizaram mais de 5 compras, ordenados pelo
total de vendas.
23.Liste os produtos mais vendidos (em quantidade) cujo total vendido
ultrapassa 50 unidades.
24.Calcule a média de preço dos produtos vendidos em cada venda.
25.Liste os funcionários que participaram de vendas cujo total médio é
superior a R$ 5.000,00.





select * from produto;
