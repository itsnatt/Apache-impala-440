Baik, berikut adalah versi rekap yang lebih formal dan terstruktur.

---

## **1. Menjalankan Impala Daemon**

Jalankan daemon Impala dalam urutan berikut pada node yang sesuai:

```bash
# Menjalankan StateStore (biasanya hanya pada satu node)
/usr/yava/3.1.0.0-0000/impala/bin/impala.sh start statestored

# Menjalankan CatalogD (biasanya pada node yang sama dengan StateStore)
/usr/yava/3.1.0.0-0000/impala/bin/impala.sh start catalogd

# Menjalankan Impalad (pada semua node worker)
/usr/yava/3.1.0.0-0000/impala/bin/impala.sh start impalad
```

Catatan:

* `statestored` harus dijalankan sebelum komponen lainnya.
* `catalogd` akan menunggu koneksi ke Hive Metastore sebelum berfungsi penuh.
* Pastikan variabel lingkungan `HADOOP_HOME` dan `JAVA_HOME` telah diatur dengan benar.

---

## **2. Mengakses Impala Shell**

Impala Shell merupakan skrip Bash, bukan skrip Python.

Contoh koneksi:

```bash
bash /usr/yava/3.1.0.0-0000/impala/shell/impala-shell -i localhost:21000
```

Catatan:

* Port default untuk `impalad` pada koneksi JDBC/Thrift adalah `21000`.
* Apabila terjadi kesalahan "Could not connect", hal ini dapat disebabkan oleh `impalad` yang belum berhasil bind ke port atau belum terhubung dengan Hive/HDFS.

---

## **3. Konfigurasi Symlink Hadoop dan Hive**

Impala memerlukan konfigurasi Hadoop dan Hive untuk dapat mengakses HDFS serta metadata Hive Metastore.
Buat symbolic link dari konfigurasi yang sudah ada ke direktori konfigurasi Impala:

```bash
ln -s /etc/hadoop/conf/core-site.xml /usr/yava/3.1.0.0-0000/impala/conf/core-site.xml
ln -s /etc/hadoop/conf/hdfs-site.xml /usr/yava/3.1.0.0-0000/impala/conf/hdfs-site.xml
ln -s /etc/hadoop/conf/yarn-site.xml /usr/yava/3.1.0.0-0000/impala/conf/yarn-site.xml
ln -s /etc/hive/conf/hive-site.xml /usr/yava/3.1.0.0-0000/impala/conf/hive-site.xml
```

Catatan:

* Pastikan file `hive-site.xml` berisi konfigurasi `hive.metastore.uris`.
* Tanpa konfigurasi tersebut, `catalogd` tidak dapat membaca metadata tabel Hive.

---

## **4. Pengaturan `impala-env.sh`**

Edit file `/usr/yava/3.1.0.0-0000/impala/conf/impala-env.sh` untuk menyesuaikan variabel lingkungan:

```bash
next repo
```



## **5. Testing ***
Impala shell
 ```
bash /usr/yava/3.1.0.0-0000/impala/shell/impala-shell --protocol=beeswax -i localhost:21000
```
port
| Komponen        | Port  | 
| --------------- | ----- | 
| StateStore      | 25010 | 
| Catalog Service | 25020 |
| Impala Daemon   | 25000 | 

Catatan:

* `LD_LIBRARY_PATH` diperlukan agar `libjvm.so` dapat ditemukan.
* `HADOOP_CONF_DIR` dan `HIVE_CONF_DIR` memastikan Impala dapat langsung membaca konfigurasi tanpa perlu menyalin file secara manual.

---

Kalau diperlukan, saya bisa menambahkan satu bagian lagi yang menjelaskan arsitektur komponen Impala beserta alur komunikasinya.
Apakah Anda ingin saya buatkan juga penjelasan arsitekturnya?
