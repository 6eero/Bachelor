/*Si consideri il seguente vincolo: un esopianeta non puo orbitare attorno ad una stella che e' una nana
rossa. Quali operazioni, e su quali tabelle, possono violare questo vincolo? Si scelga una di queste operazioni 
e si scriva un trigger SQL che eviti tale violazione.

(1) inserimento in Esopianeti: nel caso in cui venga inserito un esopianeta che orbita attorno una stella che e' nana rossa.
(2) aggiornamento in Esopianeti: nel caso in cui venga aggiornato un esopianeta impostando che orbiti attorno una stella che e' nana rossa.
(3) cancellazione in Esopianeti: non da problemi.

(1) inserimento in Stelle: non da problemi
(2) aggiornamento in Stelle: da problemi per via di on update cascade
(3) cancellazione in Stelle: non da problemi

*/

-- Trigger per gestire inserimento in Esopianeti
create or replace function valida_inserimento()
returns trigger
language plpgsql as
$$
    declare
        new_stella_alla_quale_orbita varchar(50);

    begin
        select classificazione into new_stella_alla_quale_orbita
        from stelle 
        where nome = new.stella_alla_quale_orbita;

        if new_stella_alla_quale_orbita = 'nana rossa'
        then
            raise exception 'Errore';
            return null;
        else
            return new;
        end if;
    end;
$$;

create trigger verifica_inserimento
    before insert on Esopianeti
    for each row
    execute procedure valida_inserimento();

insert into Esopianeti(nome, stella_alla_quale_orbita, ESI, distanza_dalla_terra) values    -- fallisce
    ('Esoos t2', 'teegarden', 0.23, 16);

insert into Esopianeti(nome, stella_alla_quale_orbita, ESI, distanza_dalla_terra) values    -- ok
    ('Esoos t1', 'antares', 0.23, 16);