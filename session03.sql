/*
	Những điểm cần lưu ý khi học database 
    1. SQL và MySQL 
    - SQL (structured query language): Ngon ngu truy van cau truc 
    - MySQL : Hẹ quản trị co so du lieu 
    2. SQL và NoSQL 
    - SQL: Ngon ngu truy van cau truc, mo hinh du lieu dang bang 
    - NoSQL: Ngon ngu truy phi cau truc, mo hinh du lieu key-value (MongoDB)
    3. Các khái niệm cần lưu ý
		- Thực thể (Entity): Sinh vien, Lop, mon hoc, giao vien, thoi khoa bieu,...
        - Thuộc tính: Ma sinh vien, Ten sinh vien, Tuoi sinh vien
        - Mối quan hệ: 1-1, 1-N, N-N
        - Khai niem ve bang (thuc the), dong (ban ghi), cot (thuoc tinh)
        - Cac rang buoc 
			- Khoa chinh: Xac dinh duy nhat moi ban ghi trong bang  
			- Khoa ngoai: Lien ket 2 bang voi nhau 
            - Not null 
            - Unique 
            - Check 
            - Default 
    4. ERD và ERM 
    - ERM: Entity Relationship Model (Mo hinh quan he thuc the)
    - Cafe
    + Thiet ke truu tuong: Xac dinh can luu tru nhung thuc the nao 
    + Thiet ke vat ly: Xac dinh cau truc, du lieu luu tru the nao trong csdl 
    + Thiet ke logic:  Chuan hoa csdl (tranh du thua du lieu va dam bao tinh toan ven du lieu)
    
    - ERD: Entity Relationship Diagram (So do quan he thuc the)
    - Cafe
    De thiet ke ERD can 6 buoc 
    B1: Xac dinh muc tieu va pham vi 
    - San pham, Nhan vien, Khach hang, Don hang, Danh muc san pham
    B2: Thu thap thong tin (Quan ly cai gi cua 1 thuc the)
	- Sinh vien: Quan ly chi so hoc tap cua sinh vien 
    - Nhan vien: Quan ly thong tin ca nhan 
    B3: Xac dinh thuoc tinh va rang buoc cua thuoc tinh 
    - Nhan vien (DOB, Cerf, Address, Phone, Email, CCCD)
    - Sinh vien phai luu qua bang mon hoc, lop hoc 
    B4: Moi quan he cac thuc the 
    - Quan he 1-1, 1-N, N-N
    B5: Xac dinh rang buoc thuc the va chuan hoa csdl (1NF, 2NF, 3NF, BCNF)
    B6: Ve ERD => Tao CSDL, tao bang trong CSDL 
*/
-- CSDL 
/*
-- Tao moi csdl 
Syntax CREATE DATABASE database_name
-- Truy cap vao csdl 
USE database_name 
-- Xoa csdl 
DROP DATABASE database_name 
*/
CREATE DATABASE session03_db;
USE session03_db;
-- DROP DATABASE session03_db 

/* Sau khi tao va truy cap csdl thi tien hanh tao bang (thuc the) va thuoc tinh va rang buoc
Syntax: CREATE TABLE table_name(
	column_name_1 datatype constraint
    column_name_2 datatype constraint
    )
DROP TABLE table_name;
ALTER TABLE table_name 
	ADD COLUMN new_column_name datatype constraint
*/
CREATE TABLE categories(
	category_id INT PRIMARY KEY AUTO_INCREMENT,
    category_name VARCHAR(100) NOT NULL UNIQUE,
    category_status BIT DEFAULT(1)
);

-- Category 1 - N product => the hien tren csdl the nao?
-- De the hien moi quan 1-N tren csdl thi khoa ngoai cua bang nhieu tham chieu den khoa chinh cua bang 1
CREATE TABLE products(
	product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(100) NOT NULL, 
    product_price DECIMAL(10,2) NOT NULL CHECK (product_price >0),
    product_quantity INT NOT NULL CHECK (product_quantity > 0),
    categories_id INT,
    FOREIGN KEY (categories_id) REFERENCES categories(category_id)
);

CREATE TABLE orders(
	order_id INT PRIMARY KEY AUTO_INCREMENT,
    order_total_amount DECIMAL(10,2) NOT NULL CHECK (order_total_amount>0),
    order_payment_method VARCHAR(20) NOT NULL,
    order_date DATE
);

-- Order va product quan N-N 
-- De the hien moi quan N-N tren CSDL thi phai tao bang trung gian 
-- Khoa chinh cua bang trung gian tao boi 2 khoa ngoai (composite key - khoa tong hop)
-- 2 khoai ngoai duoc tao o bang trung gian se tham chieu den 2 khoa chinh cua cua 2 thuc the co quan he N-N 
-- Bien doi quan he N-N thanh quan he 2 moi quan 1-N voi bang trung gian 
/* Order
OrderID  Order_total_amount    	Product_id		product_price 		Orderpaymentmehtod     	orderdate
  1			100,000				  1(Iphone)		   	30.000			 	cash				17/11/2026
  1			100,000				  2 (Ipad)		   	40.000				 cash				17/11/2026	
  2			50,000														visa 				17/11/2026
  
Order_detail 
order_detail_id			Order_id         	Product_id			Quantity    product_price
      1						1				1 (Iphone)			  2             30.0000
	  2						1				2 (Ipad)			  1			    40.000
      3						2				3 (Laptop)			  1				50.000
*/  
CREATE TABLE order_detail(
	order_detail_id INT PRIMARY KEY AUTO_INCREMENT,
	order_ID INT, 
    FOREIGN KEY (order_ID) REFERENCES orders(order_id),
    product_ID INT, 
	FOREIGN KEY (product_ID) REFERENCES products(product_id),
    order_detail_quantity INT NOT NULL
);



