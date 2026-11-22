# wastewhistle_mobile

**WasteWhistle Mobile - Powered by Flutter**

## Anggota
- Ahmad Rafa Robyan 2506620721
- Justin Lie 2506591961
- Priskila Abigail Magaini 2506590252
- Syakira Aqilah Amru 2506541622
- Adriel Raynard Davis Sihotang 2506587150

## Deskripsi Aplikasi
Tumpukan sampah yang tidak kunjung hilang? Sudah melaporkannya ke pihak berwajib tetapi seringkali terlupakan? WasteWhistle adalah solusinya.
Aplikasi WasteWhistle adalah aplikasi melacak dan menetapkan keberadaan sampah yang dilaporkan oleh pengguna aplikasi. Pada aplikasi ini, para pengguna dapat melaporkan titik sampah yang belum dibersihkan dan menghasilkan poin yang dapat ditukarkan dengan hadiah. Laporan yang sudah dibuat akan diterima oleh para staf dan akan diatasi segera. 

Melalui aplikasi ini, pengguna dapat melacak kondisi dari laporan yang sudah dibuat. Selain itu, pengguna dapat mencari info mengenai lokasi bank sampah terdekat, serta mendapatkan edukasi tambahan mengenai pemilahan sampah.

## Daftar Modul
1. Dashboard - Menampilkan lokasi laporan dan bank sampah serta memiliki fitur komentar untuk para user (Rafa)
2. Directory - Menampilkan daftar lokasi bank sampah yang dapat diisi manual oleh staf atau diambil dari OpenStreetMap API (Justin)
3. Reporting - Membuat tiket report dari user agar titik lokasi sampah dapat diatasi oleh staf (Adriel)
4. Education - Membuat halaman edukasi bagi user, serta memperbolehkan staf untuk menambahkan informasi-informasi penting mengenai pengelolaan sampah (Syakira)
5. Rewards - Menghitung jumlah poin yang diperoleh oleh user dan menampilkan data hadiah yang dapat ditukarkan (Priskila)

## Peran Pengguna

- Pengguna Terdaftar: Dapat melaporkan adanya sampah yang terlihat di sekeliling mereka dan memberikan peringatan di aplikasi dengan keberadaan sampah lainnya, serta mengakses informasi mengenai lokasi bank sampah, edukasi, dan hadiah.

- Staf & Superuser: Dapat menambahkan lokasi bank sampah, informasi edukasi, serta data hadiah. Dapat menetapkan kondisi laporan yang diterima menjadi 'selesai' atau 'belum selesai'.

## Link Figma

https://www.figma.com/design/QfKI77MxBIhJvfUgibyrIF/WasteWhistle?node-id=233-546&t=glHIQ5naaoAtMKZi-0

## Integrasi Aplikasi Mobile dan Situs Web

Aplikasi Flutter dan situs web WasteWhistle menggunakan backend Django yang sama. Data disimpan dan dikelola di server di mana aplikasi mobile mengirim permintaan HTTP ke web service Django REST Framework (DRF), lalu menerima respons dalam format JSON. Dengan begitu, perubahan data yang dilakukan melalui situs web maupun aplikasi mobile mengacu pada sumber data yang sama.

Alur umumnya:

1. Aplikasi mengirim request ke alamat server PWS dengan path endpoint dan metode HTTP yang sesuai (`GET` untuk membaca, `POST` untuk membuat/menjalankan aksi, `PUT` atau `PATCH` untuk mengubah, dan `DELETE` untuk menghapus).
2. Untuk data yang memerlukan login, aplikasi menyertakan kredensial autentikasi sesuai endpoint. 
3. Django memeriksa izin, memvalidasi data melalui serializer, menjalankan proses pada database, dan mengirim status HTTP serta respons JSON. Aplikasi kemudian menampilkan data atau pesan hasil kepada pengguna.

Gunakan domain PWS sebagai base URL saat aplikasi terhubung ke server. Path di bawah merupakan path relatif terhadap domain tersebut.

### Comment

Prefix: `/comment-api/v1/`. Endpoint ini menggunakan sesi Django dan memerlukan pengguna terautentikasi.

| Endpoint | Metode | Fungsi |
|---|---|---|
| `/comment-api/v1/comments/` | `GET` | Mengambil komentar milik pengguna yang sedang login. Mendukung pencarian dengan parameter `?q=`. |
| `/comment-api/v1/comments/` | `POST` | Membuat komentar sebagai pengguna yang sedang login. |
| `/comment-api/v1/comments/<id>/` | `GET` | Mengambil detail komentar. |
| `/comment-api/v1/comments/<id>/` | `PUT`, `PATCH` | Mengubah komentar (izin mengikuti aturan pemilik komentar atau staf). |
| `/comment-api/v1/comments/<id>/` | `DELETE` | Menghapus komentar sesuai izin pemilik komentar atau staf. |

