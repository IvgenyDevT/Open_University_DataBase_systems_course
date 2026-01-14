🗄️ Database Systems — Open University of Israel

This repository contains my coursework and solutions for the academic course
Database Systems (מערכות בסיסי נתונים) at the Open University of Israel.

The course combines theoretical foundations of databases with hands-on practical work using PostgreSQL, emphasizing correctness, efficiency, and formal thinking.

⸻

📚 Course Overview

The course covers both theory and implementation aspects of relational databases:
	•	Relational Data Model
	•	Relational Algebra (formal query expressions)
	•	Keys, Functional Dependencies, Constraints
	•	Schema Design Principles
	•	SQL (DDL & DML)
	•	Complex JOINs
	•	Aggregations (GROUP BY, HAVING)
	•	Nested and Correlated Subqueries
	•	Integrity Constraints (Primary / Foreign Keys)
	•	Triggers using PL/pgSQL
	•	Query correctness and optimization principles

Strong emphasis is placed on:

Writing correct, minimal, and efficient queries, not just working ones.

⸻

🧱 Database Schema (Social Network System)

All assignments are based on a realistic social network database model:

```sql
Users(uid, name, email, password, descr, country)
Post(pid, uid, content, imageURL, pdate, ptime)
Comment(pid, cdate, ctime, uid, content)
Likes(uid, pid, ldate, ltime)
Follow(fuid, uid)
```

This schema models:
	•	Users and profiles
	•	Posts and comments
	•	Likes system
	•	Followers relationships

Including:
	•	Primary keys
	•	Foreign keys
	•	Referential integrity
	•	Business logic constraints

⸻

📄 Assignment 1 — Relational Algebra (ממ”ן 01)

Focus: Formal mathematical query construction

In this assignment I wrote solutions using pure relational algebra, including advanced operators:
	•	Selection (σ)
	•	Projection (π)
	•	Joins (⋈)
	•	Renaming (ρ)
	•	Set operations (∪, ∩, −)
	•	Cartesian products (×)
	•	Division operator (÷)
	•	Complex nested expressions

Examples of problems solved:
	•	Finding posts commented on by all users of a given country
	•	Users who follow multiple users under complex conditions
	•	Users who interacted with posts of people they do not follow
	•	Manual evaluation of multi-step algebraic expressions over relations

This assignment strongly develops:

Algorithmic thinking + mathematical precision in database querying.

⸻

📄 Assignment 2 — SQL & PostgreSQL (ממ”ן 02)

Focus: Practical database engineering

In this assignment I implemented the system using PostgreSQL and wrote advanced SQL queries.

Key technical components:

✔ Database creation using DDL
✔ Primary key & foreign key definitions
✔ Data integrity constraints
✔ Data population with INSERT
✔ Complex SELECT queries
✔ Use of JOIN, GROUP BY, HAVING
✔ Correlated subqueries
✔ Logical conditions across multiple relations
✔ Date-based filtering
✔ Performance-aware query design

🔥 Triggers (PL/pgSQL)

I also implemented custom triggers using PL/pgSQL, for example:
	•	A trigger that prevents inserting a comment if its timestamp is earlier than the post’s creation time
	•	Enforcing business logic directly at the database layer

This demonstrates real-world backend-level database control.

⸻

🧠 Examples of Query Complexity

Some examples of the type of logic implemented:
	•	Users who liked posts of people they do not follow
	•	Users who never commented, but follow at least 3 Israeli users
	•	Finding a user who follows the largest number of active posters
	•	Users who liked a post containing "city" from every user they follow
	•	Posts with at least 4 comments from the same date
	•	Queries requiring both aggregation and relational logic

These are not trivial CRUD queries — they require deep understanding of relational logic.

⸻

🛠 Technologies Used
	•	PostgreSQL
	•	SQL (DDL, DML, Constraints)
	•	PL/pgSQL (Triggers)
	•	Relational Algebra
	•	Git / GitHub

⸻

🎯 Skills Demonstrated

This repository demonstrates strong ability in:
	•	Translating real-world requirements into database schemas
	•	Writing complex SQL queries correctly and efficiently
	•	Understanding relational theory beyond syntax
	•	Enforcing business rules using triggers
	•	Working with constraints and data integrity
	•	Thinking in terms of data consistency and correctness
	•	Academic-level precision (not trial-and-error SQL)

⸻

📌 Academic Notes

All solutions follow strict course rules:
	•	No use of features not taught in the course (e.g. window functions)
	•	No unnecessary nesting
	•	No shortcuts beyond specification
	•	Focus on correctness, not convenience

This reflects real engineering discipline rather than just “it works”.
