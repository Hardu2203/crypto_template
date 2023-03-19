import 'package:crypto_template/contract/MessageVerifier.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BuyScreen extends StatelessWidget {
  BuyScreen({Key? key}) : super(key: key);

  final MessageVerifier messageVerifier = MessageVerifier();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Sell",
              style: GoogleFonts.permanentMarker(
                  textStyle: Theme.of(context).textTheme.titleLarge)),
        ),
        body: Center(
          child: Text("Lets Buy"),
        ));
  }
}
