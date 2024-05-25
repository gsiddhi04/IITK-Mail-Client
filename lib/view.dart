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
        backgroundColor: Colors.teal,
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
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Colors.tealAccent],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Search',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
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
        backgroundColor: Colors.teal,
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
        color: Colors.white.withOpacity(0.9),
        child: ListTile(
          leading: const Icon(Icons.email, color: Colors.teal),
          title: Text(email['subject']!),
          subtitle: Text(
            email['content']!,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          trailing: IconButton(
            icon: const Icon(Icons.arrow_forward, color: Colors.teal),
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
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(
                labelText: 'To',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Subject',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: TextField(
                decoration: const InputDecoration(
                  labelText: 'Content',
                  border: OutlineInputBorder(),
                ),
                maxLines: null,
                expands: true,
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
              ),
              onPressed: () {
                
              },
              child: const Text('Send'),
            ),
          ],
        ),
      ),
    );
  }
}

// Page to display draft emails
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
        backgroundColor: Colors.teal,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Colors.tealAccent],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: ListView.builder(
          itemCount: drafts.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                color: Colors.white.withOpacity(0.9),
                child: ListTile(
                  leading: const Icon(Icons.drafts, color: Colors.teal),
                  title: Text(drafts[index]['subject']!),
                  subtitle: Text(
                    drafts[index]['content']!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.edit, color: Colors.teal),
                    onPressed: () {
                      // Add action to edit draft
                    },
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    theme: ThemeData(
      primaryColor: Colors.teal,
      hintColor: Colors.tealAccent,
    ),
    home: EmailListPage(),
  ));
}
