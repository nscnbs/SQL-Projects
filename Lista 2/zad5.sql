use aparaty;
drop procedure if exists producent_przekatna;
DELIMITER $$
create procedure producent_przekatna(in prod_id int, out wynik varchar(20))
begin
    select aparat.model into wynik from aparat 
	join matryca on aparat.matryca=matryca.id and aparat.producent=prod_id and matryca.przekatna = 
	(select max(matryca.przekatna) from matryca join aparat on aparat.matryca=matryca.id  and aparat.producent=prod_id);
end$$
DELIMITER ;
call producent_przekatna(1, @wynik);
select @wynik;



drop function if exists producent_przekatna;

delimiter $$
create function producent_przekatna (prod_id int) 
returns varchar(20) deterministic
begin
	declare wynik varchar(30);

	select aparat.model into wynik from aparat 
	join matryca on aparat.matryca=matryca.id and aparat.producent=prod_id and matryca.przekatna = 
	(select max(matryca.przekatna) from matryca join aparat on aparat.matryca=matryca.id  and aparat.producent=prod_id);
    return wynik;
end$$
delimiter ;
select producent_przekatna(1);
