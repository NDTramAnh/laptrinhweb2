CREATE TABLE users (
    user_id INT IDENTITY(1,1) PRIMARY KEY,  
    user_name VARCHAR(25) NOT NULL, 
    user_email VARCHAR(55) NOT NULL, 
    user_pass VARCHAR(255) NOT NULL, 
    updated_at DATETIME NULL,  
    created_at DATETIME DEFAULT GETDATE()
);
-- drop table users
CREATE TABLE products (  
    product_id INT IDENTITY(1,1) PRIMARY KEY,  
    product_name VARCHAR(255) NOT NULL UNIQUE,  
    product_price DECIMAL(10,2) NOT NULL,  -- Dùng DECIMAL thay vì DOUBLE  
    product_description TEXT NOT NULL,  
    updated_at DATETIME NULL,  
    created_at DATETIME DEFAULT GETDATE()  -- Dùng GETDATE() thay vì CURRENT_TIMESTAMP  
);
-- drop table products
CREATE TABLE orders (  
    order_id INT IDENTITY(1,1) PRIMARY KEY,  
    user_id INT NOT NULL,  
    updated_at DATETIME NULL,  
    created_at DATETIME DEFAULT GETDATE(),  
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE  
);

  -- drop table orders
CREATE TABLE order_details (  
    order_detail_id INT IDENTITY(1,1) PRIMARY KEY,  
    order_id INT NOT NULL,  
    product_id INT NOT NULL,  
    quantity INT NOT NULL DEFAULT 1,  
    updated_at DATETIME NULL,  
    created_at DATETIME DEFAULT GETDATE(),  
    FOREIGN KEY (order_id) REFERENCES orders(order_id) ON DELETE CASCADE,  
    FOREIGN KEY (product_id) REFERENCES products(product_id) ON DELETE CASCADE  
);
--/cho vd 

INSERT INTO users (user_name, user_email, user_pass, created_at) VALUES  
('Nguyen Van A', 'nguyenvana@gmail.com', 'password123', GETDATE()),  
('Tran Thi B', 'tranthib@gmail.com', 'password456', GETDATE()),  
('Le Van C', 'levanc@gmail.com', 'password789', GETDATE()),  
('Pham Thi D', 'phamthid@gmail.com', 'password321', GETDATE()),  
('Hoang Van E', 'hoangvane@gmail.com', 'password654', GETDATE()),  
('Dang Thi F', 'dangthif@gmail.com', 'password987', GETDATE()),  
('Bui Van G', 'buivang@gmail.com', 'password741', GETDATE()),  
('Vo Thi H', 'vothih@gmail.com', 'password852', GETDATE()),  
('Mo Van I', 'dovani@gmail.com', 'password963', GETDATE()),  
('Pham Van minh', 'phamvanj@gmail.com', 'password159', GETDATE());  


-- Chèn dữ liệu vào bảng orders
INSERT INTO orders (user_id, created_at) VALUES  
(1, GETDATE()),  
(2, GETDATE()),  
(1, GETDATE()),  
(3, GETDATE()),  
(4, GETDATE()),  
(2, GETDATE());  

-- Chèn dữ liệu vào bảng -- drop table order_details
INSERT INTO order_details (order_id, product_id, quantity, created_at) VALUES  
(1, 1, 1, GETDATE()),  
(1, 2, 1, GETDATE()),  
(2, 2, 1, GETDATE()),  
(3, 3, 2, GETDATE()),  
(4, 4, 1, GETDATE()),  
(5, 1, 1, GETDATE()),  
(6, 5, 1, GETDATE());  

