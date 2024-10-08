-- perintah insert membuat dummy data dengan generate series

DO $$ 
DECLARE
    nasabah_id INT;
    akun_id INT;
    transaksi_id INT := 0;  -- Inisialisasi id untuk transaksi
    akun_counter INT := 0;  -- Inisialisasi counter untuk akun
BEGIN
    -- Insert ke tabel nasabah
    FOR i IN 1..10 LOOP
        INSERT INTO nasabah (id, nama, alamat, nomor_telepon)
        VALUES (i, 'Nasabah ' || i, 'Alamat ' || i, '08123456789' || i)
        RETURNING id INTO nasabah_id;

        -- Insert ke tabel akun untuk setiap nasabah
        FOR j IN 1..2 LOOP
            akun_counter := akun_counter + 1;  -- Increment counter untuk akun
            INSERT INTO akun (id, nasabah_id, nomer_rekening, jenis_akun, saldo)
            VALUES (
                akun_counter,  -- Menggunakan counter yang berurutan
                nasabah_id,
                'ACC' || lpad(akun_counter::text, 5, '0'),  -- Menggunakan akun_counter untuk nomer rekening
                CASE WHEN mod(j, 2) = 0 THEN 'tabungan'::JenisAkun ELSE 'deposito'::JenisAkun END, -- Cast ke JenisAkun
                round((random() * 10000)::numeric, 2)  -- Konversi hasil random() ke numeric
            )
            RETURNING id INTO akun_id;

            -- Insert ke tabel transaksi untuk setiap akun
            FOR k IN 1..3 LOOP
                transaksi_id := transaksi_id + 1;  -- Increment id transaksi
                INSERT INTO transaksi (id, akun_id, nomor_transaksi, jenis_transaksi, jumlah)
                VALUES (
                    transaksi_id,  -- Menggunakan transaksi_id yang berurutan
                    akun_id,
                    'TX' || lpad(transaksi_id::text, 10, '0'),  -- Menggunakan transaksi_id untuk nomor transaksi
                    CASE
                        WHEN mod(k, 3) = 0 THEN 'deposit'::JenisTransaksi
                        WHEN mod(k, 3) = 1 THEN 'penarikan'::JenisTransaksi
                        ELSE 'transfer'::JenisTransaksi
                    END,
                    round((random() * 1000)::numeric, 2)  -- Konversi hasil random() ke numeric
                );
            END LOOP; -- Akhir loop insert transaksi

        END LOOP; -- Akhir loop insert akun

    END LOOP; -- Akhir loop insert nasabah

END $$;

-- perintah delete untuk menghapus semua data dari tabel
DELETE FROM nasabah;  
DELETE FROM akun;    
DELETE FROM transaksi;

-- perintah select untuk mengambil semua data dari tabel
SELECT * FROM nasabah;
SELECT * FROM akun;
SELECT * FROM transaksi;

-- perintah inner join  nasabah dan akun
SELECT nasabah.nama, nasabah.nomor_telepon, 
akun.nomer_rekening, akun.jenis_akun, Akun.saldo 
FROM Nasabah INNER JOIN Akun 
ON nasabah.id = akun.nasabah_id;

-- perintah Inner Join antara tabel akun dan transaksi
SELECT a.id AS akun_id, a.nomer_rekening, a.jenis_akun, a.saldo,
    t.id AS transaksi_id, t.nomor_transaksi, t.jenis_transaksi, t.jumlah
FROM
    akun AS a
JOIN 
    transaksi AS t ON a.id = t.akun_id;

-- perintah update
-- # update nasabah
UPDATE nasabah 
SET nama = 'Naufal', updatedAt = CURRENT_TIMESTAMP
WHERE id = 1;

-- # update akun
UPDATE akun
SET jenis_akun = 'deposito', updatedAt = CURRENT_TIMESTAMP
WHERE id = 2;

