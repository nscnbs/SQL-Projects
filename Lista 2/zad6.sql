use aparaty;

drop trigger if exists add_producent;

delimiter $$
create trigger add_producent before insert on aparat
for each row
begin
	IF (select id From producent where id=NEW.producent) is null THEN
		insert into producent (id, nazwa, kraj) values (NEW.producent, 'unknown', 'unknown');
	END IF;
end$$
delimiter ;

insert into aparat (model,producent,matryca,obiektyw,typ) 
values ("km1",228,floor(rand()*(115-100+1)+100),floor(rand()*(15-1+1)+1),'inny');