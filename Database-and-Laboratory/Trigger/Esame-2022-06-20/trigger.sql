/*Sia dato il seguente vincolo aggiuntivo: per passare allo stato attivo (e rimanervi), un progetto debba 
avere un referente. 

Quali operazioni, e su quali tabelle, possono violare tale requisito? Si motivi la risposta. 

(1) inserimento in progetti:    potrebbe venir inserito un progetto con stato attivo ma senza referente.
(2) update in progetti:         potrebbe venir aggiornato il campo referente con un valore null di un 
                                progetto con stato attivo.
(3) cancellazione in progetto:  non da problemi.

(4) inserimento in referenti:   non da problemi.
(5) update in referenti:        non da problemi in quanto e' Progetti(referente) e' chiave esterna di Referenti
                                e il vincolo on update gestisce la violazione (che non avviene).
(6) cancellazione in referenti: da problemi nel caso in cui venga cancellato un referente che ha un
                                progetto nello stato 'attivo'.

Si scelga una delle operazioni individuate e si scriva un trigger SQL che eviti la violazione. 
Infine, si illustrino brevemente due differenze tra un controllo dei vincoli mediante la clausola CHECK, 
in combinazione con user-defined function, e mediante trigger.*/

-- Trigger 1: per evitare la violazione del vincolo durante inserimento in progetti.
create or replace function check_stato()
returns trigger
language plpgsql as
$$
    begin
        if (new.referente is null and new.stato = 'attivo')
        then
            raise exception 'Errore';
            return null;
        else
            raise notice 'new.referente: %, new.stato: %', new.referente, new.stato;
            return new;
        end if;
    end;
$$;

create trigger verifica_stato
    before insert on Progetti
    for each row
    execute procedure check_stato();

insert into Progetti(codice, nome, numDipendenti, referente, stato) values ('6fff2', 'Atene', 12, null, 'attivo'); -- violazione -> deve essere impedita




-- Trigger 2: per evitare la violazione del vincolo durante aggiornamenti in progetti.
create or replace function check_aggiornamento_stato()
returns trigger
language plpgsql as
$$
    begin
        perform *
        from progetti
        where codice = new.codice
        and referente is not null;

        if not found
        then
            raise exception 'Errore: per avere stato attivo, il progetto deve avere un referente';
            return null;
        else
            return new;
        end if;
    end;
$$;

create trigger verifica_aggiornamento_stato
    before update on Progetti
    for each row
    when (old.stato <> new.stato)
    execute procedure check_aggiornamento_stato();

update Progetti set stato = 'attivo' where codice = '1aaa1'; -- ok perche ha un referente
update Progetti set stato = 'attivo' where codice = '4ddd4'; -- no perche non ha un referente