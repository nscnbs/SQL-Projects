-- alter table producent 
-- add liczba_modeli int not null;

drop procedure if exists update_liczba_modeli;

DELIMITER $$
create procedure update_liczba_modeli()
begin

declare x int;
        
	set x = 1;

loop_label:  loop
		if  x >= (select count(id) from producent)+1 
		then 
			leave  loop_label;
		else
			if (select(select count(aparat.model) from aparat 
						group by aparat.producent
						having producent = x) as a) is null 
			then
				update producent
				set liczba_modeli = 0
				where producent.id = x; 
				set x=x+1;
			else
				update producent
				set liczba_modeli = 
					(select(select count(aparat.model) from aparat 
							group by aparat.producent
							having producent = x) as a)
				where producent.id = x; 
				set x = x + 1;
			end if;
		end if;
	end loop;
end$$
DELIMITER ;

call update_liczba_modeli();

drop trigger if exists checkI_liczba_modeli;
delimiter $$
create trigger checkI_liczba_modeli after insert on aparat
for each row
begin
	call update_liczba_modeli();
end$$
delimiter ;

drop trigger if exists checkU_liczba_modeli;
delimiter $$
create trigger checkU_liczba_modeli after update on aparat
for each row
begin
	call update_liczba_modeli();
end$$
delimiter ;

drop trigger if exists checkD_liczba_modeli;
delimiter $$
create trigger checkD_liczba_modeli after delete on aparat
for each row
begin
	call update_liczba_modeli();
end$$
delimiter ;

/*
drop trigger if exists checkI_liczba_modeli;
drop trigger if exists checkU_liczba_modeli;
drop trigger if exists checkD_liczba_modeli;
*/

/*
drop trigger if exists checkI_liczba_modeli;
delimiter $$
create trigger checkI_liczba_modeli after insert on aparat
for each row
begin
	update producent set liczba_modeli=liczba_modeli+1 where id=NEW.producent and liczba_modeli is not null;
    update producent set liczba_modeli=1 where id=NEW.producent and liczba_modeli is null;
end$$
delimiter ;

drop trigger if exists checkU_liczba_modeli;
delimiter $$
create trigger checkU_liczba_modeli after update on aparat
for each row
begin
	update producent set liczba_modeli=liczba_modeli-1 where id=OLD.producent;
    update producent set liczba_modeli=liczba_modeli+1 where id=NEW.producent;
end$$
delimiter ;

drop trigger if exists checkD_liczba_modeli;
delimiter $$
create trigger checkD_liczba_modeli after delete on aparat
for each row
begin
	update producent set liczba_modeli=liczba_modeli-1 where id=OLD.producent;
end$$
delimiter ;
*/