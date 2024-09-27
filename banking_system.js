const { SavingsAccount, rl } = require('./bank_account.js');

// Fungsi untuk menjalankan program
async function main() {
  const savingsAccount = new SavingsAccount(0);
  let isRunning = true;

  while (isRunning) {
    const pilihan = await savingsAccount._getUserInput(
      "\nPilih tindakan:\n1. Cek Saldo\n2. Deposit\n3. Penarikan\n4. Keluar\nPilih (1-4): "
    );

    switch (pilihan) {
      case 1:
        savingsAccount.showSaldo();
        break;
      case 2:
        console.log("Proses deposit sedang berlangsung...");
        await new Promise(resolve => setTimeout(resolve, 1000)); // Set timeout untuk deposit
        await savingsAccount.deposit();
        break;
      case 3:
        console.log("Proses withdraw sedang berlangsung...");
        await new Promise(resolve => setTimeout(resolve, 1000)); // Set timeout untuk withdraw
        await savingsAccount.withdraw();
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
