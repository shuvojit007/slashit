import 'package:flutter/material.dart';

class Option {
  const Option({this.title, this.id, this.icon});

  final String title;
  final String id;
  final IconData icon;
}

const List<Option> shopper = const <Option>[
//  const Option(
//      title: 'Transfer to bank', id: "bank", icon: FontAwesomeIcons.piggyBank),
  const Option(
      title: 'Transactions', id: "transactions", icon: Icons.art_track),
  const Option(title: 'Manage Cards', id: "cards", icon: Icons.credit_card),
//  const Option(
//      title: 'Requests', id: "request", icon: FontAwesomeIcons.history),
  const Option(title: 'Sign Out', id: "signout", icon: Icons.exit_to_app),
];

const List<Option> business = const <Option>[
  const Option(
      title: 'Transfer to bank', id: "bank", icon: Icons.account_balance),
  const Option(
      title: 'Transactions', id: "transactions", icon: Icons.art_track),
  const Option(title: 'Requests', id: "request", icon: Icons.history),
  const Option(title: 'Sign Out', id: "signout", icon: Icons.exit_to_app),
];

const List<Option> website = const <Option>[
//  const Option(
//      title: 'Transfer to bank', id: "bank", icon: FontAwesomeIcons.piggyBank),
  const Option(title: 'Refresh', id: "refresh", icon: Icons.art_track),
  const Option(
      title: 'Open in default browser', id: "browser", icon: Icons.credit_card),
//  const Option(
//      title: 'Requests', id: "request", icon: FontAwesomeIcons.history),
  const Option(
      title: 'Go Back to Slashit', id: "goback", icon: Icons.exit_to_app),
];
