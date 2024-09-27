
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
}

// Membuat objek bank
const bank = new bankAccount();   // Membuat objek baru bernama bank dari kelas bankAccount.


