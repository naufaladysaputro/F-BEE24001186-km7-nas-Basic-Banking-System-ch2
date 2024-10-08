# F-BEE24001186-km7-nas-Basic-Banking-System-ch2

<!-- PROJECT LOGO -->
<br />
<div align="center">
  <a href="https://github.com/othneildrew/Best-README-Template">
    <img src="images/logo.png" alt="Logo" width="80" height="80">
  </a>

  <h3 align="center">Basic-Banking-System</h3>

</div>

* run the program

   ```sh
   node banking_system.js
   ```

* Pseudocode

   ```sh
   Kelas bankAccount:
   Fungsi Konstruktor():
       saldo = readSaldoFromFile()

   Fungsi deposit():
       Input amount
       Jika amount > 0:
           Simulasikan penundaan 1 detik
           saldo += amount
           saveSaldo()
           Output "Anda berhasil mendepositkan Rp.amount. Saldo Anda sekarang: Rp.saldo"
       Lainnya:
           Output "Masukkan jumlah deposit yang valid."

   Fungsi withdraw():
       Input amount
       Jika amount > 0 dan amount <= saldo:
           Simulasikan penundaan 1 detik
           saldo -= amount
           saveSaldo()
           Output "Anda berhasil menarik Rp.amount. Saldo Anda sekarang: Rp.saldo"
       Jika amount > saldo:
           Output "Saldo tidak mencukupi untuk melakukan penarikan."
       Lainnya:
           Output "Masukkan jumlah penarikan yang valid."
   ```



## Flowchart


![App Screenshot](images/Flowchart.jpg)

# Challenge 3 Database

## Entitas yang Terlibat:
- Nasabah
- Akun
- Transaksi

## Atribut-atribut yang Relevan:
- Nasabah:
  - nasabah_id (Primary Key)
  - nama
  - alamat
  - nomor_telepon
  - created_at
  - updated_at
  - deleted_at

- Akun:
  - akun_id (Primary Key)
  - nasabah_id (Foreign Key)
  - jenis_akun (tabungan, deposito)
  - saldo
  - created_at
  - updated_at
  - deleted_at

- Transaksi:
  - transaksi_id (Primary Key)
  - akun_id (Foreign Key)
  - jenis_transaksi (deposit,  transfer, penarikan)
  - jumlah
  - created_at
  - updated_at
  - deleted_at


## ERD (Entity-Relationship Diagram):
![App Screenshot](images/erdbank.png)
