class AddressModel {
  bool? success;
  String? message;
  List<AddressItemModel>? result;
  AddressModel({this.success, this.message, this.result});

  // 定义一个转化map类型数据的方法
  AddressModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    //注意，这里的result是可空类型的
    if (json['result'] != null) {
      // 先将result置为空
      result = <AddressItemModel>[];
      json['result'].forEach((v) {
        result?.add(AddressItemModel.fromJson(v));
      });
    }
  }
}

class AddressItemModel {
  String? sId;
  String? uid;
  String? name;
  String? phone;
  String? address;
  int? defaultAddress;
  int? status;
  AddressItemModel(this.sId, this.uid, this.name, this.phone, this.address,
      this.defaultAddress, this.status);

  AddressItemModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    uid = json['uid'];
    name = json['name'];
    phone = json['phone'];
    address = json['address'];
    defaultAddress = json['default_address'];
    status = json['status'];
  }
}
