import 'package:flutter/material.dart';
import 'package:doctor_website/components/divider.dart';
import 'package:doctor_website/sr_home_view/_divs/footer_div.dart';
import 'package:doctor_website/sr_home_view/_divs/phone_div.dart';
import 'package:doctor_website/sr_home_view/_divs/social_div.dart';

// ignore: constant_identifier_names
const List<Widget> COLLECTIVEFOOTER = [
  GlobalDivider(),
  // social
  DivSocial(),
  //divider
  GlobalDivider(),
  //phone
  DivPhone(),
  // divider
  GlobalDivider(),
  // footer
  DivFooter(),
  // divider
  GlobalDivider(),
];
