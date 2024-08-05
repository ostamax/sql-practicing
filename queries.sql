/*
1.
Вивести кількість фільмів в кожній категорії.
Результат відсортувати за спаданням.
*/
select 
	c.name as category, 
	count(fc.film_id) as film_count
from category c 
	left join film_category fc on fc.category_id = c.category_id
group by c.name
order by 2 desc;

/*
2.
Вивести 10 акторів, чиї фільми брали на прокат найбільше.
Результат відсортувати за спаданням.
*/
select 
	concat(a.first_name, ' ', a.last_name) as actor_name, count(r.rental_id) 
from rental r 
	join inventory i on i.inventory_id = r.inventory_id 
	join film f on f.film_id  = i.film_id 
	join film_actor fa on fa.film_id = f.film_id 
	join actor a on a.actor_id = fa.actor_id 
group by concat(a.first_name, ' ', a.last_name)
order by 2 desc
limit 10;

/*
3.
Вивести категорія фільмів, на яку було витрачено найбільше грошей
в прокаті
*/
select c.name, SUM(amount) as rental_sum
from payment p 
	join rental r on p.rental_id = r.rental_id
	join inventory i on i.inventory_id = r.inventory_id
	join film f on f.film_id = i.film_id
	join film_category fc  on fc.film_id = f.film_id
	join category c on c.category_id = fc.category_id 
group by 1
order by 2 desc 
limit 1;

/*
4.
Вивести назви фільмів, яких не має в inventory.
Запит має бути без оператора IN
*/
select f.title
from film f 
	left join inventory i on i.film_id = f.film_id
where  i.film_id is null;

/*
5.
Вивести топ 3 актори, які найбільше зʼявлялись в категорії фільмів “Children”.
*/
select 
	concat(a.first_name, ' ', a.last_name) as actor_name, count(f.film_id) as films_count
from film f 
	join film_actor fa on fa.film_id = f.film_id
	join film_category fc on fc.film_id = f.film_id
	join actor a on fa.actor_id = a.actor_id
	join category c on c.category_id = fc.category_id
where c.name = 'Children'
group by 1
order by 2 desc
limit 3;
