reate or replace function {nome}()
returns trigger 
language plpgsql as
$$
    declare
        -- variabili
    begin
        -- query con select/perform + from + where

        if found  -- found e' una variabile built-in. E' true sse la query precedente ha trovato almeno una tupla
        then 
            raise exception '...';
            return null;    -- annulla l'insermiento/aggiornamento
        else
            return new;     -- inserisce o modifica la nuova tupla
        end if;
    end;
$$

create trigger {NOME}
    {before/after} insert or update on {Nome-tabella}
    for each row
    when ({condizione})
    execute procedure {nome};