-- create table nasabah
CREATE TABLE nasabah (
    id BIGSERIAL PRIMARY KEY,  -- Menggunakan BIGSERIAL untuk id
    nama VARCHAR(255) NOT NULL,
    alamat TEXT NOT NULL,
    nomor_telepon VARCHAR(20) NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW(),
    deleted_at TIMESTAMP
);

-- jika ingin menggunakan perintah alter
ALTER TABLE nasabah
    ADD COLUMN created_at TIMESTAMP NOT NULL DEFAULT NOW(),
    ADD COLUMN updated_at TIMESTAMP DEFAULT NOW(),
    ADD COLUMN deleted_at TIMESTAMP;

-- membuat indexing
CREATE INDEX indexNasabah ON "nasabah" (nama);

-- kalau ingi menghapus tabel nasabah
DROP TABLE nasabah;