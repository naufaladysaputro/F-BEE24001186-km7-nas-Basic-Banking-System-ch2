// Mendefinisikan sebuah kelas bankAccount
class bankAccount {
    constructor() {      // Dijalankan ketika objek bankAccount dibuat
      this.saldo = parseFloat(localStorage.getItem("saldo")) || 0; // Inisialisasi properti saldo dengan nilai yang diambil dari localStorage dengan kunci "saldo"
    }
  
  
  
    simpanSaldo() {  // Untuk menyimpan saldo ke localStorage.
      localStorage.setItem("saldo", this.saldo.toString());  // Nilai saldo diubah ke tipe data string menggunakan toString().
      document.location.reload(); // Merefresh halaman web untuk menampilkan saldo yang diperbarui.
      return;
    }
  }
  
  // Membuat objek bank
  const bank = new bankAccount();   // Membuat objek baru bernama bank dari kelas bankAccount.
  
  // Tampilkan saldo di HTML.
  document.getElementById("saldo").innerHTML = new Intl.NumberFormat("id").format(   // Mencari elemen HTML dengan id "saldo" dan mengganti kontennya dengan saldo yang diperbarui.
      localStorage.getItem("saldo")                                                   // Memformat saldo yang diambil dari localStorage menggunakan format angka Indonesia.
  );
  