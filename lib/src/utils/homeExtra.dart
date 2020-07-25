import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Option {
  const Option({this.title, this.icon});

  final String title;
  final IconData icon;
}

const List<Option> shopper = const <Option>[
  const Option(title: 'Transactions', icon: FontAwesomeIcons.moneyBill),
  const Option(title: 'Sign Out', icon: FontAwesomeIcons.signOutAlt),
];

const List<Option> business = const <Option>[
  const Option(title: 'Transactions', icon: FontAwesomeIcons.moneyBill),
  const Option(title: 'Payment History', icon: FontAwesomeIcons.history),
  const Option(title: 'Sign Out', icon: FontAwesomeIcons.signOutAlt),
];
