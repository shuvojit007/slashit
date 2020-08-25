import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Option {
  const Option({this.title, this.id, this.icon});

  final String title;
  final String id;
  final IconData icon;
}

const List<Option> shopper = const <Option>[
  const Option(
      title: 'Transfer to bank', id: "bank", icon: FontAwesomeIcons.piggyBank),
  const Option(
      title: 'Transactions',
      id: "transactions",
      icon: FontAwesomeIcons.moneyBill),
  const Option(
      title: 'Manage Cards', id: "cards", icon: FontAwesomeIcons.creditCard),
  const Option(
      title: 'Requests', id: "request", icon: FontAwesomeIcons.history),
  const Option(
      title: 'Sign Out', id: "signout", icon: FontAwesomeIcons.signOutAlt),
];

const List<Option> business = const <Option>[
  const Option(
      title: 'Transfer to bank', id: "bank", icon: FontAwesomeIcons.piggyBank),
  const Option(
      title: 'Transactions',
      id: "transactions",
      icon: FontAwesomeIcons.moneyBill),
  const Option(
      title: 'Requests', id: "request", icon: FontAwesomeIcons.history),
  const Option(
      title: 'Sign Out', id: "signout", icon: FontAwesomeIcons.signOutAlt),
];
