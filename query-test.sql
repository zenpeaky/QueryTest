
-- create table product
CREATE SEQUENCE idProduct_seq START WITH 1;
CREATE TABLE product (
    idProduct VARCHAR(255) NOT NULL DEFAULT 'PRD.'||lpad(nextval('idProduct_seq')::text,5,'0'),
    namaProduct VARCHAR(255),
    hargaPokok INT default 0,
	hargaJual INT default 0,
    PRIMARY KEY (idProduct)
);

-- create table customer
CREATE SEQUENCE idCust_seq START WITH 1;
CREATE TABLE customer (
    idCust VARCHAR(255) NOT NULL DEFAULT 'CST.'||lpad(nextval('idCust_seq')::text,5,'0'),
    namaCust VARCHAR(255),
    telp VARCHAR(25),
	email VARCHAR(255),
    PRIMARY KEY (idCust)
);

-- create table toko
CREATE SEQUENCE idToko_seq START WITH 1;
CREATE TABLE toko (
    idToko VARCHAR(255) NOT NULL DEFAULT 'TKO.'||lpad(nextval('idToko_seq')::text,5,'0'),
    namaToko VARCHAR(255),
    kota VARCHAR(255),
    PRIMARY KEY (idToko)
);

-- create table transaction
CREATE SEQUENCE idTrxHeader_seq START WITH 1;
CREATE TABLE trxHeader (
    idTrxHeader VARCHAR(255) NOT NULL DEFAULT 'TRH.'||lpad(nextval('idTrxHeader_seq')::text,5,'0'),
    idToko VARCHAR(255),
	tgl date, 
	idCust VARCHAR(255),
	totalPembelian int default 0,
    PRIMARY KEY (idTrxHeader)
);

-- create table transaction details
CREATE SEQUENCE idTrxDetil_seq START WITH 1;
CREATE TABLE trxDetil (
    idTrxDetil VARCHAR(255) NOT NULL DEFAULT 'TRD.'||lpad(nextval('idTrxDetil_seq')::text,5,'0'),
    idTrxHeader VARCHAR(255),
    idProduct VARCHAR(255),
	namaProduct varchar(255), 
	qty int default 0, 
	hargaJual int default 0, 
	total int default 0,
	PRIMARY KEY(idTrxDetil)
);

-- trigger for total transaction
CREATE OR REPLACE FUNCTION trxdetil_bef_ins0()
    RETURNS trigger
    LANGUAGE 'plpgsql'
    VOLATILE
    COST 100
AS $BODY$
	BEGIN
		new.total := new.qty * new.hargajual;
		UPDATE trxheader SET totalpembelian = totalpembelian + new.total WHERE idtrxheader = new.idtrxheader;
		RETURN NEW;
	END;
$BODY$;

DROP TRIGGER IF EXISTS trxdetil_bef_ins0
    ON trxdetil;
CREATE TRIGGER trxdetil_bef_ins0
    BEFORE INSERT
    ON trxdetil
    FOR EACH ROW
    EXECUTE PROCEDURE trxdetil_bef_ins0();

-- insert toko
INSERT INTO toko (namatoko, kota) 
VALUES ( 'cab_badung', 'badung'),
    ( 'cab_bangli', 'bangli'),
    ( 'cab_buleleng', 'buleleng'),
    ( 'cab_klungkung', 'klungkung'),
    ( 'cab_jembrana', 'jembrana'),
    ( 'cab_gianyar', 'gianyar'),
    ( 'cab_karangasem', 'karangasem'),
    ( 'cab_tabanan', 'tabanan'),
    ( 'cab_denpasar', 'denpasar'),
    ( 'cab_bekasi', 'bekasi'),
    ( 'cab_bandung', 'bandung'),
    ( 'cab_bogor', 'bogor');

-- insert product
INSERT INTO product (namaproduct, hargapokok, hargajual) 
VALUES 
( 'camera_a01', 400000, 500000),
( 'camera_a02', 300000, 400000),
( 'camera_a03', 200000, 300000),
( 'camera_a04', 300000, 350000),
( 'camera_a05', 320000, 380000),
( 'camera_a06', 620000, 800000),
( 'camera_a07', 520000, 680000),
( 'camera_a08', 440000, 600000),
( 'camera_a09', 350000, 420000),
( 'camera_b01', 410000, 510000),
( 'camera_b02', 380000, 480000),
( 'camera_b03', 360000, 460000);

