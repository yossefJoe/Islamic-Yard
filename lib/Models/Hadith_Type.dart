class Hadithtype {
  String? name;
  String? id;
  int? available;

  Hadithtype({this.name, this.id, this.available});

  Hadithtype.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
    available = json['available'];
  }
}
