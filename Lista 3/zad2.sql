-- CREATE INDEX plec_imie ON ludzie(plec, imie);
-- CREATE INDEX pensja ON pracownicy(pensja);

-- DROP INDEX plec_imie ON ludzie; 
-- DROP INDEX pensja ON ludzie; 

show index from firma.ludzie;
show index from firma.pracownicy;

explain select imie, plec from ludzie where plec like 'K';
-- and imie like "A%"

explain select plec from ludzie where plec like 'K';
explain select imie from ludzie where imie like 'K%';
explain select * from pracownicy where pensja < 2000;
explain select ludzie.PESEL, pracownicy.pensja from (ludzie 
join pracownicy on pracownicy.pesel = ludzie.pesel) 
where pracownicy.pensja>10000 and ludzie.plec like 'M' and pracownicy.zawod_id like '4';
