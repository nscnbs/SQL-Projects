/*
create table aparat(
model varchar(30) not null primary key,
producent int unsigned not null, 
matryca int unsigned not null,					
obiektyw int unsigned not null,
typ enum('kompaktowy', 'lustrzanka', 'profesjonalny', 'inny') not null);

create table matryca(
id int unsigned not null auto_increment primary key,
przekatna decimal(4,2) unsigned not null, 
rozdzielczosc decimal(3,1) unsigned not null,					
typ varchar(10) not null);

create table obiektyw(
id int unsigned not null auto_increment primary key,
model varchar(30) not null, 
minPrzeslona float unsigned not null,					
maxPrzeslona float unsigned not null,
check (minPrzeslona<maxPrzeslona));

create table producent(
id int unsigned not null auto_increment primary key,
nazwa varchar(50),
kraj varchar(20));

alter table matryca auto_increment = 101;
alter table aparat add foreign key(matryca) references matryca(id);
alter table aparat add foreign key(obiektyw) references obiektyw(id);
alter table aparat add foreign key(producent) references producent(id);
*/

use aparaty;

show tables from aparaty;
select * from aparat;
select * from matryca;
select * from obiektyw;
select * from producent;

/*
use aparaty;
drop table aparat;
drop table matryca;
drop table obiektyw;
drop table producent;
*/

