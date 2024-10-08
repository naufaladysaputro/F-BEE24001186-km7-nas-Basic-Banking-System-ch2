-- create table akun
CREATE TYPE JenisAkun AS ENUM ('tabungan', 'deposito');
CREATE TABLE akun (
    id BIGSERIAL PRIMARY KEY,  -- Menggunakan BIGSERIAL untuk id
    nasabah_id BIGINT REFERENCES nasabah(id) ON DELETE CASCADE,  -- BIGINT untuk menghubungkan ke BIGSERIAL
    nomer_rekening VARCHAR(20) NOT NULL,  -- Mengganti nomor_akun menjadi nomer_rekening
    jenis_akun JenisAkun NOT NULL,
    saldo NUMERIC(12, 2) DEFAULT 0.00,
    created_at TIMESTAMP NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW(),
    deleted_at TIMESTAMP
);

-- kalau ingin menghapus jenis akun
DROP TYPE IF EXISTS JenisAkun;

-- jika ingin menggunakan perintah alter
ALTER TABLE account
    ADD COLUMN created_at TIMESTAMP NOT NULL DEFAULT NOW(),
    ADD COLUMN updated_at TIMESTAMP DEFAULT NOW(),
    ADD COLUMN deleted_at TIMESTAMP;

-- membuat indexing
CREATE INDEX indexAkun ON "akun" (nomer_rekening);

-- kalau ingi menghapus tabel akun
DROP TABLE akun;