import 'package:flutter/material.dart';


class EmailViewPage extends StatelessWidget {
  final String emailSubject;
  final String emailContent;

  const EmailViewPage({
    Key? key,
    required this.emailSubject,
    required this.emailContent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Email'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              emailSubject,
              style: const TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10.0),
            Text(
              emailContent,
              style: const TextStyle(fontSize: 18.0),
            ),
          ],
        ),
      ),
    );
  }
}




// class EmailListTile extends StatelessWidget {
//   final Map<String, String> email;

//   EmailListTile({required this.email});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Card(
//         color: Colors.white.withOpacity(0.9),
//         child: ListTile(
//           leading: const Icon(Icons.email, color: Colors.teal),
//           title: Text(email['subject']!),
//           subtitle: Text(
//             email['content']!,
//             maxLines: 1,
//             overflow: TextOverflow.ellipsis,
//           ),
//           trailing: IconButton(
//             icon: const Icon(Icons.arrow_forward, color: Colors.teal),
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => EmailViewPage(
//                     emailSubject: email['subject']!,
//                     emailContent: email['content']!,
//                   ),
//                 ),
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }




// Page to display draft emails
// class DraftsPage extends StatelessWidget {
//   final List<Map<String, String>> drafts = [
//     {'subject': 'Draft 1', 'content': 'This is a draft email content.'},
//     {'subject': 'Draft 2', 'content': 'Another draft email content.'},
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Drafts'),
//         backgroundColor: Colors.teal,
//       ),
//       body: Container(
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             colors: [Colors.white, Colors.tealAccent],
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//           ),
//         ),
//         child: ListView.builder(
//           itemCount: drafts.length,
//           itemBuilder: (context, index) {
//             return Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Card(
//                 color: Colors.white.withOpacity(0.9),
//                 child: ListTile(
//                   leading: const Icon(Icons.drafts, color: Colors.teal),
//                   title: Text(drafts[index]['subject']!),
//                   subtitle: Text(
//                     drafts[index]['content']!,
//                     maxLines: 1,
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                   trailing: IconButton(
//                     icon: const Icon(Icons.edit, color: Colors.teal),
//                     onPressed: () {
//                       // Add action to edit draft
//                     },
//                   ),
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }


