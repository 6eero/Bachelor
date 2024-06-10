-- Scrivere un trigger che implementi la specializzazione esclusiva (se il prodotto e' un libro 
-- allora non e' un DVD e viceversa)

-- Trigger su Libro: 
-- Voglio che vieti (before) insermimenti/aggiornamenti (insert or update) su Libro tali che non 
-- rispettino la specializzazione esclusiva. 
-- Devo quindi evitare che esista nella tabella DVD una tupla con id = new.id

create or replace function valida_libro()
returns trigger as
$$
    declare
        dummy integer;
    begin
        select id into dummy
        from DVD
        where id = new.id;

        if found  -- found e' una variabile built-in. E' true sse la query precedente ha trovato almeno una tupla
        then 
            raise exception 'Specializzazione non esclusiva';
            return null;    -- annulla l'insermiento/aggiornamento
        else
            return new;     -- inserisce o modifica la nuova tupla
        end if;
    end;
$$ language plpgsql;

create trigger libro_esclusivo before
insert or update
on Libro
for each row
execute procedure valida_libro();

-- Trigger su DVD: 
-- Voglio che vieti (before) insermimenti/aggiornamenti (insert or update) su DVD tali che non 
-- rispettino la specializzazione esclusiva. 
-- Devo quindi evitare che esista nella tabella Libro una tupla con id = new.id

create or replace function valida_dvd()
returns trigger as
$$
    begin
        perform *   -- ha lo stesso funzionamento di sopra, ma ignora il risultato (utile usarlo con found)
        from Libro
        where id = new.id;

        if found  -- found e' una variabile built-in. E' true sse la query precedente ha trovato almeno una tupla
        then 
            raise exception 'Specializzazione non esclusiva';
            return null;    -- annulla l'insermiento/aggiornamento
        else
            return new;     -- inserisce o modifica la nuova tupla
        end if;
    end;
$$ language plpgsql;

create trigger dvd_esclusivo before
insert or update
on DVD
for each row
execute procedure valida_dvd();

-- Test del funzionamento:
insert into Prodotto(id, titolo) values
    (1, 'I promessi sposi'),
    (2, 'Frozen');

insert into Libro(id, pagine) values
    (1, 349);

insert into DVD(id, durata) values  -- errore -> viene chiamato il trigger che vieta l'inserimento
    (1, 349);
