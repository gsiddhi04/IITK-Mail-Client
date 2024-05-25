import 'package:flutter/material.dart';
import 'view.dart';

class EmailListPage extends StatefulWidget {
  @override
  _EmailListPageState createState() => _EmailListPageState();
}

class _EmailListPageState extends State<EmailListPage> {
  final List<Map<String, String>> inboxEmails = [
    {'subject': 'Meeting Reminder', 'content': 'Don\'t forget the meeting at 10 AM.'},
    {'subject': 'Lunch Plans', 'content': 'Are we still on for lunch today?'},
    {'subject': 'Project Update', 'content': 'The project is on track for completion.'},
  ];

  final List<Map<String, String>> sentEmails = [
    {'subject': 'Monthly Report', 'content': 'The monthly report is attached.'},
    {'subject': 'Party Invitation', 'content': 'You are invited to our annual party.'},
  ];

  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> filteredInboxEmails = inboxEmails
        .where((email) =>
            email['subject']!.toLowerCase().contains(searchQuery.toLowerCase()) ||
            email['content']!.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();

    List<Map<String, String>> filteredSentEmails = sentEmails
        .where((email) =>
            email['subject']!.toLowerCase().contains(searchQuery.toLowerCase()) ||
            email['content']!.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Email List'),
        actions: [
          IconButton(
            icon: const Icon(Icons.create),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ComposeEmailPage(),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.drafts),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DraftsPage(),
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: const InputDecoration(
                labelText: 'Search',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Inbox',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                ...filteredInboxEmails.map((email) => EmailListTile(email: email)).toList(),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Sent',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                ...filteredSentEmails.map((email) => EmailListTile(email: email)).toList(),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ComposeEmailPage(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class EmailListTile extends StatelessWidget {
  final Map<String, String> email;

  EmailListTile({required this.email});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: ListTile(
          leading: const Icon(Icons.email),
          title: Text(email['subject']!),
          subtitle: Text(
            email['content']!,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          trailing: IconButton(
            icon: const Icon(Icons.arrow_forward),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EmailViewPage(
                    emailSubject: email['subject']!,
                    emailContent: email['content']!,
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class ComposeEmailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Compose Email'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(
                labelText: 'To',
              ),
            ),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Subject',
              ),
            ),
            Expanded(
              child: TextField(
                decoration: const InputDecoration(
                  labelText: 'Content',
                ),
                maxLines: null,
                expands: true,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // Add action to send email
              },
              child: const Text('Send'),
            ),
          ],
        ),
      ),
    );
  }
}

class DraftsPage extends StatelessWidget {
  final List<Map<String, String>> drafts = [
    {'subject': 'Draft 1', 'content': 'This is a draft email content.'},
    {'subject': 'Draft 2', 'content': 'Another draft email content.'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Drafts'),
      ),
      body: ListView.builder(
        itemCount: drafts.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: ListTile(
                leading: const Icon(Icons.drafts),
                title: Text(drafts[index]['subject']!),
                subtitle: Text(
                  drafts[index]['content']!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    // Add action to edit draft
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
