use db_country;


 -- Selezionare tutte le nazioni il cui nome inizia con la P e la cui
-- area è maggiore di 1000 kmq

select c.name, c.area 
from countries c 
where c.name like  'P%' and c.area > 1000 ;


-- Selezionare le nazioni il cui national day è avvenuto più di
-- 100 anni fa

select * 
from  countries c 
where TIMESTAMPDIFF(YEAR, national_day , CURDATE()) > 100;


-- Selezionare il nome delle regioni del continente europeo, in
-- ordine alfabetico

select r.name
from regions r join continents c 
on c.continent_id = r.continent_id 
where LOWER(c.name) like 'europe'
order by r.name asc;


-- Contare quante lingue sono parlate in Italia
select c.name as nazione, count(l.language_id) as numero_lingue_parlate
from countries c 
inner join country_languages cl 
on c.country_id = cl.country_id 
inner join languages l 
on l.language_id = cl.language_id 
where LOWER(c.name) like 'italy'
group by c.name;


-- Selezionare quali nazioni non hanno un national day
select c.name , c.national_day  
from countries c 
where c.national_day is null;

-- Per ogni nazione selezionare il nome, la regione e il
-- continente
select c.name as nazione, r.name as regione, c.name as continente
from countries c 
inner join regions r 
on c.region_id = r.region_id 
inner join continents c2 
on c2.continent_id = r.continent_id 
group by nazione, regione, continente;

-- Modificare la nazione Italy, inserendo come national day il 2
-- giugno 1946

UPDATE countries set national_day  = '1946-06-02'
where name  like 'italy';


-- Per ogni regione mostrare il valore dell'area totale

select r.name as regione, SUM(c.area) as area_totale 
from regions r 
inner join countries c 
on r.region_id = c.region_id 
group by regione
order by area_totale ASC;

-- Selezionare le lingue ufficiali dell'Albania
select l.`language` as lingue_uff_Albania 
from countries c 
inner join country_languages cl 
on c.country_id = cl.country_id 
inner join languages l 
on l.language_id  = cl.language_id  
where c.name like 'Albania' and cl.official is true;


-- Selezionare il Gross domestic product (GDP) medio dello
-- United Kingdom tra il 2000 e il 2010

select c.name as nome_nazione , avg(cs.gdp) as media_gdp 
from countries c 
inner join country_stats cs 
on cs.country_id = c.country_id 
where c.name like 'united kingdom' and cs.`year` >= 2000 and cs.`year` <= 2010
group by c.name;


-- Selezionare tutte le nazioni in cui si parla hindi, ordinate
-- dalla più estesa alla meno estesa

select c.name , c.area 
from countries c 
inner join country_languages cl 
on c.country_id  = cl.country_id 
inner join languages l 
on l.language_id = cl.language_id  
where l.`language` like 'hindi'
order by c.area desc;


-- Per ogni continente, selezionare il numero di nazioni con
-- area superiore ai 10.000 kmq ordinando i risultati a partire dal
-- continente che ne ha di più

SELECT c.name as nazione, count(c2.country_id) as nazioni_con_area_superiore10000 
from continents c 
inner join regions r 
on c.continent_id = r.continent_id 
inner join countries c2 
on c2.region_id = r.region_id 
where c2.area > 10000
group by nazione
order by nazioni_con_area_superiore10000 desc;















