-- 1. Rank films by length (filter out the rows with nulls or zeros in length column). Select only columns title, length and rank in your output.

select title, length, dense_rank() over (order by length) as 'rank' from sakila.film
where length is not null;


-- 2. Rank films by length within the rating category (filter out the rows with nulls or zeros in length column). In your output, only select the columns title, length, rating and rank.

select title, length, rating, dense_rank() over (partition by rating order by length) as 'rank' from sakila.film
where length is not null;


-- 3. How many films are there for each of the categories in the category table? Hint: Use appropriate join between the tables "category" and "film_category".
select * from sakila.category;

select category_id, count(*) from sakila.film_category
group by category_id;


select a.category_id, count(*) from sakila.category a
left join sakila.film_category b on a.category_id = b.category_id
group by category_id;


-- 4. Which actor has appeared in the most films? Hint: You can create a join between the tables "actor" and "film actor" and count the number of times an actor appears.

select * from sakila.actor;

select * from sakila.film_actor;


select a.actor_id, first_name, last_name, count(*) as count from sakila.actor a
left join sakila.film_actor b on a.actor_id = b.actor_id
group by actor_id
order by count desc;


-- 5. Which is the most active customer (the customer that has rented the most number of films)? Hint: Use appropriate join between the tables "customer" and "rental" and count the rental_id for each customer.
-- customer_id : 148

select * from sakila.customer;

select * from sakila.rental;


select a.customer_id, count(rental_id) as rental_count from sakila.customer a
left join sakila.rental b on a.customer_id = b.customer_id
group by customer_id
order by rental_count desc;



-- Bonus: Which is the most rented film? (The answer is Bucket Brotherhood).

select * from sakila.rental;

select * from sakila.inventory;

select film_id, title from sakila.film;


select c.film_id, c.title, count(*) as count from sakila.rental a
left join sakila.inventory b on a.inventory_id = b.inventory_id
left join sakila.film c on b.film_id = c.film_id
group by c.film_id
order by count desc;



-- Other for fun.