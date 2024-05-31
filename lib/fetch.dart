import 'package:flutter/material.dart';
import 'package:login_page/view.dart';
import 'list.dart';
import 'package:enough_mail/enough_mail.dart';
import 'send.dart';


class MailListPage extends StatefulWidget {
  final String name;
  final String message;
  final DateTime date;
  MailListPage({required this.name,required this.message, required this.date});
  @override
  _MailListPageState createState() => _MailListPageState();
}

class _MailListPageState extends State<MailListPage> {
   _MailListPageState();
  final TextEditingController email=TextEditingController();
  final TextEditingController password=TextEditingController();
  List<MimeMessage> emails = [];

  @override
  void initState() {
    super.initState();
    fetchEmails();
  }

  Future<void> fetchEmails() async {
    final fetchedEmails = await imapExample(
      imapServerHost: 'qasid.iitk.ac.in', // Replace with your IMAP server host
      imapServerPort: 993, // IMAP over SSL/TLS
      isImapServerSecure: true,
      userName: 'siddhig23@iitk.ac.in', // Replace with your email
      password: '03183019@SMRSjiya', // Replace with your password
    );

    setState(() {
      emails = fetchedEmails.reversed.toList(); // Reverse the list here
    });
  }

  Future<List<MimeMessage>> imapExample({
    required String imapServerHost,
    required int imapServerPort,
    required bool isImapServerSecure,
    required String userName,
    required String password,
  }) async {
    final client = ImapClient(isLogEnabled: false);
    List<MimeMessage> fetchedMessages = [];
    try {
      await client.connectToServer(imapServerHost, imapServerPort,
          isSecure: isImapServerSecure);
      await client.login(userName, password);
      await client.selectInbox();
      final fetchResult = await client.fetchRecentMessages(
        messageCount: 25,
        criteria: 'BODY.PEEK[]',
      );
      fetchedMessages = fetchResult.messages;

      await client.logout();
    } on ImapException catch (e) {
      print('IMAP failed with $e');
    }
    return fetchedMessages;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ComposeEmailPage(email: email.text ,password:password.text)), // Navigate to ComposePage
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Color.fromARGB(255, 20, 3, 170),
      ),
      appBar: AppBar(
        title: Text('Mail List'),
      ),
      body: ListView.builder(
        itemCount: emails.length,
        itemBuilder: (context, index) {
          final email = emails[index];
          final from = email.from?.first;
          final name = from?.personalName ?? from?.email ?? 'Unknown';
          final subject = email.decodeSubject() ?? 'No Subject';
          final message = email.decodeTextPlainPart() ?? 'No Message';
          final date =
              email.decodeDate() ?? DateTime.now(); // Get the real date

          return MailItem(
            name: name,
            email: from?.email ?? 'unknown@example.com',
            matter: subject,
            message: message,
            date: date, // Pass the date to MailItem
          );
        },
      ),
    );
  }
}

class MailItem extends StatefulWidget {
  final String name;
  final String email;
  final String matter;
  final String message;
  final DateTime date; // Add date field

  const MailItem({
    Key? key,
    required this.name,
    required this.email,
    required this.matter,
    required this.message,
    required this.date, // Initialize date
  }) : super(key: key);

  @override
  _MailItemState createState() => _MailItemState();
}

class _MailItemState extends State<MailItem> {
  bool isStarred = false;


  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.secondary,
      child: Card(
        color: Theme.of(context).colorScheme.primaryContainer,
        child: ListTile(
          leading: CircleAvatar(
            child: Text(
              widget.name[0], // Get the first character of the name
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.blue, // Background color for the avatar
          ),
          title: Row(
            children: [
              Expanded(
                child: Text(widget.email),
              ),
              IconButton(
                icon: Icon(
                  isStarred ? Icons.star : Icons.star_border,
                  color: isStarred
                      ? Colors.blue
                      : null, // Set color to blue if starred
                ),
                onPressed: () {
                  setState(() {
                    isStarred = !isStarred; // Toggle star status
                  });
                  // Handle like message
                },
              ),
            ],
          ),
          subtitle: Text(
              widget.matter), // Adding the corresponding matter as subtitle
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MailListPage(
                  name: widget.name,
                  message: widget.message,
                  date: widget.date, // Pass the date to MailViewPage
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}