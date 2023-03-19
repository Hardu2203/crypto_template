import 'SmartContract.dart';

class MessageVerifier {

  final SmartContract _smC = SmartContract("assets/abi/MessageVerifier.abi", '0xC93005DA9BE5a74102f6BFAa79E50A34D64c32A4');

  Future<String> helloWorld() async {
    final res =  await _smC.makeReadCall('hello', []);
    return res[0].toString();
  }

  Future<String> greeting() async {
    final res =  await _smC.makeReadCall('greeting', ["gootentag"]);
    return res[0].toString();
  }


}