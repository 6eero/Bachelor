drop database if exists prodotti;
create database prodotti;
\c prodotti


-- creazione delle tabelle
create table prodotto (
   cod_prodotto varchar(50) primary key,
   cod_produttore int,
   tipologia varchar(50),
   prezzo_unitario decimal(10, 2)
);


create table cliente (
   cod_cliente int primary key,
   telefono varchar(15),
   email varchar(50),
   settore varchar(50)
);


create table fornisce (
   cod_cliente int,
   cod_prodotto varchar(50),
   primary key (cod_cliente, cod_prodotto),
   foreign key (cod_cliente) references cliente(cod_cliente),
   foreign key (cod_prodotto) references prodotto(cod_prodotto)
);


-- popolazione delle tabelle con dati fittizi
insert into prodotto (cod_prodotto, cod_produttore, tipologia, prezzo_unitario) values
('prodotto_1', 101, 'elettronica', 199.99),
('prodotto_2', 102, 'elettrodomestici', 499.99),
('prodotto_3', 101, 'elettronica', 299.99),
('prodotto_4', 103, 'mobili', 899.99),
('prodotto_5', 104, 'abbigliamento', 59.99);


insert into cliente (cod_cliente, telefono, email, settore) values
(1, '1234567890', 'cliente1@example.com', 'retail'),
(2, '0987654321', 'cliente2@example.com', 'wholesale'),
(3, '1112223333', 'cliente3@example.com', 'e-commerce'),
(4, '4445556666', 'cliente4@example.com', 'service'),
(5, '7778889999', 'cliente5@example.com', 'retail');


insert into fornisce (cod_cliente, cod_prodotto) values
(1, 'prodotto_1'),
(1, 'prodotto_3'),
(2, 'prodotto_2'),
(2, 'prodotto_4'),
(3, 'prodotto_1'),
(3, 'prodotto_3'),
(3, 'prodotto_5'),
(4, 'prodotto_3'),
(5, 'prodotto_5');


