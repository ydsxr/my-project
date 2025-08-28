class ProductListModel {
  List<ProductItem>? result;

  ProductListModel({this.result});

  factory ProductListModel.fromJson(Map<String, dynamic> json) {
    return ProductListModel(
      result: json['result'] != null
          ? (json['result'] as List)
              .map((item) => ProductItem.fromJson(item))
              .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'result': result?.map((item) => item.toJson()).toList(),
    };
  }
}

class ProductItem {
  String? id;
  String? title;
  String? cid;
  int? price;
  String? pic;
  String? subTitle;
  String? sPic;

  ProductItem({
    this.id,
    this.title,
    this.cid,
    this.price,
    this.pic,
    this.subTitle,
    this.sPic,
  });

  factory ProductItem.fromJson(Map<String, dynamic> json) {
    return ProductItem(
      id: json["_id"],
      title: json["title"],
      cid: json["cid"],
      price: json["price"],
      pic: json["pic"],
      subTitle: json["sub_title"],
      sPic: json["s_pic"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'title': title,
      'cid': cid,
      'price': price,
      'pic': pic,
      'sub_title': subTitle,
      's_pic': sPic,
    };
  }
}
