/*The column "rating" contains a rating for a bar, on a scale from 1 to 4. What is the average rating (averaging over all reviews)?*/
select avg(rating) from bars;

/*The column "manufacturer" stores the manufacturer of the bar to which the review refers. Which manufacturer received most reviews?*/
select manufacturer from bars group by manufacturer order by count(review) desc;

/*Count the number of reviews that contain the word "earthy" (all lowercase) in the "review" column!*/
select count(*) from bars where review like '%earthy%';

/*Only one manufacturer has more than 25 reviews for bars with a cocoa percentage of more than 71. Which one is it?*/
select manufacturer from bars where cocoa_percent > 71 group by manufacturer having count(review) > 25;

/*How many bars (i.e., number of distinct bar names) exist in the database that did not receive any review in 2018?*/
select count(distinct bar_name) from bars where bar_name not in(select distinct bar_name from bars where year_reviewed = 2018);

/*How many pairs of reviews can we find such that both refer to the same bar (column "bar_name"), the second review was written after the first review (i.e., "year_reviewed" is higher for the second review), and the rating assigned by the second review (column "rating") is higher?*/
select count(*) from bars b1 join bars b2 on b1.bar_name = b2.bar_name and b1.year_reviewed < b2.year_reviewed and b1.rating < b2.rating;

/*How many manufacturers produce at least one bar where the bean origin (column "bean_origin") is the same as the company location (column "company_location")?*/
select count(distinct manufacturer) from bars where bean_origin = company_location;

/*How many pairs of reviews exist such that both have exactly the same review text but refer to different chocolate bars? Hint: make sure to count each pair of reviews only once (i.e., do not double-count reviews A,B as A,B and B,A).*/
select count(*) from bars b1 join bars b2 on b1.review = b2.review and b1.bar_name <> b2.bar_name and b1.id < b2.id;

/*Is the average rating higher for chocolate bars with a cocoa percentage above average (compared to bars with a percentage below average)?*/
select avg(rating) from bars where cocoa_percent > (select avg(cocoa_percent) from bars);
select avg(rating) from bars where cocoa_percent < (select avg(cocoa_percent) from bars);

/*Count the number of bars (number of distinct bar names) that received a review in every year (column "year_reviewed") present in the data set.*/
select count(distinct bar_name) from bars group by bar_name having count(distinct year_reviewed) = (select count(distinct year_reviewed)from bars);
