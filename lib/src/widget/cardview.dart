import 'package:credit_card_input_form/credit_card_input_form.dart';
import 'package:flutter/material.dart';
import 'package:slashit/src/resources/colors.dart';

class CardView extends StatefulWidget {
  @override
  _CardViewState createState() => _CardViewState();
}

class _CardViewState extends State<CardView> {
  // translate and customize captions
  final Map<String, String> customCaptions = {
    'PREV': 'Prev',
    'NEXT': 'Next',
    'DONE': 'Done',
    'CARD_NUMBER': 'Card Number',
    'CARDHOLDER_NAME': 'Cardholder Name',
    'VALID_THRU': 'Valid Thru',
    'SECURITY_CODE_CVC': 'Security Code (CVC)',
    'NAME_SURNAME': 'Name Surname',
    'MM_YY': 'MM/YY',
    'RESET': 'Reset',
  };
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: AnimatedContainer(
          color: creemWhite,
          duration: Duration(milliseconds: 300),
          // color: currentColor,
          child: Stack(children: [
            CreditCardInputForm(
              cardHeight: 200,
              frontCardColor: videoHeader,
              backCardColor: videoHeader,
              showResetButton: true,
              onStateChange: (currentState, cardInfo) {
                print(currentState);
                print(cardInfo);
              },
              customCaptions: customCaptions,
            ),
          ]),
        ),
      ),
    );
  }
}
