class Tafseer {
  int? tafseerId;
  String? tafseerName;
  String? ayahUrl;
  int? ayahNumber;
  String? text;

  Tafseer(
      {this.tafseerId,
      this.tafseerName,
      this.ayahUrl,
      this.ayahNumber,
      this.text});

  Tafseer.fromJson(Map<String, dynamic> json) {
    tafseerId = json['tafseer_id'];
    tafseerName = json['tafseer_name'];
    ayahUrl = json['ayah_url'];
    ayahNumber = json['ayah_number'];
    text = json['text'];
  }
}
