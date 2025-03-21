CREATE TABLE users (
    user_id INT IDENTITY(1,1) PRIMARY KEY,  
    user_name VARCHAR(25) NOT NULL, 
    user_email VARCHAR(55) NOT NULL, 
    user_pass VARCHAR(255) NOT NULL, 
    updated_at DATETIME NULL,  
    created_at DATETIME DEFAULT GETDATE()
);

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

-- Chèn dữ liệu vào bảng order_details
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

-- 1. Lấy ra danh sách người dùng theo thứ tự tên theo Alphabet (A->Z)  
SELECT * FROM users ORDER BY user_name ASC;  

-- 2. Lấy ra 07 người dùng theo thứ tự tên theo Alphabet (A->Z)  
SELECT TOP 7 * FROM users ORDER BY user_name ASC;  

-- 3. Lấy ra danh sách người dùng theo thứ tự tên theo Alphabet (A->Z), trong đó tên người dùng có chữ "a"  
SELECT * FROM users WHERE user_name LIKE '%a%' ORDER BY user_name ASC;  

-- 4. Lấy ra danh sách người dùng trong đó tên người dùng bắt đầu bằng chữ "m"  
SELECT * FROM users WHERE user_name LIKE 'm%' ORDER BY user_name ASC;  

-- 5. Lấy ra danh sách người dùng trong đó tên người dùng kết thúc bằng chữ "i"  
SELECT * FROM users WHERE user_name LIKE '%i' ORDER BY user_name ASC;  

-- 6. Lấy ra danh sách người dùng trong đó email người dùng là Gmail  
SELECT * FROM users WHERE user_email LIKE '%@gmail.com';  

-- 7. Lấy ra danh sách người dùng trong đó email người dùng là Gmail, tên người dùng bắt đầu bằng chữ "m"  
SELECT * FROM users WHERE user_email LIKE '%@gmail.com' AND user_name LIKE 'm%';  

-- 8. Lấy ra danh sách người dùng trong đó email người dùng là Gmail, tên người dùng có chữ "i" và tên người dùng có chiều dài lớn hơn 5  
SELECT * FROM users  
WHERE user_email LIKE '%@gmail.com'  
AND user_name LIKE '%i%'  
AND LEN(user_name) > 5;  

-- 9. Lấy ra danh sách người dùng trong đó tên người dùng có chữ "a", chiều dài từ 5 đến 9, email dùng dịch vụ Gmail, trong tên email có chữ "i"  
SELECT * FROM users  
WHERE user_name LIKE '%a%'  
AND LEN(user_name) BETWEEN 5 AND 9  
AND user_email LIKE '%@gmail.com'  
AND user_email LIKE '%i%';  

-- 10. Lấy ra danh sách người dùng trong đó tên người dùng có chữ "a", chiều dài từ 5 đến 9 hoặc tên người dùng có chữ "i", chiều dài nhỏ hơn 9 hoặc email dùng dịch vụ Gmail, trong tên email có chữ "i"  
SELECT * FROM users  
WHERE (user_name LIKE '%a%' AND LEN(user_name) BETWEEN 5 AND 9)  
   OR (user_name LIKE '%i%' AND LEN(user_name) < 9)  
   OR (user_email LIKE '%@gmail.com' AND user_email LIKE '%i%');  