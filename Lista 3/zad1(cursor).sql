drop procedure if exists firma_pracownicy_wypewnienie;

DELIMITER $$

CREATE PROCEDURE firma_pracownicy_wypewnienie()

BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE pes char(11);
    DECLARE d_u date;
    DECLARE state enum('K', 'M');
    declare zawod int unsigned;
    declare wyplata float unsigned;
    
	DECLARE mycursor CURSOR FOR(
		select PESEL, data_urodzenia, plec from ludzie
		where (YEAR(CURRENT_DATE) - YEAR(data_urodzenia))>18); 
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    
    OPEN mycursor;
	
    fetch_loop: LOOP
    FETCH mycursor INTO pes, d_u, state;
	IF done THEN
      LEAVE fetch_loop;
    END IF;
    
    select zawody.zawod_id into zawod from zawody order by rand() limit 1;
    select RAND()*(zawody.pensja_max-zawody.pensja_min)+zawody.pensja_min into wyplata from zawody where zawod_id like zawod;
    if (zawod like '3' 
		and ((YEAR(CURRENT_DATE) - YEAR(d_u))-
				(DATE_FORMAT(CURRENT_DATE, '%m%d') < DATE_FORMAT(d_u, '%m%d')))>65
		and state like 'M') then
			select pes;
	elseif (zawod like '3' 
		and ((YEAR(CURRENT_DATE) - YEAR(d_u))-
				(DATE_FORMAT(CURRENT_DATE, '%m%d') < DATE_FORMAT(d_u, '%m%d')))>60
		and state like 'K') then
			select pes;
    else        
		insert into pracownicy(PESEL, zawod_id, pensja) values
		(pes, zawod, wyplata);
	end if;
  END LOOP;
  CLOSE mycursor;
END$$
DELIMITER ;

call firma_pracownicy_wypewnienie;