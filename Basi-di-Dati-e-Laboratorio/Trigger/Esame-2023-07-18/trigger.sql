/*si implementi un trigger SQL che gestisca il caso in cui un reperto venga assegnato ad una stanza che
ha gia raggiunto la massima capacita espositiva. In tale situazione, il reperto dovra essere collocato 
automaticamente nel magazzino (in alternativa, l’operazione dovra essere annullata)*/

-- Trigger 1: per impedire di poter inserire un reperto in una sala gia piena
create or replace function valida_inserimento()
returns trigger 
language plpgsql as
$$
    declare
        numero_di_opere_nella_sala integer;
        capacita_massima_sala integer;
    begin

        -- numero di opere gia presenti nella sala
        select count(*) into numero_di_opere_nella_sala
        from reperto
        where collocazione = new.collocazione;

        -- capacita max della sala a cui si sta aggiungendo un reperto
        select capacita_expo into capacita_massima_sala
        from sala
        where codice = new.collocazione;

        if numero_di_opere_nella_sala >= capacita_massima_sala
        then 
            raise notice 'La sala è piena, metto il reperto % nel magazziono.', new.codice;
            -- return null;
            new.collocazione := 100; -- inserisce il reperto nel magazzino
            return new;
        else
            raise notice 'numero_di_opere_nella_sala %: %', new.collocazione, numero_di_opere_nella_sala + 1;
            return new;
        end if;
    end;
$$;

create trigger verifica_capacita_sala
    before insert or update on Reperto
    for each row
    execute procedure valida_inserimento();

insert into Reperto(codice, data_scoperta, data_consegna, collocazione) values ('fd2s1', '2024-01-01', '2024-01-04', 101); -- ok
insert into Reperto(codice, data_scoperta, data_consegna, collocazione) values ('32fxa', '2024-01-01', '2024-01-04', 101); -- ok
insert into Reperto(codice, data_scoperta, data_consegna, collocazione) values ('35gh7', '2024-01-01', '2024-01-04', 101); -- fallisce

update sala set capacita_expo = 4 where codice = '101';

insert into Reperto(codice, data_scoperta, data_consegna, collocazione) values ('35gh7', '2024-01-01', '2024-01-04', 101); -- ok
insert into Reperto(codice, data_scoperta, data_consegna, collocazione) values ('fqp3z', '2024-01-01', '2024-01-04', 101); -- fallisce

insert into Reperto(codice, data_scoperta, data_consegna, collocazione) values ('323sa', '2024-01-01', '2024-01-04', 100);

update Reperto set collocazione = '101' where codice = '323sa'; -- fallisce
