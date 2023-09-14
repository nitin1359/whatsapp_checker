// ignore_for_file: avoid_print, unnecessary_brace_in_string_interps, unused_import

import 'package:flutter/material.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:url_launcher/url_launcher.dart';

void main() => runApp(MyApp());

// ignore: use_key_in_widget_constructors
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String number = "";
  String fCountryCode = "91";
  // List<String> history = [];

  check() async {
    String url = "https://wa.me/${fCountryCode}${number}";
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'could not lauch url';
    }
    // history.addAll(number);
  }

  String onCountryChange(CountryCode countryCode) {
    setState(() {
      fCountryCode = countryCode.toString();
      print(fCountryCode);
    });
    return fCountryCode;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Whatsapp Checker'),
        ),
        body: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Padding(
            padding: const EdgeInsets.only(left: 0, right: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Padding(
                //   padding: const EdgeInsets.only(left: 24, right: 24),
                //   child: ListView(
                // shrinkWrap: true,
                // // physics: NeverScrollableScrollPhysics(),
                // children: [
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: CountryCodePicker(
                        onChanged: onCountryChange,
                        initialSelection: 'IN',
                        favorite: const ['+91', 'IN'],
                        // optional. Shows only country name and flag
                        showCountryOnly: false,
                        // optional. Shows only country name and flag when popup is closed.
                        showOnlyCountryWhenClosed: false,
                        // optional. aligns the flag and the Text left
                        alignLeft: false,
                      ),
                    ),
                    Expanded(
                      flex: 6,
                      child: TextFormField(
                        onChanged: (value) {
                          // value is anounymous function here
                          setState(() {
                            number = value;
                          });
                        },
                        decoration: const InputDecoration(
                          hintText: 'Enter mobile',
                        ),
                        keyboardType: TextInputType.phone,
                        autofocus: false,
                        style: const TextStyle(
                          fontSize: 14.0,
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),

                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: ElevatedButton(
                      onPressed: check, child: const Text("Check on Whatsapp")),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
