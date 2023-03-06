
import '../../user/user_model.dart';
import 'auth_functions.dart';

class ProdAuthFunctions implements AuthFunctions {
  @override
  UserModel login([UserModel? user]) {
    return user!;
  }

}