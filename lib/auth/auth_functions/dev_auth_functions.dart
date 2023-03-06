
import '../../user/user_model.dart';
import 'auth_functions.dart';

class DevAuthFunctions implements AuthFunctions {
  @override
  UserModel login([UserModel? user]) {
    return user!;
  }

}