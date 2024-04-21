use aparaty;
drop view if exists model_skad;

create view model_skad as
select aparat.model, producent.nazwa, producent.kraj 
as model_skad
from (aparat
join producent on producent.id = aparat.producent);

select * from model_skad;

/*
delete from aparaty.aparat 
where producent in (select id from producent where kraj like 'Maldiwy');
*/

/*
ALTER TABLE producent AUTO_INCREMENT = 16;
insert into producent(nazwa, kraj, liczba_modeli)
values ('nazwa17', 'Madagaskar', 0);


insert into aparat(model, producent, matryca, obiektyw, typ)
values	('k2', 16, floor(rand()*(115-101+1)+101),  floor(rand()*(15-1+1)+1), 'kompaktowy');
*/

/*
select * from aparat
join producent on producent.id = aparat.producent
where producent.kraj like 'Maldiwy';




use aparaty;
drop procedure if exists delete_chiny;
DELIMITER $$
create procedure delete_chiny()
begin
loop_label:  loop
		if  (select count(*) from aparat
				join producent on producent.id = aparat.producent
				where producent.kraj like 'Maldiwy')=0 
		then 
			leave  loop_label;
		else 
			delete from aparaty.aparat where aparat.model = 
				(select model from (select * from(aparat
				join producent on producent.id = aparat.producent)
				where producent.kraj like 'Maldiwy'
				limit 1)as a);
		end if;
	end loop;
end$$
DELIMITER ;
call delete_chiny();
*/