/*Si consideri il seguente vincolo: un esopianeta non puo orbitare attorno ad una stella che e' una supergigante
rossa. Quali operazioni, e su quali tabelle, possono violare questo vincolo? Si scelga una di queste operazioni 
e si scriva un trigger SQL che eviti tale violazione.

(1) inserimento in Esopianeti: nel caso in cui venga inserito un esopianeta con nome = stella.
(2) aggiornamento in Esopianeti: nel caso in cui venga aggiornato un esopianeta con nome = stella.
(3) cancellazione in Esopianeti: non da problemi.

(1) inserimento in Stelle: non da problemi
(2) aggiornamento in Stelle: da problemi per via di on update cascade
(3) cancellazione in Stelle: non da problemi

*/

create or replace function valida_inserimento()
returns trigger
language plpgsql as
$$
    begin
        if new.nome = new.stella_alla_quale_orbita
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

insert into Stelle(nome, classificazione) values
    ('sus', 'nana gialla');

insert into Esopianeti(nome, stella_alla_quale_orbita, ESI, distanza_dalla_terra) values
    ('sus', 'sus', 0.23, 16);