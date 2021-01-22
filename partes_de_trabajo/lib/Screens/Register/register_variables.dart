import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

launchURL() async {
  const url = 'https://flutter.io';
  if (await canLaunch(url)) {
    await launch(url);
  }
}

var register_company = TextEditingController();
var register_email = TextEditingController();
var register_password = TextEditingController();


var email_login      = TextEditingController();
var password_login   = TextEditingController();




