-- insert customer
INSERT INTO customer (namacust, telp, email) 
VALUES 
( 'kusuma', '081234567890', 'kusuma@gmail.com'),
( 'agus', '081234567888', 'agus@gmail.com'),
( 'titah', '081234567999', 'titah@gmail.com'),
( 'wayan', '081234567000', 'wayan@gmail.com'),
( 'kadek', '081234567111', 'kadek@gmail.com'),
( 'komang', '081234567222', 'komang@gmail.com'),
( 'ketut', '081234567233', 'ketut@gmail.com'),
( 'michael', '081234567456', 'michael@gmail.com'),
( 'teddy', '081234567891', 'teddy@gmail.com'),
( 'surya', '081234567899', 'surya@gmail.com'),
( 'dede', '0812345678325', 'dede@gmail.com'),
( 'elon', '0812345678625', 'elon@gmail.com'),
( 'loremo', '0812345678679', 'loremo@gmail.com'),
( 'ipsuma', '0812345678220', 'ipsuma@gmail.com'),
( 'linus', '0812345678652', 'linus@gmail.com');

-- insert trxheader
INSERT INTO trxheader (idtoko, tgl, idcust) 
VALUES 
('TKO.00001', '2022-01-01', 'CST.00001'),
('TKO.00001', '2022-01-02', 'CST.00002'),
('TKO.00001', '2022-01-03', 'CST.00003'),
('TKO.00001', '2022-02-01', 'CST.00001'),
('TKO.00002', '2022-01-01', 'CST.00001'),
('TKO.00002', '2022-01-05', 'CST.00004'),
('TKO.00003', '2022-01-06', 'CST.00005'),
('TKO.00004', '2022-03-01', 'CST.00006'),
('TKO.00005', '2022-04-01', 'CST.00007'),
('TKO.00005', '2022-06-03', 'CST.00007'),
('TKO.00006', '2022-01-01', 'CST.00008'),
('TKO.00006', '2022-03-01', 'CST.00008'),
('TKO.00007', '2022-08-08', 'CST.00009'),
('TKO.00007', '2022-09-01', 'CST.00009'),
('TKO.00007', '2022-10-20', 'CST.00009'),
('TKO.00007', '2022-11-01', 'CST.00009'),
('TKO.00007', '2022-12-01', 'CST.00009'),
('TKO.00008', '2022-01-05', 'CST.00010'),
('TKO.00008', '2022-02-05', 'CST.00010'),
('TKO.00008', '2022-03-05', 'CST.00010'),
('TKO.00008', '2022-04-05', 'CST.00010'),
('TKO.00008', '2022-05-05', 'CST.00010'),
('TKO.00009', '2022-06-01', 'CST.00015'),
('TKO.00009', '2022-06-01', 'CST.00015'),
('TKO.00009', '2022-07-01', 'CST.00004'),
('TKO.00009', '2022-07-01', 'CST.00014'),
('TKO.00010', '2022-08-01', 'CST.00013'),
('TKO.00010', '2022-09-01', 'CST.00012'),
('TKO.00010', '2022-10-01', 'CST.00011'),
('TKO.00010', '2022-12-15', 'CST.00011');

-- insert trxdetil
INSERT INTO trxdetil (idtrxheader, idproduct, namaproduct, qty, hargajual) 
VALUES 
('TRH.00001', 'PRD.00001', 'camera_a01', 2, 500000),
('TRH.00002', 'PRD.00001', 'camera_a01', 2, 500000),
('TRH.00003', 'PRD.00001', 'camera_a01', 2, 500000),
('TRH.00004', 'PRD.00001', 'camera_a01', 2, 500000),
('TRH.00005', 'PRD.00001', 'camera_a01', 2, 500000),
('TRH.00006', 'PRD.00002', 'camera_a02', 2, 400000),
('TRH.00007', 'PRD.00003', 'camera_a03', 2, 300000),
('TRH.00008', 'PRD.00003', 'camera_a03', 2, 300000),
('TRH.00009', 'PRD.00004', 'camera_a04', 2, 350000),
('TRH.00010', 'PRD.00005', 'camera_a05', 2, 380000),
('TRH.00011', 'PRD.00002', 'camera_a02', 2, 400000),
('TRH.00012', 'PRD.00003', 'camera_a03', 2, 300000),
('TRH.00013', 'PRD.00006', 'camera_a06', 2, 800000),
('TRH.00014', 'PRD.00007', 'camera_a07', 2, 680000),
('TRH.00015', 'PRD.00008', 'camera_a08', 2, 600000),
('TRH.00016', 'PRD.00009', 'camera_a09', 2, 420000),
('TRH.00017', 'PRD.00006', 'camera_a06', 2, 800000),
('TRH.00018', 'PRD.00007', 'camera_a07', 2, 680000),
('TRH.00019', 'PRD.00009', 'camera_a09', 2, 420000),
('TRH.00020', 'PRD.00008', 'camera_a08', 2, 600000),
('TRH.00021', 'PRD.00007', 'camera_a07', 2, 680000),
('TRH.00022', 'PRD.00010', 'camera_b01', 2, 510000),
('TRH.00023', 'PRD.00010', 'camera_b01', 2, 510000),
('TRH.00024', 'PRD.00009', 'camera_a09', 2, 420000),
('TRH.00025', 'PRD.00009', 'camera_a09', 2, 420000),
('TRH.00026', 'PRD.00009', 'camera_a09', 2, 420000),
('TRH.00027', 'PRD.00008', 'camera_a08', 2, 600000),
('TRH.00028', 'PRD.00008', 'camera_a08', 2, 600000),
('TRH.00029', 'PRD.00008', 'camera_a08', 2, 600000),
('TRH.00030', 'PRD.00008', 'camera_a08', 2, 600000),
('TRH.00001', 'PRD.00007', 'camera_a07', 2, 680000),
('TRH.00002', 'PRD.00006', 'camera_a06', 2, 800000),
('TRH.00003', 'PRD.00005', 'camera_a05', 2, 380000),
('TRH.00004', 'PRD.00006', 'camera_a06', 2, 800000),
('TRH.00005', 'PRD.00005', 'camera_a05', 2, 380000),
('TRH.00006', 'PRD.00006', 'camera_a06', 2, 800000),
('TRH.00007', 'PRD.00005', 'camera_a05', 2, 380000);

