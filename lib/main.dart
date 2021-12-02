// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:url_launcher/url_launcher.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  TextEditingController phoneController = TextEditingController();
  String phoneNumber = "";

  String onCountryChange(CountryCode countryCode) {
    phoneNumber = countryCode.toString();
    return phoneNumber;
  }

  Widget check() {
    // Use: https://wa.me/15551234567
    // Don't use: https://wa.me/+001-(555)1234567
    // int n1 = int.parse(phoneNumber);
    // int n2 = int.parse(phoneController.toString());
    // String s1 = "$n1";
    String s4 = phoneNumber;
    String s2 = phoneController.text;
    // String s3 = s1 + s2;
    String s5 = s2 + s4;
    print("Final: " + s5);
    // print(s3); //Final Value
    String url = "https://wa.me/" + s5;
    print("Full Text: " + phoneNumber + phoneController.text);
    return (ElevatedButton(
      onPressed: () async {
        final url1 = url;

        if (await canLaunch(url1)) {
          await launch(url1);
        } else {
          throw "Could not launch $url1";
        }
      },
      child: const Text('Final Button'),
    ));
    // return check();
  }

  @override
  Widget build(BuildContext context) {
    final phone = TextFormField(
      controller: phoneController,
      keyboardType: TextInputType.phone,
      autofocus: false,
      style: const TextStyle(
        fontSize: 14.0,
        color: Colors.black,
        fontWeight: FontWeight.w400,
      ),
    );

    final checkBtn = check();
    ElevatedButton(key: null, onPressed: check, child: const Text("Check"));

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Country Code Demo'),
        ),
        body: Center(
          child: ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.only(left: 24.0, right: 24.0),
              children: <Widget>[
                CountryCodePicker(
                  onChanged: onCountryChange,
                  // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                  initialSelection: 'IN',
                  favorite: const ['+91', 'IN'],
                  // optional. Shows only country name and flag
                  showCountryOnly: false,
                  // optional. Shows only country name and flag when popup is closed.
                  showOnlyCountryWhenClosed: false,
                  // optional. aligns the flag and the Text left
                  alignLeft: false,
                ),
                const SizedBox(height: 16.0),
                phone,
                const SizedBox(height: 16.0),
                checkBtn
              ]),
        ),
      ),
    );
  }
}
