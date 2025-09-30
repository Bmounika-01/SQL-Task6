USE  ecommerce_db;

----------------------------------------------------------------------------
-- Subquery in SELECT(scalar subquery)
----------------------------------------------------------------------------

SELECT name, (SELECT COUNT(*) FROM Orders) AS total_orders
FROM Users;

----------------------------------------------------------------------------
-- Subquery in WHERE
----------------------------------------------------------------------------

SELECT name, email
FROM Users
WHERE user_id IN (SELECT DISTINCT user_id FROM Orders);

------------------------------------------------------------------------------
-- Subquery in FROM
------------------------------------------------------------------------------

SELECT u.name, t.avg_amount
FROM (
    SELECT o.user_id, AVG(p.amount) AS avg_amount
    FROM Orders o
    JOIN Payments p ON o.order_id = p.order_id
    GROUP BY o.user_id
) t
JOIN Users u ON u.user_id = t.user_id;

--------------------------------------------------------------------------------
-- Subquery with insert
--------------------------------------------------------------------------------

SELECT name
FROM Products
WHERE product_id IN (SELECT product_id FROM Order_Items);

---------------------------------------------------------------------------------
-- Subquery with EXISTS
---------------------------------------------------------------------------------

SELECT u.name, u.email
FROM Users u
WHERE EXISTS (
    SELECT 1 
    FROM Orders o
    JOIN Payments p ON o.order_id = p.order_id
    WHERE o.user_id = u.user_id
);

-----------------------------------------------------------------------------------
-- Correlated subquery
------------------------------------------------------------------------------------

SELECT name, price
FROM Products p
WHERE price > (SELECT AVG(price) FROM Products);

------------------------------------------------------------------------------------
-- Subquery with = (scalar subquery)
------------------------------------------------------------------------------------

SELECT u.name, p.amount
FROM Users u
JOIN Orders o ON u.user_id = o.user_id
JOIN Payments p ON o.order_id = p.order_id
WHERE p.amount = (SELECT MAX(amount) FROM Payments);