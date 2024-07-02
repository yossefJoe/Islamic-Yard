class Dua {
  int? id;
  String? title;
  String? category;
  String? categoryName;
  String? arabic;
  String? latin;
  String? translation;
  String? fawaid;
  String? source;

  Dua(
      {this.id,
      this.title,
      this.category,
      this.categoryName,
      this.arabic,
      this.latin,
      this.translation,
      this.fawaid,
      this.source});

  Dua.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    category = json['category'];
    categoryName = json['categoryName'];
    arabic = json['arabic'];
    latin = json['latin'];
    translation = json['translation'];
    fawaid = json['fawaid'];
    source = json['source'];
  }
}
