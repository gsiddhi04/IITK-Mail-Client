import 'package:flutter/material.dart';
import 'view.dart';

class EmailListPage extends StatelessWidget {
  final List<Map<String, String>> emails = [
    {'subject': 'Meeting Reminder', 'content': 'Don\'t forget the meeting at 10 AM.'},
    {'subject': 'Lunch Plans', 'content': 'Are we still on for lunch today?'},
    {'subject': 'Project Update', 'content': 'The project is on track for completion.'},
    // Add more email data as needed
  ];

  EmailListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Email List'),
      ),
      body: ListView.builder(
        itemCount: emails.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: const Icon(Icons.email),
            title: Text(emails[index]['subject']!),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EmailViewPage(
                    emailSubject: emails[index]['subject']!,
                    emailContent: emails[index]['content']!,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
