import 'package:flutter/material.dart';

bool isMobile(BuildContext context) {
  var width = MediaQuery.of(context).size.width;
  if (width <= 480) {
    return true;
  } else {
    return false;
  }
}

double sectionHeightHomepageView(BuildContext context) {
  return isMobile(context)
      ? MediaQuery.of(context).size.height * 0.5
      : MediaQuery.of(context).size.height * 0.6;
}

double sectionHeightHomepageViewAboutDiv(BuildContext context) {
  return isMobile(context)
      ? MediaQuery.of(context).size.height * 0.51
      : MediaQuery.of(context).size.height * 0.8;
}

double sectionHeightSocialFooter(BuildContext context) {
  return isMobile(context)
      ? MediaQuery.of(context).size.height * 0.11
      : MediaQuery.of(context).size.height * 0.15;
}
