import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import '../../../../models/message_model.dart';
import 'package:get/get.dart';
import '../../../../services/httpsClients.dart';

class RegisterStepOneController extends GetxController {
  TextEditingController editingController = TextEditingController();
  HttpsClients httpsClients = HttpsClients();

  @override
  void onInit() {
    super.onInit();
  }

  Future<MessageModel> sendCode() async {
    var response = await httpsClients
        .post("api/sendCode", {"tel": editingController.text});
    if (response != null) {
      print(response);
      if (response.data["success"]) {
        //测试：把验证码复制到剪切板上面，正式上线不需要这句话,这个为了方便测试
        Clipboard.setData(ClipboardData(text: response.data["code"]));
        return MessageModel(message: '发送验证码成功', success: true);
      }
      return MessageModel(message: response.data['message'], success: false);
    } else {
      return MessageModel(message: '网络异常', success: false);
    }
  }
}
