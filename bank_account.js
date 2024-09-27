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

    async deposit() {                                   //deposit
        const amount = await this._getUserInput("Masukkan jumlah uang yang ingin Anda depositkan: ");
        if (!isNaN(amount) && amount > 0) {
            // Simulasi operasi deposit dengan delay 1 detik
            await new Promise((resolve) => setTimeout(resolve, 1000));
            this.saldo += parseFloat(amount);
            this.saveSaldo();
            console.log(`Anda berhasil mendepositkan Rp.${amount}. Saldo Anda sekarang: Rp.${this.saldo}`);
        } else {
            console.log("Masukkan jumlah deposit yang valid.");
        }
        return;
    }

    async withdraw() {                                //withdraw
        const amount = await this._getUserInput("Masukkan jumlah uang yang ingin Anda tarik: ");
        if (!isNaN(amount) && amount > 0 && amount <= this.saldo) {
            // Simulasi operasi withdraw dengan delay 1 detik
            await new Promise((resolve) => setTimeout(resolve, 1000));
            this.saldo -= parseFloat(amount);
            this.saveSaldo();
            console.log(`Anda berhasil menarik Rp.${amount}. Saldo Anda sekarang: Rp.${this.saldo}`);
        } else if (amount > this.saldo) {
            console.log("Saldo tidak mencukupi untuk melakukan penarikan.");
        } else {
            console.log("Masukkan jumlah penarikan yang valid.");
        }
        return;
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

// Ekspor kelas
module.exports = { bankAccount, SavingsAccount, rl };




