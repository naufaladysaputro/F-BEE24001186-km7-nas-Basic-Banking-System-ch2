const fs = require('fs');                 
const readline = require('readline');
const rl = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

// Nama file untuk menyimpan saldo
const saldoFile = 'saldo.txt';

// Fungsi untuk membaca saldo dari file
function readSaldoFromFile() {
    if (fs.existsSync(saldoFile)) {
        const data = fs.readFileSync(saldoFile, 'utf-8');
        return parseFloat(data) || 0;
    } else {
        return 0; // Jika file tidak ada, saldo default adalah 0
    }
}

// Fungsi untuk menyimpan saldo ke file
function saveSaldoToFile(saldo) {
    fs.writeFileSync(saldoFile, saldo.toString(), 'utf-8');
}

// Mendefinisikan sebuah kelas bankAccount
class bankAccount {
    constructor(saldo) {
        // Load saldo dari file, jika ada
        this.saldo = readSaldoFromFile() || saldo;       //membaca saldo di saldo.txt
    }



    saveSaldo() {                          
        // Simpan saldo ke file
        saveSaldoToFile(this.saldo);          
        return;
    }

    _getUserInput(questionText) {          //bankaccount
        return new Promise((resolve) => rl.question(questionText, (input) => resolve(parseFloat(input))));
      }
}

// Definisi kelas SavingsAccount (subclass)
class SavingsAccount extends bankAccount {
    constructor(saldo) {
      super(saldo);
    }
  
    showSaldo() {
      console.log(`Saldo Anda saat ini: Rp.${this.saldo}`);
    }
  }

  // Fungsi untuk menjalankan program
async function main() {
    const savingsAccount = new SavingsAccount(0);
    let isRunning = true;
  
    while (isRunning) {
      const pilihan = await savingsAccount._getUserInput(
        "\nPilih tindakan:\n1. Cek Saldo\n2. Deposit\n3. Withdraw\n4. Keluar\nPilih (1-4): "
      );
  
      switch (pilihan) {
        case 1:
          savingsAccount.showSaldo();
          break;
        case 2:
          
          break;
        case 3:

          break;
        case 4:
          console.log("Terima kasih! Program berakhir.");
          isRunning = false;
          break;
        default:
          console.log("Pilihan tidak valid, silakan coba lagi.");
          break;
      }
    }
  
    rl.close(); // Menutup readline ketika selesai
  }
  
  // Menjalankan program utama
  main();


