/*Si consideri il seguente vincolo: una squadra di pallavolo deve essere costituita da al piu 13 giocatori e almeno 6.
Quali operazioni, e su quali tabelle, possono violare questo vincolo? 

(1) inserimento in giocatori: se una stessa squadra ha gia 13 giocatori e se ne inserisce uno, il vincolo viene violato.
(2) cancellazione in giocatori: se una stessa squadra ha 6 giocatori e se ne cancella uno, il vincolo viene violato.
(3) aggiornamento in giocatori: il vincolo viene violato due casi:
    (a) si sposta un giocatore in una squadra che ha gia 13 giocatori.
    (b) si sposta uin giocatore da una squadra che ha 6 giocatori.

Si scelga una di queste operazioni e si scriva un trigger SQL che eviti tale violazione*/

create or replace function valida_inserimento()
returns trigger language plpgsql as
$$
    declare 
        count_giocatori integer;
    begin
        select count(*) into count_giocatori
        from giocatori
        where squadra = new.squadra;

        if count_giocatori >= 13
        then
            raise exception 'Squadra al completo';
        else
            raise notice 'Numero giocatori in squadra dopo la nuova aggiunta: %', count_giocatori + 1;
            return new;
        end if;
    end;
$$;

create trigger verifica_inserimento
    before insert on Giocatori
    for each row
    execute procedure valida_inserimento();


insert into Giocatori(num_cartellino, nome, ingaggio, squadra) values ('saf23', 'Ermanno', 11240, 'SiamoFortissimi'); -- falisce perche la squadra siamofortissimi ha gia 13 giocatori

insert into Giocatori(num_cartellino, nome, ingaggio, squadra) values ('saf23', 'Ermanno', 11240, 'ANoiChiCiBatte'); -- ok