-- create table transaksi
CREATE TYPE JenisTransaksi AS ENUM ('deposit', 'penarikan', 'transfer');
CREATE TABLE transaksi (
    id BIGSERIAL PRIMARY KEY,  -- Menggunakan BIGSERIAL untuk id
    akun_id BIGINT REFERENCES akun(id) ON DELETE CASCADE,  -- BIGINT untuk menghubungkan ke BIGSERIAL
    nomor_transaksi VARCHAR(20) NOT NULL,
    jenis_transaksi JenisTransaksi NOT NULL,
    jumlah NUMERIC(12, 2) NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW(),
    deleted_at TIMESTAMP
);

-- jika ingin menggunakan perintah alter
ALTER TABLE transaksi
    ADD COLUMN created_at TIMESTAMP NOT NULL DEFAULT NOW(),
    ADD COLUMN updated_at TIMESTAMP DEFAULT NOW(),
    ADD COLUMN deleted_at TIMESTAMP;

-- membuat indexing
CREATE INDEX indexTransaksi ON "transaksi" (nomor_transaksi);

-- kalau ingin menghapus tabel transaksi
DROP TABLE transaksi;