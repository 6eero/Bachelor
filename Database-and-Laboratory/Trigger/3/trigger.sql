/*
si consideri il seguente vincolo: "il direttore di ogni dipartimento deve afferire al dipartimento stesso."

Quali azioni possono violare tale vincolo? 

    Le azioni che possono violarlo sono:

    (1) inserimento su dipartimento -> ogni direttore associato inzialmente e' sbagliato
    (2) modifica su dipartimento -> solo nel caso in cui si cambi il direttore (la modifica del id_dip e' gestita da on update cascade)

    (3) inserimento su ricrecatore -> se e' presente un dip con direttore "A" e "A" non e' presente nei ricercatori, e' possibile inserirlo con afferenza sbagliata
    (4) modifica su ricrecatore -> se aggiorno afferenza ad un ricercatore che e' direttore, la sua afferenz puo diventare incongruente
    (5) cancellazione su ricercatore -> se cancello un ricercatore che era direttore di un dipartimento, allora quel dipartimento si riferira' ad un direttore che non esiste piu


L'aggiornamento di cui sopra puo violarlo?

    No perche Robert Tarjan non era direttore di nessun dipartimento


Si scelga una delle violazioni qui sopra e si scruiva un trigger che ne impedisca la violazione
*/

-- Trigger 1: per impedire violazione durante update del dipartimento
create or replace function valida_direttore()
returns trigger 
language plpgsql as
$$
    declare
        aff_new_direttore varchar(5);
    begin
        select afferenza into aff_new_direttore
        from Ricercatore
        where nome = new.direttore;

        if aff_new_direttore <> new.id_dip
        then 
            raise exception 'il direttore indicato afferisce ad un altro dipartimento';
            return null;    -- annulla l'insermiento/aggiornamento
        else
            return new;     -- inserisce o modifica la nuova tupla
        end if;
    end;
$$;

create trigger direttore_afferente
    before update on Dipartimento
    for each row
    when (new.direttore <> old.direttore) -- il trigger viene attivato solo se la la modifica viene fatta sulla data
    execute procedure valida_direttore();

update dipartimento set direttore = 'Robert Tarjan' where id_dip = 'id000'; -- no



-- Trigger 2: per impedire di poter inserire un Ricercatore (gia presente come direttore in Dipartimento) con dipartimento di afferenza diverso rispetto a quello per cui e' direttore
create or replace function valida_ricercatore()
returns trigger 
language plpgsql as
$$
    declare
        aff_new_ricercatore varchar(5);     -- aff_new_ricercatore deve contenre il dipartimento di cui e' direttore (id_dip)
    begin
        select id_dip into aff_new_ricercatore
        from Dipartimento
        where direttore = new.nome;

        if aff_new_ricercatore <> new.afferenza
        then 
            raise exception 'il direttore indicato e direttore di un altro dipartimento';
            return null;    -- annulla l'insermiento/aggiornamento
        else
            return new;     -- inserisce o modifica la nuova tupla
        end if;
    end;
$$;

create trigger direttore_ricercatore
    before insert on Ricercatore
    for each row
    execute procedure valida_ricercatore();

insert into Ricercatore(nome, eta, afferenza) values ('Lukas Marcovich', 29, 'id111'); -- no
insert into Ricercatore(nome, eta, afferenza) values ('Lukas Marcovich', 29, 'id333'); -- si