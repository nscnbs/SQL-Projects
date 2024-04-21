use firma;
drop trigger if exists pesel_ludzie_insert_check;
drop trigger if exists pesel_ludzie_update_check;
drop trigger if exists pesel_pracownicy_insert_check;
drop trigger if exists pesel_pracownicy_update_check;

DELIMITER $$
create trigger pesel_ludzie_insert_check before insert on ludzie for each row
begin
	DECLARE r_pesel varchar(2);
	DECLARE m_pesel varchar(2);
	DECLARE d_pesel varchar(2);
	DECLARE p_pesel varchar(1);
    declare data_u date;
    
    SET r_pesel = substring(NEW.PESEL,1,2);
    SET m_pesel = substring(NEW.PESEL,3,2);
    SET d_pesel = substring(NEW.PESEL,5,2);
    SET p_pesel = substring(NEW.PESEL,10,1);
    set data_u = new.data_urodzenia;
    
    IF (LENGTH(NEW.PESEL)) != 11 THEN          
			signal sqlstate "11111"
			set message_text = "PESEL ma 11 symbolow";
    ELSEIF (substring(NEW.data_urodzenia,3,2) != r_pesel) THEN
				signal sqlstate "11111"
				set message_text = "PESEL sie nie zgadza z data(rok)";        
	IF ((YEAR(CURRENT_DATE) - YEAR(data_u))-
				(DATE_FORMAT(CURRENT_DATE, '%m%d') < DATE_FORMAT(data_u, '%m%d')))<18 THEN
		IF (substring(NEW.data_urodzenia,6,2) != m_pesel+20) THEN
			signal sqlstate "11111"
			set message_text = "PESEL sie nie zgadza z data(miesac)";
		end if;
	ELSE
		IF (substring(NEW.data_urodzenia,6,2) != m_pesel+20) THEN
				signal sqlstate "11111"
				set message_text = "PESEL sie nie zgadza z data(miesac)";
		end if;
	end if;
			
	ELSEIF (substring(NEW.data_urodzenia,9,2) != d_pesel) THEN
				signal sqlstate "11111"
				set message_text = "PESEL sie nie zgadza z data(dzien)";
			
	ELSEIF (NEW.plec = "K"
		and p_pesel not like "2"
		and p_pesel not like "4"
		and p_pesel not like "6"
		and p_pesel not like "8") THEN
			signal sqlstate "11111"
			set message_text = "Niepoprawny PESEL dla K";
    ELSEIF (NEW.plec = "M"
		and p_pesel not like "1"
		and p_pesel not like "3"
		and p_pesel not like "5"
		and p_pesel not like "7"
		and p_pesel not like "9") THEN
			signal sqlstate "11111"
			set message_text = "Niepoprawny PESEL dla M";
    end if;
end$$

create trigger pesel_ludzie_update_check before update on ludzie for each row
begin
    IF (LENGTH(NEW.PESEL))!=11 THEN          
			signal sqlstate '11111'
			set message_text = 'Niedozwolony format PESEL';
    end if;
end$$

DELIMITER ;