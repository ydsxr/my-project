import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/address_list_controller.dart';
import '../../../../services/screenAdapter.dart';

class AddressListView extends GetView<AddressListController> {
  const AddressListView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('收货地址'),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(ScreenAdapter.width(20)),
        child: Stack(
          children: [
            _body(),
            _bottom(),
          ],
        ),
      ),
    );
  }

  Widget _body() {
    return ListView(
      children: controller.addressList.map((v) {
        return Column(
          children: [
            ListTile(
              // 只有默认收货地址有check
              leading: const Icon(Icons.check, color: Colors.red),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${v.address}",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: ScreenAdapter.fontSize(48)),
                  ),
                  SizedBox(height: ScreenAdapter.height(24)),
                  Text("${v.name}  ${v.phone}"),
                ],
              ),
              trailing: const Icon(
                Icons.edit,
                color: Colors.blue,
              ),
            ),
            Divider(),
            SizedBox(height: ScreenAdapter.height(30))
          ],
        );
      }).toList(),
    );
  }

  Widget _bottom() {
    return Positioned(
        left: 0,
        right: 0,
        bottom: 0,
        child: InkWell(
          onTap: () {
            Get.toNamed("/address-add");
          },
          child: Container(
            decoration: BoxDecoration(
                color: Color.fromRGBO(251, 72, 5, 0.9),
                borderRadius: BorderRadius.circular(20)),
            height: ScreenAdapter.height(140),
            alignment: Alignment.center,
            child: const Text(
              "新建收货地址",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ));
  }
}
