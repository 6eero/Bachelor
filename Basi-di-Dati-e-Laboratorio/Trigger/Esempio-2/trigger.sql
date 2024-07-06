-- Trigger: la data di disponibilita di un prodotto da parte di un fornitore non deve essere anteriore alla 
--          data d'inizio contratto di quel fornitore.

create or replace function verifica_data_disponibilita()
returns trigger 
language plpgsql as
$$
    begin
        -- query con select/perform + from + where
        perform *
        from Fornitore
        where codice = new.fornitore 
        and new.data < data_contratto;

        if found  -- found e' una variabile built-in. E' true sse la query precedente ha trovato almeno una tupla
        then 
            raise exception 'la data di disponibilita di un prodotto da parte di un fornitore non deve essere anteriore alla data di inizio contratto di quel fornitore.';
            return null;    -- annulla l'insermiento/aggiornamento
        else
            return new;     -- inserisce o modifica la nuova tupla
        end if;
    end;
$$;

-- trigger per l'inserimento
create trigger controllo_insert_data_disponibilita
    before insert on Disponibilita
    for each row
    execute procedure verifica_data_disponibilita();

-- trigger per l'aggiornamento
create trigger controllo_update_data_disponibilita
    before update on Disponibilita
    for each row
    when (new.data <> old.data) -- il trigger viene attivato solo se la la modifica viene fatta sulla data
    execute procedure verifica_data_disponibilita();


insert into fornitore(codice, data_contratto) values 
    (1, '2024-7-19');

insert into prodotto(codice, tipo) values 
    (1, 'cibo'),
    (2, 'giocattoli'),
    (3, 'sport');

insert into disponibilita(fornitore, prodotto, data) values 
    (1, 1, '2024-7-20'), -- ok '2024-7-20' > '2024-7-19'
    (1, 3, '2024-7-20'); -- ok '2024-7-20' > '2024-7-19'
    
update disponibilita set data = '2024-07-21' where prodotto = 3 and data = '2024-07-20'; -- ok

update disponibilita set data = '2024-07-18' where prodotto = 3 and data = '2024-07-21'; -- no
insert into disponibilita(fornitore, prodotto, data) values (1, 2, '2024-7-18'); -- non va bene '2024-7-18' < '2024-7-19'




-- trigger per impedire di poter modificare un contratto di un fornitore con una data precedente al primo prodotto che ha fornito
create or replace function verifica_data_contratto()
returns trigger 
language plpgsql as
$$
    begin
        -- query con select/perform + from + where
        perform *
        from Disponibilita
        where fornitore = new.codice 
        and new.data_contratto > data;

        if found  -- found e' una variabile built-in. E' true sse la query precedente ha trovato almeno una tupla
        then 
            raise exception 'il fornitore non puo avere come data di inizio contratto una data precedente al primo prodotto che ha fornito';
            return null;    -- annulla l'insermiento/aggiornamento
        else
            return new;     -- inserisce o modifica la nuova tupla
        end if;
    end;
$$;

create trigger controllo_data_contratto
    before update on Fornitore
    for each row
    when (new.data_contratto <> old.data_contratto) -- il trigger viene attivato solo se la la modifica viene fatta sulla data
    execute procedure verifica_data_contratto();

update Fornitore set data_contratto = '2024-07-20' where codice = 1 and data_contratto = '2024-07-19'; -- si
update Fornitore set data_contratto = '2024-07-28' where codice = 1 and data_contratto = '2024-07-20'; -- no