drop view if exists model_lustrzanka;

create view model_lustrzanka as
select aparat.model, producent.nazwa, matryca.przekatna, matryca.rozdzielczosc, obiektyw.minprzeslona, obiektyw.maxprzeslona 
as model_lustrzanka
from (((aparat
join producent on producent.id = aparat.producent)
join matryca on matryca.id = aparat.matryca)
join obiektyw on obiektyw.id = aparat.obiektyw)
where aparat.typ like 'lustrzanka' and producent.kraj not like 'Chiny';

select * from model_lustrzanka;