drop function if exists model_martyca_count;

delimiter $$
create function model_martyca_count (matryca_id int) 
returns int deterministic
begin
	declare wynik int;
    
    select count(model) into wynik from aparat 
    group by matryca 
    having matryca = matryca_id;
    
    return wynik;
end$$
delimiter ;
select model_martyca_count(101);