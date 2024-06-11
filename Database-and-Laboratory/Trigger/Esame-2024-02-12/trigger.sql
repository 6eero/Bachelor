/*Si consideri il seguente vincolo: 

"per un’auto, gli intervalli di tempo definiti dalle date di inizio e di fine dei
relativi servizi non possono sovrapporsi"

Quali operazioni possono violare questo vincolo? Si scelga una di
queste operazioni e si scriva un trigger SQL che eviti tale violazione.

(1) inserimento di un servizio -> a.e. per l'auto 'AA123BB' esiste gia una servizio di riparazione da 2024-01-01 a 2024-01-06,
    innserire un secondo servizio di qualsasi tipo tra 2024-01-01 e 2024-01-06 violerebbe il vincolo.

(2) modifica di un servizio -> allo stesso modo dell'inserimento, se per l'auto 'AA123BB' esiste gia una servizio di riparazione 
    da 2024-01-01 a 2024-01-06, modificare un secondo servizio per la stessa auto nel periodo tra 2024-01-01 e 2024-01-06 violerebbe 
    il vincolo.*/

-- Trigger 1: per impedire di poter inserire un servizio per un'auto gia occupata
create or replace function valida_servizio()
returns trigger 
language plpgsql as
$$
    declare
        adate_new_ricercatore date;
    begin
        perform *
        from Servizio
        where id = new.id
        and (
            (new.data_inizio > data_inizio and new.data_fine < data_fine) or                                    -- interamente contenuto
            (new.data_inizio < data_inizio and new.data_fine > data_inizio and new.data_fine < data_fine) or    -- inizia prima, finisce durante
            (new.data_inizio > data_inizio and new.data_inizio < data_fine and new.data_fine > data_fine)       -- inizia durante, finisce dopo
        );

        if found
        then 
            raise exception 'Auto occupata durante le date inserite';
            return null;
        else
            return new;
        end if;
    end;
$$;

create trigger verifica_date_inserimento
    before insert on Servizio
    for each row
    execute procedure valida_servizio();



insert into Servizio(id, tipo, data_inizio, data_fine, auto) values (2, 'sostituzione', '2024-03-01', '2024-03-04', 'AA123BB'); -- ok
insert into Servizio(id, tipo, data_inizio, data_fine, auto) values 
    (2, 'sostituzione', '2024-03-02', '2024-03-03', 'AA123BB'), -- interamente contenuto -> no
    (2, 'sostituzione', '2024-02-25', '2024-03-03', 'AA123BB'), -- inizia prima, finisce durante -> no
    (2, 'sostituzione', '2024-02-25', '2024-03-03', 'AA123BB'); -- inizia durante, finisce dopo -> no