-- Chèn dữ liệu vào bảng products
INSERT INTO products (product_name, product_price, product_description, created_at) VALUES  
('Samsung Galaxy S21', 999.99, 'Smartphone từ Samsung với nhiều tính năng vượt trội.', GETDATE()),  
('Apple iPhone 12', 1099.99, 'Smartphone từ Apple với thiết kế đẹp và hiệu suất cao.', GETDATE()),  
('Sony WH-1000XM4', 349.99, 'Tai nghe không dây chống ồn hàng đầu.', GETDATE()),  
('Dell XPS 13', 1299.00, 'Laptop siêu nhẹ với hiệu suất mạnh mẽ.', GETDATE()),  
('Apple MacBook Air', 999.00, 'Laptop siêu nhẹ với chip M1.', GETDATE()); 


-- 5. Liệt kê 7 người dùng có số lượng đơn hàng nhiều nhất
SELECT TOP 7 u.user_id, u.user_name, COUNT(o.order_id) AS number_of_orders  
FROM users u  
LEFT JOIN orders o ON u.user_id = o.user_id  
GROUP BY u.user_id, u.user_name  
ORDER BY number_of_orders DESC;

-- 6. Liệt kê 7 người dùng mua sản phẩm có tên: Samsung hoặc Apple trong tên sản phẩm
SELECT TOP 7 u.user_id, u.user_name, o.order_id, p.product_name  
FROM orders o  
JOIN users u ON o.user_id = u.user_id  
JOIN order_details od ON o.order_id = od.order_id  
JOIN products p ON od.product_id = p.product_id  
WHERE p.product_name LIKE '%Samsung%' OR p.product_name LIKE '%Apple%'  
ORDER BY u.user_id; 

-- 7. Liệt kê danh sách mua hàng của user bao gồm giá tiền của mỗi đơn hàng, thông tin hiển thị gồm: mã user, tên user, mã đơn hàng, tổng tiền  
SELECT u.user_id, u.user_name, o.order_id, SUM(p.product_price * od.quantity) AS total_price  
FROM orders o  
JOIN users u ON o.user_id = u.user_id  
JOIN order_details od ON o.order_id = od.order_id  
JOIN products p ON od.product_id = p.product_id  
GROUP BY o.order_id, u.user_id, u.user_name;  

-- 8. Mỗi user chỉ chọn ra 1 đơn hàng có giá tiền lớn nhất
WITH OrderTotals AS (
    SELECT 
        o.user_id, 
        o.order_id, 
        SUM(p.product_price * od.quantity) AS total_price,
        ROW_NUMBER() OVER (PARTITION BY o.user_id ORDER BY SUM(p.product_price * od.quantity) DESC) AS rank_order
    FROM orders o
    JOIN order_details od ON o.order_id = od.order_id
    JOIN products p ON od.product_id = p.product_id
    GROUP BY o.user_id, o.order_id
)
SELECT u.user_id, u.user_name, ot.order_id, ot.total_price
FROM users u
JOIN OrderTotals ot ON u.user_id = ot.user_id
WHERE ot.rank_order = 1
ORDER BY u.user_id;

-- 9. Liệt kê danh sách mua hàng của user bao gồm giá tiền của mỗi đơn hàng, thông tin hiển thị gồm: mã user, tên user, mã đơn hàng, tổng tiền, số sản phẩm. Mỗi user chỉ chọn ra 1 đơn hàng có giá tiền nhỏ nhất.  
WITH OrderTotals AS (
    SELECT 
        o.user_id, 
        o.order_id, 
        SUM(p.product_price * od.quantity) AS total_price,
        SUM(od.quantity) AS total_quantity,
        ROW_NUMBER() OVER (PARTITION BY o.user_id ORDER BY SUM(p.product_price * od.quantity) ASC) AS rank_order
    FROM orders o
    JOIN users u ON o.user_id = u.user_id
    JOIN order_details od ON o.order_id = od.order_id
    JOIN products p ON od.product_id = p.product_id
    GROUP BY o.user_id, o.order_id
)
SELECT u.user_id, u.user_name, ot.order_id, ot.total_price, ot.total_quantity
FROM users u
JOIN OrderTotals ot ON u.user_id = ot.user_id
WHERE ot.rank_order = 1
ORDER BY u.user_id;