### Rewards

Prefix: `/reward-api/v1/rewards/`. Daftar dan detail hadiah dapat dibaca tanpa login. Pengelolaan hadiah memerlukan akun staf sedangkan penukaran memerlukan login.

| Endpoint | Metode | Fungsi |
|---|---|---|
| `/reward-api/v1/rewards/` | `GET` | Mengambil daftar hadiah. Filter opsional: `kategori`, `maks_poin`, dan `tersedia=1`. |
| `/reward-api/v1/rewards/<id>/` | `GET` | Mengambil detail hadiah. |
| `/reward-api/v1/rewards/` | `POST` | Menambahkan hadiah (staf). |
| `/reward-api/v1/rewards/<id>/` | `PUT`, `PATCH` | Mengubah hadiah (staf). |
| `/reward-api/v1/rewards/<id>/` | `DELETE` | Menghapus hadiah (staf). Hadiah yang pernah ditukar tidak dapat dihapus. |
| `/reward-api/v1/rewards/<id>/redeem/` | `POST` | Menukar poin pengguna dengan hadiah dan menghasilkan kode voucher (login). |
| `/reward-api/v1/rewards/me/` | `GET` | Mengambil ringkasan poin, level, voucher, dan riwayat transaksi pengguna. |

### Directory

Prefix: `/directory-api/v1/`. Data bank sampah dapat dibaca tanpa login sedangkan operasi tulis mengikuti izin pemilik data atau staf.

| Endpoint | Metode | Fungsi |
|---|---|---|
| `/directory-api/v1/wastebanks/` | `GET` | Mengambil daftar bank sampah dengan mendukung pencarian nama, alamat, kontak, atau email dengan `?name=`. |
| `/directory-api/v1/wastebanks/` | `POST` | Menambahkan data bank sampah sesuai izin. |
| `/directory-api/v1/wastebanks/<uuid>/` | `GET` | Mengambil detail satu bank sampah. |
| `/directory-api/v1/wastebanks/<uuid>/` | `PUT`, `PATCH` | Mengubah data bank sampah sesuai izin. |
| `/directory-api/v1/wastebanks/<uuid>/` | `DELETE` | Menghapus data bank sampah sesuai izin. |

### Education

Prefix: `/education-api/v1/`. Konten edukasi dapat dibaca tanpa login sedangkan pembuatan, perubahan, dan penghapusan konten hanya untuk staf. Operasi kuis memerlukan autentikasi pengguna. Endpoint modul ini menerima autentikasi sesi atau token.

| Endpoint | Metode | Fungsi |
|---|---|---|
| `/education-api/v1/auth/token/` | `POST` | Meminta token autentikasi menggunakan kredensial akun. |
| `/education-api/v1/auth/token/revoke/` | `POST` | Mencabut token pengguna yang sedang digunakan. |
| `/education-api/v1/waste-guides/` | `GET`, `POST` | Membaca daftar panduan (opsional `?q=`) atau menambah panduan (staf). |
| `/education-api/v1/waste-guides/<uuid>/` | `GET`, `PUT`, `PATCH`, `DELETE` | Membaca detail atau mengelola panduan (perubahan hanya untuk staf). |
| `/education-api/v1/decomposition-infos/` | `GET`, `POST` | Membaca daftar informasi waktu penguraian atau menambah data (staf). |
| `/education-api/v1/decomposition-infos/<uuid>/` | `GET`, `PUT`, `PATCH`, `DELETE` | Membaca detail atau mengelola informasi waktu penguraian (perubahan hanya untuk staf). |
| `/education-api/v1/myths-facts/` | `GET`, `POST` | Membaca daftar mitos/fakta atau menambah data (staf). |
| `/education-api/v1/myths-facts/<uuid>/` | `GET`, `PUT`, `PATCH`, `DELETE` | Membaca detail atau mengelola data mitos/fakta (perubahan hanya untuk staf). |
| `/education-api/v1/quiz/today/` | `GET` | Memeriksa status dan mengambil kuis harian pengguna. |
| `/education-api/v1/quiz/start/` | `POST` | Memulai kuis harian. |
| `/education-api/v1/quiz/answer/` | `POST` | Mengirim jawaban sebuah soal dan menerima umpan balik. |
| `/education-api/v1/quiz/attempts/` | `GET`, `POST` | Mengambil riwayat kuis yang selesai (`GET`) atau mengirim hasil kuis hari ini (`POST`). |

### Reporting

Prefix: `/report-api/v1/`. Seluruh endpoint berikut membutuhkan autentikasi. API Reporting terpisah dari halaman web lama di `/reporting/`.

