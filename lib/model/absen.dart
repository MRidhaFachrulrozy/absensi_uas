class Absensi {
  String?nama;
  String?nim;
  String?tanggal;
  String?jam;
  String?statusKehadiran;

  Absensi({this.nama,this.nim,this.tanggal,this.jam,this.statusKehadiran});

  factory Absensi.fromJson(Map<String,dynamic>json){
    return Absensi(
      nama: json['nama'],
      nim: json['nim'],
      tanggal: json['tanggal'],
      jam: json['jam'],
      statusKehadiran: json['statusKehadiran'],
    );
  }
}