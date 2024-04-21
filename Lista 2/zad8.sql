use aparaty;

drop trigger if exists delete_matryca_byaparat;

delimiter $$
create trigger delete_matryca_byaparat after delete on aparat
for each row
begin
	 
	IF (select count(*) from aparat where aparat.matryca=old.matryca)=0 THEN
		DELETE FROM aparaty.matryca WHERE (matryca.id = old.matryca);
	
    END IF;
end$$
delimiter ;

DELETE FROM aparaty.aparat WHERE (model = 'k1');
-- DELETE FROM aparaty.aparat WHERE (model = 'k2');


/* 
ALTER TABLE matryca AUTO_INCREMENT = 115;
insert into matryca(przekatna,rozdzielczosc, typ)
values ((round(rand() * 3.99 + 0.01, 2)), (round(rand() * 2.99 + 0.01, 1)), 'typ1');



insert into aparat(model, producent, matryca, obiektyw, typ)
values	('k1', floor(rand()*(15-1+1)+1), 116, floor(rand()*(15-1+1)+1), 'kompaktowy');


/*
drop trigger if exists delete_matryca_byaparat;

delimiter $$
create trigger delete_matryca_byaparat after delete on aparat
for each row
begin
	 
	IF (select matryca.id from matryca where matryca.id = old.matryca) is not null THEN
		DELETE FROM aparaty.matryca WHERE (matryca.id = old.matryca);
	
    END IF;
end$$
delimiter ;

DELETE FROM aparaty.aparat WHERE (model = 'k1');
*/