-- # update transaksi
UPDATE transaksi
SET jenis_transaksi = 'transfer', jumlah = 1000, updatedAt = CURRENT_TIMESTAMP
WHERE id = 3;

-- perintah update untuk soft delete
UPDATE nasabah
SET deleted_at = NOW()
WHERE id = 11;

-- # CTE InformasiAkun
WITH InformasiAkun AS (
    SELECT n.nama AS nama_nasabah, a.nomer_rekening, a.jenis_akun, a.saldo
    FROM Nasabah n
    JOIN Akun a ON n.id = a.nasabah_id  
)
SELECT * FROM InformasiAkun;

-- perintah delete
-- # delete nasabah
DELETE FROM nasabah WHERE id = 1;

-- # delete akun
DELETE FROM akun WHERE id = 3;

-- # delete transaksi
DELETE FROM transaksi WHERE id = 1;

-- perintah insert kalau mau memasukkan data manual
-- # insert untuk tabel Nasabah
INSERT INTO Nasabah (nama, alamat, nomor_telepon) VALUES 
('naufal', 'Dusun rawa, Jati Agung', '081234567891'),
('ady', 'Bekasi', '081234567893');

-- # insert untuk tabel Nasabah
INSERT INTO akun (id_nasabah, nomer_rekening, jenis_akun, saldo) VALUES 
(1, 'ACC00001', 'deposito', '1000'),
(2, 'ACC00002', 'tabungan', '2000');

INSERT INTO transaksi (akun_id, nomor_transaksi, jenis_transaksi, jumlah) VALUES    
(1, 'TX00001', 'deposit', '1000'),
(2, 'TX00002', 'penarikan', '2000');

--- menambahkan data ke tabel nasabah dengan procedure call
CREATE OR REPLACE PROCEDURE tambah_nasabah(
    p_nama VARCHAR,
    p_alamat TEXT,
    p_nomor_telepon VARCHAR
)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO nasabah (nama, alamat, nomor_telepon, created_at, updated_at)
    VALUES (p_nama, p_alamat, p_nomor_telepon, NOW(), NOW());
END;
$$;

CALL tambah_nasabah('naufal', 'locomotif', '081234567890');

-- jika tidak bisa jalan
-- untuk melihat id nasabah ke berapa yang kita buat
SELECT nextval(pg_get_serial_sequence('nasabah', 'id'));

-- untuk membuat id max dari id yang sudah ada
SELECT MAX(id) FROM nasabah;

SELECT setval(pg_get_serial_sequence('nasabah', 'id'), (SELECT MAX(id) FROM nasabah));

-- lalu jalankan call nya lagi
CALL tambah_nasabah('naufal', 'locomotif', '081234567890');

SELECT * FROM nasabah;

--- menambahkan data ke tabel akun dengan procedure call
CREATE OR REPLACE PROCEDURE tambah_akun(
    p_nasabah_id BIGINT,
    p_nomer_rekening VARCHAR,
    p_jenis_akun JenisAkun
)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO akun (nasabah_id, nomer_rekening, jenis_akun, saldo, created_at, updated_at)
    VALUES (p_nasabah_id, p_nomer_rekening, p_jenis_akun, 0.00, NOW(), NOW());
END;
$$;

CALL tambah_akun(1, '1234567890', 'tabungan');

-- jika tidak bisa jalan
-- untuk melihat id akun ke berapa yang kita buat
SELECT nextval(pg_get_serial_sequence('akun', 'id'));

-- untuk membuat id max dari id yang sudah ada
SELECT MAX(id) FROM akun;

SELECT setval(pg_get_serial_sequence('akun', 'id'), (SELECT MAX(id) FROM akun));

-- lalu jalankan call nya lagi
CALL tambah_akun(1, 'ACC00001', 'tabungan');
CALL tambah_akun(1, 'ACC00002', 'deposito');

SELECT * FROM akun;

