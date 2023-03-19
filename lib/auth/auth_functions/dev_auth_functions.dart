
import '../../user/user_model.dart';
import 'auth_functions.dart';

class DevAuthFunctions implements AuthFunctions {
  @override
  Future<UserModel> login([UserModel? user]) async {
    return user!;
  }

}