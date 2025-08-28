class CategoryModel {
  List<CategoryItem>? result;

  CategoryModel({this.result});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      result = <CategoryItem>[];
      json['result'].forEach((v) {
        result!.add(CategoryItem.fromJson(v));
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

class CategoryItem {
  String? id;
  String? title;
  int? status;
  String? pic;
  String? pid;
  int? sort;
  int? isBest;
  int? goProduct;
  String? productId;

  CategoryItem({
    this.id,
    this.title,
    this.status,
    this.pic,
    this.pid,
    this.sort,
    this.isBest,
    this.goProduct,
    this.productId,
  });

  CategoryItem.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    title = json['title'];
    status = json['status'];
    pic = json['pic'];
    pid = json['pid'];
    sort = json['sort'];
    isBest = json['is_best'];
    goProduct = json['go_product'];
    productId = json['product_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['_id'] = id;
    data['title'] = title;
    data['status'] = status;
    data['pic'] = pic;
    data['pid'] = pid;
    data['sort'] = sort;
    data['is_best'] = isBest;
    data['go_product'] = goProduct;
    data['product_id'] = productId;
    return data;
  }
}
