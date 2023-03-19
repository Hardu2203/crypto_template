
import 'package:crypto_template/user/user_model.dart';
import 'auth_functions.dart';
import  'js_stub.dart' if (dart.library.js) 'package:flutter_web3/flutter_web3.dart';


class ProdWebAuthFunctions implements AuthFunctions {

  @override
  Future<UserModel> login([UserModel? user]) async {
    final accs = await ethereum!.requestAccount();

    return UserModel("anon", accs.first);
  }

}