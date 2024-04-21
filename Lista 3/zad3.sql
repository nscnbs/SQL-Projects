use firma;
drop procedure if exists firma_pensja_podwyzka;

DELIMITER $$
create procedure firma_pensja_podwyzka(in def_nazwa varchar(30))
BEGIN
	declare ilosc_ogolna int;
    declare ilosc_war int;
    
	select count(*) into ilosc_ogolna from (zawody
	join pracownicy on pracownicy.zawod_id = zawody.zawod_id)
	where zawody.nazwa = def_nazwa;
    
    select count(*) into ilosc_war from (zawody
	join pracownicy on pracownicy.zawod_id = zawody.zawod_id)
	where zawody.nazwa like def_nazwa
		and (105*pracownicy.pensja/100) > zawody.pensja_min 
		and (105*pracownicy.pensja/100) < zawody.pensja_max;
    
    set autocommit = 0;
	START TRANSACTION;
		UPDATE firma.pracownicy SET pensja = (105*pracownicy.pensja/100)  
        WHERE pracownicy.zawod_id = (select zawod_id from zawody where nazwa = def_nazwa having ilosc_ogolna = ilosc_war) limit 100;
	COMMIT;
END$$;
DELIMITER ;

call firma_pensja_podwyzka("Informatyk");

/*
DELIMITER $$
create procedure firma_pensja_podwyzka(in nazwa_z varchar(30))
	BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE pes char(11);
    declare id int unsigned;
    declare wyplata float unsigned;
    declare wyplata_min float unsigned;
    declare wyplata_max float unsigned;
    
    
	DECLARE mycursor CURSOR FOR(
		select pracownicy.PESEL, pracownicy.zawod_id, pracownicy.pensja, zawody.pensja_min, zawody.pensja_max from (zawody
		join pracownicy on pracownicy.zawod_id = zawody.zawod_id)
		where pracownicy.zawod_id like id
        order by pracownicy.pensja desc);
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    
    select zawod_id into id from zawody where nazwa_z like zawody.nazwa;
    
    OPEN mycursor;
	
    fetch_loop: LOOP
    FETCH mycursor INTO pes, id, wyplata, wyplata_min, wyplata_max;
	IF done THEN
      LEAVE fetch_loop;
    END IF;
    if ((105*wyplata/100)>wyplata_min 
		and (105*wyplata/100)<wyplata_max)then
			UPDATE firma.pracownicy SET pensja = (105*wyplata/100)  WHERE (PESEL = pes);
	else
		signal sqlstate "11111"
		set message_text = "Nikt nie dostanie podwyzki, jeden ma wiecej od max pensji";
    end if;
  END LOOP;
  CLOSE mycursor;
END$$
DELIMITER ;
call firma_pensja_podwyzka("Informatyk");
*/