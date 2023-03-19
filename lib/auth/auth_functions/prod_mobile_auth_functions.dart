import 'package:url_launcher/url_launcher_string.dart';
import 'package:walletconnect_dart/walletconnect_dart.dart';
import '../../user/user_model.dart';
import 'auth_functions.dart';

class ProdMobileAuthFunctions implements AuthFunctions {
  String? _uri;
  SessionStatus? _session;

  var connector = WalletConnect(
      bridge: 'https://bridge.walletconnect.org',
      clientMeta: const PeerMeta(
          name: 'Swappi Swap',
          description: 'An awesome exchange',
          url: 'https://walletconnect.org',
          icons: [
            'https://files.gitbook.com/v0/b/gitbook-legacy-files/o/spaces%2F-LJJeCjcLrr53DcT1Ml7%2Favatar.png?alt=media'
          ]));

  @override
  Future<UserModel> login([UserModel? user]) async {
    if (!connector.connected) {
      try {
        var session = await connector.createSession(onDisplayUri: (uri) async {
          _uri = uri;
          await launchUrlString(uri, mode: LaunchMode.externalApplication);
        });
        _session = session;
        return UserModel("anon", _session!.accounts[0]);
      } catch (exp) {
        print(exp);
        throw Error();
      }
    }

    return user!;
  }

  Future<String?> signMessageWithMetamask(String message) async {
    if (connector.connected) {
      try {
        print("Message received");
        print(message);

        EthereumWalletConnectProvider provider =
            EthereumWalletConnectProvider(connector);
        launchUrlString(_uri!, mode: LaunchMode.externalApplication);
        var signature = await provider.personalSign(
            message: message, address: _session!.accounts[0], password: "");
        print(signature);
        return signature;
      } catch (exp) {
        print("Error while signing transaction");
        print(exp);
      }
    }
    return null;
  }
}
