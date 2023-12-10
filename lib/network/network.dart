class networkUrl {
  String URLserver = "https://absensiuas23.000webhostapp.com/API/";
  String absenmasuk() {
    return URLserver + 'absen_masuk.php';
  }

  String absenkeluar() {
    return URLserver + 'absen_keluar.php';
  }

  String getabsen() {
    return URLserver + 'getAbsen.php';
  }
}
