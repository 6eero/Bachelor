/*Successivamente, si assuma che venga specificato un nuovo vincolo: un allevatore, per essere tale, debba necessariamente 
allevare almeno un bovino. Qualora violi tale vincolo, un allevatore non potrà essere presente nella base di dati (ad esempio, 
nel caso delle tabelle sopra riportate, il vincolo risulta violato dall’allevatore Luca Bianchi).

Si identifichino le operazioni (inserimento, cancellazione, modifica) sulle tabelle bovino e allevatore che diventano problematiche 
in ragione del nuovo vincolo, motivando la risposta.

(1) inserimento in Allevatore: viola il vincolo quando in Bovino non e' presente alcun bovino che ha lui come allevatore.
(2) canecellazione in Bovino: cancellando tutti i bovini di un allevatore esso rimane senza.
(3) modifica in Bovino: modificando tutti gli allevatori con lo stesso cf in un bovino puo accadere che un allevatore resti senza.

Si noti come la modifica in Allevatore non sia problematica: 
    update allevatore set cf = 'LCUBCH82C09L195L' where cf = 'MRCRSS88E17A757Y';
    ERROR:  duplicate key value violates unique constraint "allevatore_pkey"
    DETAIL:  Key (cf)=(LCUBCH82C09L195L) already exists.

Infine, si implementi un trigger SQL che gestisca una delle operazioni identificate.*/

--  Trigger 1: modifica in Bovino: modificando tutti gli allevatori con lo stesso cf in un bovino puo accadere che un allevatore resti senza.
create or replace function valida_aggiornamento()
returns trigger language plpgsql as
$$
    begin           -- se esistono almeno due bovinio con codice diverso appartenenti allo stesso allevatore
        perform * 
        from bovino b1 
        where b1.allevatore = new.allevatore
        and exists (
            select * 
            from bovino b2 
            where b1.allevatore = b2.allevatore 
            and b1.codice <> b2.codice
        );

        if found 
        then
            raise exception 'Errore';
            return null;
        else
            return new;
        end if;

    end;
$$;

create trigger impedisci_aggiornamento
    before update on Bovino
    for each row 
    when (old.allevatore <> new.allevatore)
    execute procedure valida_aggiornamento();



update bovino set allevatore = 'LCUBCH82C09L195L' where codice = 'c12a1';

update Bovino set allevatore = 'MRCRSS88E17A757Y' where codice = 'c12a1'; -- fallisce
update Bovino set allevatore = 'LCUBCH82C09L195L' where codice = 'abb23'; -- ok
update Bovino set allevatore = 'LCUBCH82C09L195L' where codice = 'aaaa1'; -- fallisce
update Bovino set allevatore = 'MRCRSS88E17A757Y' where codice = 'abb23'; -- ok