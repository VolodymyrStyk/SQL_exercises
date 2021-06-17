-- 1. +Вибрати усіх клієнтів, чиє ім'я має менше ніж 6 символів.
-- SELECT * FROM client
-- WHERE FirstName LIKE '______';

-- 2. +Вибрати львівські відділення банку.+
-- SELECT * FROM department
-- WHERE DepartmentCity = 'Lviv';

-- 3. +Вибрати клієнтів з вищою освітою та посортувати по прізвищу.
-- SELECT * FROM client
-- WHERE Education = 'high'
-- ORDER BY LastName;

-- 4. +Виконати сортування у зворотньому порядку над таблицею Заявка і вивести 5 останніх елементів.
-- SELECT * FROM application
-- ORDER BY idApplication DESC
-- LIMIT 5;

-- 5. +Вивести усіх клієнтів, чиє прізвище закінчується на OV чи OVA.
-- SELECT * FROM client
-- WHERE LastName LIKE '%k'
-- OR  LastName LIKE '%v';

-- 6. +Вивести клієнтів банку, які обслуговуються київськими відділеннями.
-- SELECT * FROM client
-- WHERE Department_idDepartment = 1 OR Department_idDepartment = 4;

-- 7. +Вивести імена клієнтів та їхні номера телефону, погрупувавши їх за іменами.
-- SELECT idClient, FirstName FROM client
-- GROUP BY FirstName;

-- 8. +Вивести дані про клієнтів, які мають кредит більше ніж на 5000 тисяч гривень.
-- SELECT * FROM client
-- LEFT JOIN application ON application.Client_idClient = client.idClient
-- WHERE application.Sum > 5000 AND application.CreditState = 'Not returned';

-- 9. +Порахувати кількість клієнтів усіх відділень та лише львівських відділень.
-- SELECT COUNT(Passport) 'AllClients' FROM client ;
-- SELECT COUNT(Department_idDepartment) 'LvivClients' FROM client
-- WHERE Department_idDepartment = 2 OR Department_idDepartment = 5;

-- 10. Знайти кредити, які мають найбільшу суму для кожного клієнта окремо.
-- SELECT a.Client_idClient, c.FirstName, c.LastName,  MAX(a.Sum)
-- FROM application AS a
-- RIGHT JOIN client AS c
-- ON a.Client_idClient = c.idClient
-- GROUP BY a.Client_idClient;

-- 11. Визначити кількість заявок на крдеит для кожного клієнта.
-- SELECT COUNT(a.Client_idClient) 'q-ty App', c.FirstName , c.LastName FROM application AS a
-- JOIN client AS c ON c.idClient = a.Client_idClient
-- GROUP BY a.Client_idClient;

-- 12. Визначити найбільший та найменший кредити.
-- SELECT MAX(Sum) 'MAX credit', MIN(Sum) 'MIN credit' from application;

-- 13. Порахувати кількість кредитів для клієнтів,які мають вищу освіту.
-- SELECT COUNT(a.Client_idClient) 'q-ty credit', c.FirstName , c.LastName, c.Education FROM application AS a
-- JOIN client AS c ON c.idClient = a.Client_idClient
-- WHERE c.Education ='high'
-- GROUP BY a.Client_idClient;

-- 14. Вивести дані про клієнта, в якого середня сума кредитів найвища.
--  SELECT a.Client_idClient,
-- 		SUM(a.Sum)/COUNT(a.Sum) AS average,
-- 		c.FirstName , c.LastName
-- FROM application AS a
-- JOIN client AS c ON c.idClient = a.Client_idClient
-- GROUP BY a.Client_idClient;

-- 15. Вивести відділення, яке видало в кредити найбільше грошей
-- SELECT SUM(a.Sum)'MAX CREDIT SUM', d.DepartmentCity, d.idDepartment 'N/Department'
-- FROM application AS a
-- JOIN client as c ON c.idClient = a.Client_idClient
-- JOIN department AS d ON c.Department_idDepartment = d.idDepartment
-- GROUP BY d.idDepartment
-- LIMIT 1;

-- 16. Вивести відділення, яке видало найбільший кредит.
-- SELECT MAX(a.Sum)'MAX credit', d.DepartmentCity, d.idDepartment 'N/Department'
-- FROM application AS a
-- JOIN client as c ON c.idClient = a.Client_idClient
-- JOIN department AS d ON c.Department_idDepartment = d.idDepartment
-- GROUP BY d.idDepartment
-- LIMIT 1;

-- 17. Усім клієнтам, які мають вищу освіту, встановити усі їхні кредити у розмірі 6000 грн.
-- UPDATE application AS a, client AS c
-- SET a.Sum = 6000, a.Currency ='Gryvnia'
-- WHERE c.Education = 'high' AND c.idClient = a.Client_idClient;

-- 18. Усіх клієнтів київських відділень пересилити до Києва.
-- UPDATE client AS c
-- SET c.City = 'Kyiv'
-- WHERE c.Department_idDepartment IN(1,4);

-- 19. Видалити усі кредити, які є повернені.
-- DELETE FROM application
-- WHERE (CreditState = 'Returned' AND Client_idClient<>0);

-- 20. Видалити кредити клієнтів, в яких друга літера прізвища є голосною.
-- SET SQL_SAFE_UPDATES=0;
-- DELETE FROM application WHERE Client_idClient IN(
--     SELECT idClient FROM client
--     WHERE (LastName LIKE'_o%'
-- 	OR LastName LIKE'_a%'
-- 	OR LastName LIKE'_e%'
--     OR LastName LIKE'_i%'
--     OR LastName LIKE'_u%'
--     OR LastName LIKE'_y%')
-- );
-- SET SQL_SAFE_UPDATES=1;
-- ------------------------------------------------------------
-- Знайти львівські відділення, які видали кредитів на загальну суму більше ніж 5000
-- SELECT DepartmentCity, sum FROM application
-- JOIN client c ON application.Client_idClient = c.idClient
-- JOIN department d ON c.Department_idDepartment = d.idDepartment
-- WHERE d.DepartmentCity = 'Lviv' AND Sum > 5000;

-- Знайти клієнтів, які повністю погасили кредити на суму більше ніж 5000
-- SELECT FirstName, LastName, sum, Currency FROM client
-- JOIN application a ON client.idClient = a.Client_idClient
-- WHERE CreditState = 'returned' AND sum >5000;

/* Знайти максимальний неповернений кредит.*/
-- SELECT MAX(Sum) FROM application
-- WHERE CreditState = 'Not returned';

/*Знайти клієнта, сума кредиту якого найменша*/
-- SELECT c.FirstName, c.LastName, MIN(a.Sum)
-- FROM application a, client c;

/*Знайти кредити, сума яких більша за середнє значення усіх кредитів*/


/*Знайти клієнтів, які є з того самого міста, що і клієнт, який взяв найбільшу кількість кредитів*/


--#місто чувака який набрав найбільше кредитів

