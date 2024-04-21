use firma;
drop procedure if exists firma_ludzie_wypewnienie;
DELIMITER $$
create procedure firma_ludzie_wypewnienie(in count int, in new_pesel char(11), in data_u date)
	begin
    declare x int;
    declare new_imie varchar(30);
    declare new_nazwisko varchar(30);
    declare wyplata float;
    declare new_plec varchar(1);
    declare pewno varchar(2);
    declare data_u_np varchar(20);
        
	set x = 0;
    
	loop_label:  loop
		if  x = count then 
			leave  loop_label;
		else
			set data_u = DATE_ADD(data_u , INTERVAL 15 DAY);
            
            IF ((YEAR(CURRENT_DATE) - YEAR(data_u))-
				(DATE_FORMAT(CURRENT_DATE, '%m%d') < DATE_FORMAT(data_u, '%m%d')))<18 THEN
                set data_u_np = concat(substring(data_u,3,2), substring(data_u,6,2)+20, substring(data_u,9,2));
                set pewno = 'NP';
			ELSEIF ((YEAR(CURRENT_DATE) - YEAR(data_u))-
				(DATE_FORMAT(CURRENT_DATE, '%m%d') < DATE_FORMAT(data_u, '%m%d')))>60 THEN
                set data_u_np = concat(substring(data_u,3,2), substring(data_u,6,2), substring(data_u,9,2));
                set pewno = 'P+';
			ELSE
				set data_u_np = concat(substring(data_u,3,2), substring(data_u,6,2), substring(data_u,9,2));
                set pewno = 'P';
			end if;
            
            
            set new_imie = concat('Imie_', pewno, '_', x+1);
			set new_nazwisko = concat('Nazwisko_', pewno, '_', x+1);
			set new_pesel = concat(substring(data_u,3,2), substring(data_u_np,3,2), substring(data_u,9,2), 
				FLOOR(RAND()*(999-100+1))+100, FLOOR(RAND()*(9-1+1))+1, FLOOR(RAND()*(9-1+1))+1);
			IF (substring(new_pesel,10,1) = "2"
				or substring(new_pesel,10,1) = "4"
				or substring(new_pesel,10,1) = "6"
				or substring(new_pesel,10,1) = "8") THEN
					set new_plec = "K";
			ELSEIF (substring(new_pesel,10,1) = "1"
				or substring(new_pesel,10,1) = "3"
				or substring(new_pesel,10,1) = "5"
				or substring(new_pesel,10,1) = "7"
				or substring(new_pesel,10,1) = "9") THEN
					set new_plec = "M";
			end if;
            
            insert into ludzie (PESEL, imie, nazwisko, data_urodzenia, plec) values 
				(new_pesel, new_imie, new_nazwisko, data_u, new_plec);
            set x = x + 1;
		end if;
	end loop;
	end$$
DELIMITER ;
call firma_ludzie_wypewnienie(5, "04210131234", "2004-01-01");
call firma_ludzie_wypewnienie(45, "95120113245", "1995-12-01");
call firma_ludzie_wypewnienie(5, "45020112311", "1945-02-01");


/*
insert into zawody(nazwa, pensja_min, pensja_max) values
	('Polityk', 6000.00, 15000.00),
    ('Nauczyciel', 4500.00, 10000.00),
    ('Lekarz', 6000.00, 15000.00),
    ('Informatyk', 5500.00, 20000.00);
*/