Baik, berikut adalah versi rekap yang lebih formal dan terstruktur.

---

## **1. Menjalankan Impala Daemon**

Jalankan daemon Impala dalam urutan berikut pada node yang sesuai:

```bash
# Menjalankan StateStore (biasanya hanya pada satu node)
 /opt/impala/bin/impala.sh start statestored

# Menjalankan CatalogD (biasanya pada node yang sama dengan StateStore)
 /opt/impala/bin/impala.sh start catalogd

# Menjalankan Impalad (pada semua node worker)
 /opt/impala/bin/impala.sh start impalad
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
bash /opt/impala/shell/impala-shell -i localhost:21000
```

Catatan:

* Port default untuk `impalad` pada koneksi JDBC/Thrift adalah `21000`.
* Apabila terjadi kesalahan "Could not connect", hal ini dapat disebabkan oleh `impalad` yang belum berhasil bind ke port atau belum terhubung dengan Hive/HDFS.

---

## **3. Konfigurasi Symlink Hadoop dan Hive**

Impala memerlukan konfigurasi Hadoop dan Hive untuk dapat mengakses HDFS serta metadata Hive Metastore.
Buat symbolic link dari konfigurasi yang sudah ada ke direktori konfigurasi Impala:

```bash
ln -s /etc/hadoop/conf/core-site.xml /opt/impala/conf/core-site.xml
ln -s /etc/hadoop/conf/hdfs-site.xml /opt/impala/conf/hdfs-site.xml
ln -s /etc/hadoop/conf/yarn-site.xml /opt/impala/conf/yarn-site.xml
ln -s /etc/hive/conf/hive-site.xml /opt/impala/conf/hive-site.xml
```

Catatan:

* Pastikan file `hive-site.xml` berisi konfigurasi `hive.metastore.uris`.
* Tanpa konfigurasi tersebut, `catalogd` tidak dapat membaca metadata tabel Hive.

---

## **4. Pengaturan `impala-env.sh`**

Edit file `/opt/impala/conf/impala-env.sh` untuk menyesuaikan variabel lingkungan:

```bash
export JAVA_HOME=/usr/lib/jvm/java-1.8.0
export HADOOP_HOME=/opt/hadoop
export HADOOP_CONF_DIR=/etc/hadoop/conf
export HIVE_CONF_DIR=/etc/hive/conf
export LD_LIBRARY_PATH=$JAVA_HOME/jre/lib/amd64/server:$LD_LIBRARY_PATH
```

Catatan:

* `LD_LIBRARY_PATH` diperlukan agar `libjvm.so` dapat ditemukan.
* `HADOOP_CONF_DIR` dan `HIVE_CONF_DIR` memastikan Impala dapat langsung membaca konfigurasi tanpa perlu menyalin file secara manual.

---

Kalau diperlukan, saya bisa menambahkan satu bagian lagi yang menjelaskan arsitektur komponen Impala beserta alur komunikasinya.
Apakah Anda ingin saya buatkan juga penjelasan arsitekturnya?
