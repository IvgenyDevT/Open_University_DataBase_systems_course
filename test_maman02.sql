
drop table follow
drop table likes
drop table comment
drop table post
drop table users






--============================== QUESTION 1 ===============================

create table users
(uid	int,
name	varchar(30),
email	varchar(50),
password	varchar(50),
descr	varchar(255),
Country 	varchar(50),
primary key(uid));

create table post 
(pid	int,
uid 	int 	not null,
content 	varchar(255) 	not null,
imageurl 	varchar(255),
pdate 	date,
ptime 	time,
primary key(pid),
foreign key(uid) references users);



create table comment(
pid 	int,
cdate	date,
ctime	time,
uid 	int 	not null,
content 	varchar(255) 	not null,
primary key(pid,cdate,ctime),
foreign key(pid) references post
);

create table likes(
uid 	int,
pid 	int,
ldate 	date,
ltime 	time,
primary key(uid,pid),
foreign key(uid)references users,
foreign key(pid) references post
);

create table follow(
fuid 	int,
uid 	int,
primary key(fuid,uid),
foreign key(uid) references users,
foreign key(fuid) references users(uid));


--=========================== END QUESTION 1 ===============================
--*
--*
--*
--*
--*
--*
--*
--*
--============================== QUESTION 2 ===============================


create or replace function trigf1() returns trigger as $$

declare exist_post	record;
begin

	select post.pid INTO exist_post
	from post 
	where (new.cdate > post.pdate or 
			(new.cdate = post.pdate and new.ctime > post.ptime))
			and new.pid = post.pid;

	if exist_post is not null then return new;

	else begin
				raise notice 'bad comment';
				raise notice 'the comment has been writen before the post release';
				return NULL;
		  end;
		  
					
	end if;
	
end;
$$language plpgsql;



create trigger T1
before insert on comment
for each row
execute procedure trigf1();


--=========================== END QUESTION 2 ===============================
--*
--*
--*
--*
--*
--*
--*
--*
--============================== QUESTION 3 ===============================
set datestyle to 'ISO,DMY';

insert into users
values(1,'alice','alice@example.com','pass1','photographer','israel'),
(2,'bob','bob@example.com','pass2','taveler','usa'),
(3,'carlo','carlo@example.com','pass3','chef','italy'),
(4,'david','david@example.com','pass4','musician','israel'),
(5,'eve','eve@example.com','pass5','techie','canada'),
(6,'frank','frank@example.com','pass6','gamer','japan'),
(7,'grace','grace@example.com','pass7','reader','uk'),
(8,'hank','hank@example.com','pass8','blogger','france');


INSERT INTO post (pid, uid, content, imageurl, pdate, ptime)
VALUES 
(101, 1, 'sunset in tel aviv', 'sun.jpg', '05.05.2025', '18:30'),
(102, 2, 'hiking the rockies', 'rockies.jpg', '20.04.2025', '10:00'),
(103, 3, 'best pasta recipe', 'pasta.jpg', '22.04.2025', '12:15'),
(104, 4, 'new song release', 'song.jpg', '01.05.2025', '15:45'),
(105, 1, 'morning coffee', 'coffee.jpg', '15.03.2025', '08:20'),
(106, 5, 'tech trends 2025', 'tech.jpg', '03.05.2025', '09:00'),
(111, 3, 'city tour', 'oldcity.jpg', '01.03.2025', '10:00');

INSERT INTO comment (pid, cdate, ctime, uid, content)
VALUES
(101, '05.05.2025','19:00',2,'beautiful!'),
(101, '05.05.2025','19:05',3,'love the colors'),
(102, '21.04.2025','14:00',1,'awesome hike'),
(102, '22.04.2025','16:00',8,'nice view'),
(102, '22.04.2025','16:00',8,'nice view');

INSERT INTO likes (uid, pid, ldate, ltime)
VALUES 
(1,101,'05.05.2025','21:00'),
(1,102,'21.03.2025','14:05'),
(2,103,'22.04.2025','12:30'),
(2,111,'02.03.2025','11:05');


INSERT INTO follow (fuid, uid)
VALUES
(2,1),
(3,1),
(1,2),
(2,3),
(6,1);




--=========================== END QUESTION 3 ===============================
--*
--*
--*
--*
--*
--*
--*
--*
--============================== QUESTION 4 ===============================
			
select pid,uid,content from post

where date_part('month',post.pdate) = 5 

AND date_part('year',post.pdate) = (EXTRACT (YEAR FROM PDATE));


--=========================== END QUESTION 4 ===============================
--*
--*
--*
--*
--*
--*
--*
--*
--============================== QUESTION 5 ===============================

select uid, name, country 

from users as u 

join post as p using (uid)

where p.content like '%city%';


--=========================== END QUESTION 5 ===============================
--*
--*
--*
--*
--*
--*
--*
--*============================== QUESTION 6 ===============================

select distinct p.pid, p.content

from users as u join post as p using(uid)

where u.country = 'usa'

AND pid IN

	(select pid from comment
	
		group by cdate,pid
		
		having count(*) >= 4);


--=========================== END QUESTION 6 ===============================
--*
--*
--*
--*
--*
--*
--*
--*
--============================== QUESTION 7 ===============================
 
SELECT DISTINCT l.uid as fuid

FROM likes as l

JOIN post p USING (pid)

where l.uid <> p.uid 

and (l.uid,p.uid) 

not in

	(select f.fuid,f.uid
	
	 from follow f);

--=========================== END QUESTION 7 ===============================
--*
--*
--*
--*
--*
--*
--*
--*
--============================== QUESTION 8 ===============================

select uid, name

from users

where uid in

	(SELECT f.fuid
	
		FROM follow as f
		
		JOIN users as u ON f.uid = u.uid
		
		WHERE u.country = 'israel'
		
		and f.fuid <> f.uid
		
		group by fuid
		having count(*) >=3 
		and f.fuid not in
		
			(select uid from comment)
	);
--=========================== END QUESTION 8 ===============================
--*
--*
--*
--*
--*
--*
--*
--*
--============================== QUESTION 9 ===============================

SELECT f.fuid
FROM follow f
JOIN users u ON u.uid = f.fuid
WHERE u.country = 'israel'
  AND f.uid IN
  
  		(SELECT uid
    	 FROM post
		 
    	GROUP BY uid
    	HAVING COUNT(*) >= 3)

		
GROUP BY f.fuid
HAVING COUNT(*) >= ALL

		(SELECT COUNT(*)
  		 FROM follow f2
  		 JOIN users u2 ON u2.uid = f2.fuid
  		 WHERE u2.country = 'israel'
    	 AND f2.uid IN 
		 
		 		(SELECT uid
      			 FROM post
      			GROUP BY uid
    		  HAVING COUNT(*) >= 3)
				
 		 GROUP BY f2.fuid);

--=========================== END QUESTION 9 ===============================
--*
--*
--*
--*
--*
--*
--*
--*
--============================== QUESTION 10 ===============================

SELECT DISTINCT l.uid AS fuid

FROM likes l

JOIN post p USING (pid)

WHERE l.uid <> p.uid

AND p.content LIKE '%city%'

AND NOT EXISTS (
       
        SELECT 1
        FROM follow f
        WHERE f.fuid = l.uid
          AND NOT EXISTS (
                SELECT 1
                FROM likes l2
                JOIN post  p2 USING (pid)
                WHERE l2.uid = l.uid 
                  AND p2.uid = f.uid
                  AND l2.uid <> p2.uid
                  AND p2.content LIKE '%city%'
          )
  );
--=========================== END QUESTION 10 ===============================