-- query to view 10 user with highest total purchase amount
SELECT 
    namacust,
	cst.idcust,
    SUM(totalpembelian) AS total 
FROM trxheader trh
LEFT JOIN customer cst ON cst.idcust = trh.idcust
GROUP BY cst.idcust 
ORDER BY total DESC 
LIMIT 10;

-- query to view monthly total transaction based on shop
SELECT 
    namatoko,
    date_part('year', tgl) AS trx_year,
    date_part('month', tgl) AS trx_month,
    COALESCE(COUNT(idtrxheader), 0) as monthly_count,
    COALESCE(SUM(totalpembelian), 0) as monthly_sum
FROM trxheader trx
RIGHT JOIN toko tk ON tk.idtoko = trx.idtoko
GROUP BY tk.idtoko, trx_year, trx_month
order by trx_month ASC;

-- query to view total transaction based on city
SELECT 
    kota,
    COALESCE(COUNT(idtrxheader), 0) as trx_count,
    COALESCE(SUM(totalpembelian), 0) as trx_sum
FROM trxheader trx
RIGHT JOIN toko tk ON tk.idtoko = trx.idtoko
GROUP BY kota
order by kota ASC;

-- daily net margin based on shop
SELECT 
    tk.namatoko,
	TO_CHAR(tgl,'yyyy-mm-dd') AS trx_date,
    COALESCE(COUNT(DISTINCT(trx.idtrxheader)), 0) AS trx_count,
    COALESCE(SUM(trd.total), 0) AS trx_sum,
	COALESCE(SUM(prd.hargapokok), 0) AS hargapokok_sum,
	(COALESCE(SUM(trd.total), 0) - COALESCE(SUM(prd.hargapokok), 0)) AS net_margin
FROM trxheader trx
RIGHT JOIN toko tk ON tk.idtoko = trx.idtoko
LEFT JOIN trxdetil trd ON trd.idtrxheader = trx.idtrxheader
LEFT JOIN product prd ON trd.idproduct = prd.idproduct

GROUP BY tk.idtoko, trx_date
ORDER BY tk.idtoko, trx_date;

-- monthly net margin based on shop
SELECT 
    tk.namatoko,
	TO_CHAR(tgl,'yyyy-mm') AS trx_date,
    COALESCE(COUNT(DISTINCT(trx.idtrxheader)), 0) AS trx_count,
    COALESCE(SUM(trd.total), 0) AS trx_sum,
	COALESCE(SUM(prd.hargapokok), 0) AS hargapokok_sum,
	(COALESCE(SUM(trd.total), 0) - COALESCE(SUM(prd.hargapokok), 0)) AS net_margin
FROM trxheader trx
RIGHT JOIN toko tk ON tk.idtoko = trx.idtoko
LEFT JOIN trxdetil trd ON trd.idtrxheader = trx.idtrxheader
LEFT JOIN product prd ON trd.idproduct = prd.idproduct

GROUP BY tk.idtoko, trx_date
ORDER BY tk.idtoko, trx_date;