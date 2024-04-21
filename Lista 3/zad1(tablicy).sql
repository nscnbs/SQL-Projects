
use firma;
drop table if exists pracownicy;
drop table if exists ludzie;
drop table if exists zawody;

create table ludzie(
PESEL char(11) not null primary key,
imie varchar(30) not null, 
nazwisko varchar(30) not null,					
data_urodzenia date,
plec enum('K', 'M') not null);

create table zawody(
zawod_id int unsigned not null auto_increment primary key,
nazwa varchar(50) not null,
pensja_min float unsigned,
pensja_max float unsigned,
check (pensja_min<pensja_max));

create table pracownicy(
PESEL char(11) not null primary key,
zawod_id int unsigned not null,
pensja float unsigned);


-- alter table pracownicy add foreign key(PESEL) references ludzie(PESEL);
-- alter table pracownicy add foreign key(zawod_id) references zawody(zawod_id);

