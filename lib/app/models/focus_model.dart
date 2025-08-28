class FocusModel {
  List<FocusItem>? result;

  FocusModel({this.result});

  FocusModel.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      result = <FocusItem>[];
      json['result'].forEach((v) {
        result!.add(FocusItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (result != null) {
      data['result'] = result!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FocusItem {
  String? id;
  String? title;
  String? status;
  String? pic;
  String? url;
  int? position;

  FocusItem({this.id, this.title, this.status, this.pic, this.url, this.position});

  FocusItem.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    title = json['title'];
    status = json['status'];
    pic = json['pic'];
    url = json['url'];
    position = json['position'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['_id'] = id;
    data['title'] = title;
    data['status'] = status;
    data['pic'] = pic;
    data['url'] = url;
    data['position'] = position;
    return data;
  }
}

