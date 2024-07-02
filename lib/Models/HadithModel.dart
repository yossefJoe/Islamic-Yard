class HadithData {
  String? name;
  String? id;
  int? available;
  Contents? contents;

  HadithData({this.name, this.id, this.available, this.contents});

  HadithData.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
    available = json['available'];
    contents = json['contents'] != null
        ? new Contents.fromJson(json['contents'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['id'] = this.id;
    data['available'] = this.available;
    if (this.contents != null) {
      data['contents'] = this.contents!.toJson();
    }
    return data;
  }
}

class Contents {
  int? number;
  String? arab;
  String? id;

  Contents({this.number, this.arab, this.id});

  Contents.fromJson(Map<String, dynamic> json) {
    number = json['number'];
    arab = json['arab'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['number'] = this.number;
    data['arab'] = this.arab;
    data['id'] = this.id;
    return data;
  }
}
