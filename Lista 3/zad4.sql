SET @sql = "select count(plec) from ((ludzie
join pracownicy on pracownicy.PESEL = ludzie.PESEL)
join zawody on zawody.zawod_id = pracownicy.zawod_id)
where ludzie.plec like 'K' and zawody.nazwa = (?)";
PREPARE getIloscKobietSql FROM @sql;
SET @zawod = 'Informatyk';
EXECUTE getIloscKobietSql using @zawod;