--- menambahkan data ke tabel transaksi dengan procedure call
CREATE OR REPLACE PROCEDURE tambah_transaksi(
    p_akun_id BIGINT,
    p_nomor_transaksi VARCHAR,
    p_jenis_transaksi JenisTransaksi,
    p_jumlah NUMERIC
)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO transaksi (akun_id, nomor_transaksi, jenis_transaksi, jumlah, created_at, updated_at)
    VALUES (p_akun_id, p_nomor_transaksi, p_jenis_transaksi, p_jumlah, NOW(), NOW());
END;
$$;

CALL tambah_transaksi(1, 'TRX123456', 'deposit', 100000.00);

-- jika tidak bisa jalan
-- untuk melihat id akun ke berapa yang kita buat
SELECT nextval(pg_get_serial_sequence('transaksi', 'id'));

-- untuk membuat id max dari id yang sudah ada
SELECT MAX(id) FROM transaksi;

SELECT setval(pg_get_serial_sequence('transaksi', 'id'), (SELECT MAX(id) FROM transaksi));

-- lalu jalankan call nya lagi
CALL tambah_transaksi(1, 'TRX123456', 'deposit', 100000.00);
CALL tambah_transaksi(1, 'TRX123456', 'penarikan', 100000.00);
CALL tambah_transaksi(1, 'TRX123456', 'transfer', 100000.00);


--- tambah kurangi / deposit withdraw  saldo akun
CREATE OR REPLACE PROCEDURE ubah_saldo(
    p_nomer_rekening VARCHAR,
    p_jumlah NUMERIC,
    p_jenis_transaksi VARCHAR  -- 'tambah' atau 'kurangi'
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_akun_id BIGINT;
BEGIN
    -- Mengambil ID akun berdasarkan nomor rekening
    SELECT id INTO v_akun_id
    FROM akun
    WHERE nomer_rekening = p_nomer_rekening;

    -- Pastikan akun ditemukan
    IF v_akun_id IS NULL THEN
        RAISE EXCEPTION 'Akun dengan nomor rekening % tidak ditemukan.', p_nomer_rekening;
    END IF;

    -- Menangani penambahan saldo
    IF p_jenis_transaksi = 'tambah' THEN
        UPDATE akun
        SET saldo = saldo + p_jumlah,
            updated_at = NOW()
        WHERE id = v_akun_id;

        -- Menambahkan transaksi untuk penambahan
        INSERT INTO transaksi (akun_id, nomor_transaksi, jenis_transaksi, jumlah, created_at, updated_at)
        VALUES (v_akun_id, 'TRX-' || NEXTVAL('transaksi_id_seq'), 'deposit', p_jumlah, NOW(), NOW());

    -- Menangani pengurangan saldo
    ELSIF p_jenis_transaksi = 'kurangi' THEN
        -- Pastikan saldo tidak negatif sebelum mengurangi
        IF (SELECT saldo FROM akun WHERE id = v_akun_id) < p_jumlah THEN
            RAISE EXCEPTION 'Saldo tidak cukup untuk penarikan dari akun dengan nomor rekening %.', p_nomer_rekening;
        END IF;

        UPDATE akun
        SET saldo = saldo - p_jumlah,
            updated_at = NOW()
        WHERE id = v_akun_id;

        -- Menambahkan transaksi untuk pengurangan
        INSERT INTO transaksi (akun_id, nomor_transaksi, jenis_transaksi, jumlah, created_at, updated_at)
        VALUES (v_akun_id, 'TRX-' || NEXTVAL('transaksi_id_seq'), 'penarikan', p_jumlah, NOW(), NOW());

    ELSE
        RAISE EXCEPTION 'Jenis transaksi tidak valid. Gunakan ''tambah'' atau ''kurangi''.';
    END IF;

END;
$$;

CALL ubah_saldo('ACC00019', 50000.00, 'tambah');
CALL ubah_saldo('ACC00019', 20.00, 'kurangi');

SELECT * FROM akun;
SELECT id, nomer_rekening, saldo FROM akun WHERE nomer_rekening = 'ACC00019';