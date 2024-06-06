-- QUERY 1: i clienti a cui vengono forniti solo prodotti di un’unica tipologia

-- non esistono due prodotti di tipologia diversa che vengono fortniti ad uno stesso cliente
-- (i) esiste un prodotto che viene fornito ad un cliente 
-- (ii) non esiste un prodotto di tipologia diversa fornito allo stesso cliente

create view forniscee as 
select f.cod_cliente, f.cod_prodotto, p.tipologia from fornisce f, prodotto p where f.cod_prodotto = p.cod_prodotto;

select cod_cliente
from forniscee f1
where exists (
    select *
    from forniscee p1
    where p1.cod_prodotto = f1.cod_prodotto
    and not exists (
        select *
        from forniscee p2
        where p2.tipologia <> p1.tipologia
        and p2.cod_cliente = f1.cod_cliente
    )
);


-- QUERY 2: i clienti a cui viene fornito il maggior numero di prodotti;

create view numero_prodottiforniti as 
select cod_cliente, count(*) as prodottiforniti
from fornisce
group by cod_cliente;

select *
from numero_prodottiforniti n1
where not exists (
    select *
    from numero_prodottiforniti n2
    where n1.cod_cliente <> n2.cod_cliente
    and n2.prodottiforniti > n1.prodottiforniti
);


-- QUERY 3: le coppie (produttore,cliente) tali che il produttore fornisca a quel cliente tutti e soli i prodotti di quel produttore.

-- (i) non esistono due prodotti diversi che vengono forniti dallo stesso produttore allo stesso cliente
-- (ii) non esiste 

select p1.cod_produttore, p1.cod_prodotto, f1.cod_cliente
from prodotto p1, fornisce f1
where p1.cod_prodotto = f1.cod_prodotto
and not exists (
    select *
    from prodotto p2, fornisce f2
    where p2.cod_prodotto <> p1.cod_prodotto
    and p2.cod_produttore = p1.cod_produttore
    and f2.cod_cliente = f1.cod_cliente
);