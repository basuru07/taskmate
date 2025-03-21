import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:taskmate/components/dark_main_button.dart';
import 'package:taskmate/components/light_main_button.dart';
import 'package:taskmate/components/maintenance_page.dart';
import 'package:taskmate/constants.dart';

class ClientActiveJobPayment extends StatefulWidget {
  final String budgetField;
  final QueryDocumentSnapshot activeJobDoc;

  const ClientActiveJobPayment({required this.budgetField,
    required this.activeJobDoc,
    super.key
  });

  @override
  State<ClientActiveJobPayment> createState() => _ClientActiveJobPaymentState();
}

void requestPayment(QueryDocumentSnapshot activeJobDoc, BuildContext context) async {
  try {
    // Reference to Firestore document
    final DocumentReference docRef = activeJobDoc.reference;

    // Get the current time and date
    DateTime now = DateTime.now();
    String releaseDateTime = DateFormat('yyyy-MM-dd HH:mm:ss').format(now);

    // Update the 'paymentclient' field to 'release payment' and store the release time
    await docRef.update({
      'paymentclient': 'release payment',

      'CompleteJobTime': releaseDateTime,
    });

    // Show a success message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Payment released successfully.'),
      ),
    );
  } catch (e) {
    print('Error releasing payment: $e');
    // Handle errors here, e.g., show an error message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Error releasing payment: $e'),
      ),
    );
  }
}


class _ClientActiveJobPaymentState extends State<ClientActiveJobPayment> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      child: SizedBox(
        width: screenWidth,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Payment Summary',
              style: kJobCardTitleTextStyle.copyWith(color: kJetBlack),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 8.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:  <Widget>[
                  Text('Requested'),
                  Text('LKR.${widget.budgetField}'),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 8.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:  <Widget>[
                  Text('In Progress'),
                  Text('LKR. ${widget.activeJobDoc['Precentage']}'),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 8.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Released to Freelancer'),
                  Text(
                    'LKR. ${widget.activeJobDoc['releaseMoney']}',
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 50.0,
            ),
            DarkMainButton(
                title: 'Release Payment',
                process: () {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      return MaintenancePage(
                        [
                          const Image(
                            image: AssetImage('images/message.webp'),
                          ),
                          Text(
                            'Are You Sure?',
                            style: kSubHeadingTextStyle.copyWith(height: 0.5),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 8.0),
                            child: Text(
                              'If you choose Yes, then the amount will sent to freelancer account',
                              style: kTextStyle,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          DarkMainButton(
                            title: 'Yes, I ‘m Sure',
                            process: () {
                              requestPayment(widget.activeJobDoc, context); // Call the method to request payment
                              Navigator.of(context).pop();
                            },
                            screenWidth: screenWidth,
                          ),
                          LightMainButton(
                            title: 'Cancel',
                            process: () {
                              Navigator.of(context).pop();
                            },
                            screenWidth: screenWidth,
                          ),
                        ],
                      );
                    },
                  );
                  //TODO Request Payment functionality
                },
                screenWidth: screenWidth),
            LightMainButton(
                title: 'Message',
                process: () {
                  //TODO Forward to messaging functionality
                },
                screenWidth: screenWidth)
          ],
        ),
      ),
    );
  }
}
