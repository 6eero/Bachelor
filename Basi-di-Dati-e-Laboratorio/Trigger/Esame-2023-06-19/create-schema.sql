DROP DATABASE IF EXISTS tabella;
CREATE DATABASE tabella;
\c tabella

/*Si scriva il codice SQL per creare e popolare la relazione T, riportata in Table 1, tenendo conto che l'attributo X è composto
da cinque caratteri ed è la chiave primaria, l'attributo Y è un numero intero non nullo, compreso tra 0 e 30, e l'attributo Z è un 
booleano, che può essere settato a True se e solo se Y = 30*/

create table RelazioneT (
    atrrX char(5) primary key,
    attrY integer check (attrY between 0 and 30) not null,
    attrZ boolean check ((attrZ = true and attrY = 30) or (attrZ = false and attrY <> 30))
);