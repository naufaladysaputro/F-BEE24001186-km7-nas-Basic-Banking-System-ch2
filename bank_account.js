// Mendefinisikan sebuah kelas bankAccount
class bankAccount {
    constructor() {      // Dijalankan ketika objek bankAccount dibuat
      this.saldo = parseFloat(localStorage.getItem("saldo")) || 0; // Inisialisasi properti saldo dengan nilai yang diambil dari localStorage dengan kunci "saldo"
    }
  
    tambahSaldo() {   // Menambahkan saldo ke rekening.
      const inputTambahJumlah = parseFloat(window.prompt("Silakan masukkan nominal saldo yang ingin ditambahkan:")); // Memasukkan nominal saldo yang ingin ditambahkan melalui window.prompt
      if (!isNaN(inputTambahJumlah) && inputTambahJumlah > 0) {  // Memeriksa inputan lebih besar dari 0
        this.saldo += inputTambahJumlah;
        this.simpanSaldo();
      } else {
        window.alert("Silakan masukkan nominal saldo yang sesuai.");  // Menggunakan window.alert untuk menampilkan pesan kesalahan
      }
      return;
    }
  
    kurangiSaldo() {  // Mengurangi saldo dari rekening.
      const inputKurangJumlah = parseFloat(window.prompt("Silakan masukkan nominal saldo yang ingin dikurangkan:")); // Memasukkan nominal saldo yang ingin dikurangkan melalui window.prompt
      if (!isNaN(inputKurangJumlah) && inputKurangJumlah > 0 && inputKurangJumlah <= this.saldo) {  // Memeriksa inputan valid dan mencukupi saldo
        this.saldo -= inputKurangJumlah;
        this.simpanSaldo();
      } else {
        window.alert("Silakan masukkan nominal saldo yang sesuai atau pastikan saldo mencukupi."); // Menggunakan window.alert untuk menampilkan pesan kesalahan
      }
      return;
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
  