/*
drop procedure if exists aparat_model;
DELIMITER $$
create procedure aparat_model(out prod int, out mat int, out obiek int, out typs varchar(20))
	begin
    declare x int;
        
	set x = 16;
    
	loop_label:  loop
		if  x = 116 then 
			leave  loop_label;
		else 
			select producent.id into prod from producent order by rand() limit 1;
			select matryca.id into mat from matryca order by rand() limit 1;
			select obiektyw.id into obiek from obiektyw order by rand() limit 1;
			select aparat.typ into typs from aparat group by aparat.typ order by rand() limit 1;
			
            insert into aparat(model, producent, matryca, obiektyw, typ)
			values(concat("m", x), prod, mat, obiek, typs);
            set x = x + 1;
		end if;
	end loop;
	end$$
DELIMITER ;
call aparat_model(@prod, @mat, @obiek, @typs);
*/
select * from aparat;