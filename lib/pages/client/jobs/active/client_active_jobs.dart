import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:taskmate/pages/client/jobs/active/client_active_job_card.dart';

class ClientActiveJobs extends StatefulWidget {
  const ClientActiveJobs({super.key});

  @override
  State<ClientActiveJobs> createState() => _ClientActiveJobsState();
}

class _ClientActiveJobsState extends State<ClientActiveJobs> {
  // List<String> _docIDs = [];

  //Getting docIDs
  // Future<void> getDocIDs() async {
  //   final snapshot =
  //       await FirebaseFirestore.instance.collection('client_active_jobs').get();
  //   _docIDs = snapshot.docs.map((element) => element.reference.id).toList();
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   // Use a Future inside initState to fetch data asynchronously
  //   // and use then to handle the result
  //   getDocIDs().then((_) {
  //     // Calling setState to rebuild the widget with the fetched data
  //     setState(() {});
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
        child: SizedBox(
          width: screenWidth,
          child: Column(
            children: [
              ClientActiveJobCard(),
            ],
          ),
        ),
      ),
    );
  }
}