| Endpoint | Metode | Fungsi |
|---|---|---|
| `/report-api/v1/auth/token/` | `POST` | Meminta token autentikasi menggunakan kredensial akun. |
| `/report-api/v1/reports/` | `GET` | Mengambil riwayat laporan milik pengguna. |
| `/report-api/v1/reports/` | `POST` | Membuat laporan atas nama pengguna yang masuk. |
| `/report-api/v1/reports/map/` | `GET` | Mengambil titik dan status semua laporan untuk peta bersama. |
| `/report-api/v1/reports/{id}/` | `GET`, `PUT`, `PATCH` | Membaca atau mengubah laporan milik pengguna. |
| `/report-api/v1/reports/{id}/` | `DELETE` | Menghapus laporan milik pengguna. Staf dan superuser juga dapat menghapus laporan warga. |
| `/report-api/v1/reports/{id}/resolve/` | `POST` | Menandai laporan selesai sebagai pelapor, staf, atau superuser. |

## Checkpoint 1 — Reporting

Dari tab mana pun, pilih **Lapor Sampah** di kanan atas. Halaman ini menampilkan kerangka formulir sesuai Figma. **Kembali**, **Batal**, dan tombol kembali perangkat membuka tab asal. Memilih tab di bawah formulir langsung membuka modul tersebut. Pada checkpoint ini, pengguna bisa mencoba isian teks. Peta dan foto berupa pratinjau, dan tombol kirim belum aktif.

## Alur integrasi mobile dan web

Flutter akan memakai akun dari situs WasteWhistle. Untuk Reporting, klien memperoleh token melalui `POST /report-api/v1/auth/token/` dengan `username` dan `password`, lalu mengirim header `Authorization: Token <token>` pada permintaan berikutnya. API DRF memvalidasi data, menetapkan pelapor dari akun yang masuk, dan menyimpan laporan pada model Django yang juga dibaca situs PWS. Satu laporan baru menghasilkan 10 poin melalui modul Rewards. Perubahan status oleh petugas di web akan terlihat saat aplikasi memuat ulang laporan.

Dashboard memakai laporan bersama untuk peta dan API komentar untuk diskusi. Directory menyediakan lokasi bank sampah, Education menyajikan materi dan kuis, dan Rewards menyediakan katalog hadiah, penukaran, dan saldo poin. Implementasi klien mobile untuk alur data tersebut masuk tahap berikutnya.

Contoh isi JSON untuk membuat laporan:

```json
{
  "title": "Sampah di dekat halte",
  "latitude": "-6.208800",
  "longitude": "106.845600",
  "location_note": "Di samping jembatan",
  "description": "Dua kantong plastik menutup saluran air.",
  "submission_id": "380ca60b-2e90-478b-ac5c-19090e1afffb"
}
```

Judul, koordinat, dan deskripsi wajib diisi. `location_note` dan `submission_id` opsional. Klien dapat membuat satu UUID per laporan dan memakainya kembali saat mengulangi pengiriman. Respons pertama adalah `201`. Pengulangan dengan isi identik menghasilkan `200` dan ID laporan yang sama. Pemakaian UUID yang sama untuk isi berbeda menghasilkan `409`. Input tidak valid menghasilkan `400` dengan pesan per kolom.

### Menjalankan dan memeriksa

Di repositori Flutter, jalankan `flutter pub get`, lalu `flutter run`. Gunakan `flutter test` untuk memeriksa navigasi Reporting.

Di repositori Django yang sudah memuat perubahan Reporting, jalankan perintah berikut.

```sh
python -m pip install -r requirements.txt
python manage.py migrate
python manage.py test reporting.test_api
python manage.py runserver
```

API lokal dapat diakses melalui `http://127.0.0.1:8000/report-api/v1/reports/`. Permintaan tanpa autentikasi menghasilkan `401`. Untuk mencoba dengan akun lokal, masuk melalui `/api-auth/login/` atau gunakan token seperti dijelaskan di atas. Ketersediaan endpoint di PWS mengikuti versi backend yang telah dideploy.

## Tautan proyek

- [Desain Figma WasteWhistle](https://www.figma.com/design/QfKI77MxBIhJvfUgibyrIF/WasteWhistle?node-id=233-546&p=f)
- [Situs WasteWhistle di PWS](https://ahmad-rafa-wastewhistle9b.pws.cs.ui.ac.id/)
- [Repositori Django](https://github.com/pbp-kelompok-b9/WasteWhistle)
- APK akan ditambahkan setelah Checkpoint 1.
- Peta pratinjau Jakarta menggunakan [© OpenStreetMap contributors](https://www.openstreetmap.org/copyright).
