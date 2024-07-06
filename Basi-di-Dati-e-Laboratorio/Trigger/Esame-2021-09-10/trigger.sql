/*Si consideri il seguente vincolo: la gradazione di ogni botte contenente vino rosso non puo superare i 17 gradi. Si
scriva un trigger che eviti ogni operazione di aggiornamento sulla tabella Botti che violi tale vincolo.*/

create or replace function valida_aggiornamento()
returns trigger
language plpgsql as
$$
    begin
        if new.gradazione > 17
        then
            raise exception 'Errore';
            return null;
        else
            return new;
        end if;
    end;
$$;

create trigger verifica_aggiornamenti
    before update on Botti
    for each row
    when (new.gradazione <> old.gradazione)
    execute procedure valida_aggiornamento();

update Botti set gradazione = 48 where codice = 0001; -- violazione

update Botti set gradazione = 8 where codice = 0001; -- ok