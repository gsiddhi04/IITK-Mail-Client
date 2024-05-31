import 'dart:io';
import 'package:enough_mail/enough_mail.dart';
import 'package:flutter/material.dart';

class ComposeEmailPage extends StatelessWidget {
  final String email;
  final String password;
  final TextEditingController emailcontroller=TextEditingController();
  final TextEditingController subjectcontroller=TextEditingController();
  final TextEditingController bodycontroller=TextEditingController();
  ComposeEmailPage({super.key, required this.email,required this.password});
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
              controller: emailcontroller,
              decoration: const InputDecoration(
                labelText: 'To',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: subjectcontroller,
              decoration: const InputDecoration(
                labelText: 'Subject',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: TextField(
                controller: bodycontroller,
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
                sendEmail(emailcontroller.text, subjectcontroller.text, bodycontroller.text, context,);
              },
              child: const Text('Send'),
            ),
          ],
        ),
      ),
    );
  }
  void sendEmail(String recipient, String subject, String body, BuildContext context,) async {
    String smtpServerHost = 'smtp.cc.iitk.ac.in';
    int smtpServerPort = 465;
    bool isSmtpServerSecure = true;
    

    final client = SmtpClient('enough.de', isLogEnabled: true);
    try {
      await client.connectToServer(smtpServerHost, smtpServerPort, isSecure: isSmtpServerSecure);
      await client.ehlo();
      
      if (client.serverInfo.supportsAuth(AuthMechanism.plain)) {
        await client.authenticate(email,password , AuthMechanism.plain);
      } else if (client.serverInfo.supportsAuth(AuthMechanism.login)) {
        await client.authenticate(email, password, AuthMechanism.login);
      } else {
        return;
      }
      final builder = MessageBuilder.prepareMultipartAlternativeMessage(
        plainText: body,
        htmlText: '<p>$body</p>',
      )
        ..from = [MailAddress('My name', email)]
        ..to = [MailAddress('Recipient', recipient)]
        ..subject = subject;
      final mimeMessage = builder.buildMimeMessage();
      final sendResponse = await client.sendMessage(mimeMessage);
      if (sendResponse.isOkStatus) {
        SnackBar(backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                content: const Text('Email Sent Successfully',
        ),);
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to send email.')),
        );
      }
    } on SmtpException catch (e) {
      print('SMTP failed with $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('SMTP failed: $e')),
      );
    } on SocketException catch (e) {
      print('Socket failed with $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Socket error: $e')),
      );
    } catch (e) {
      print('Unexpected error: ${e.toString()}');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Unexpected error: ${e.toString()}')),
      );
    }
  }


void printMessage(MimeMessage message) {
  print('from: ${message.from} with subject "${message.decodeSubject()}"');
  if (!message.isTextPlainMessage()) {
    print(' content-type: ${message.mediaType}');
  } else {
    final plainText = message.decodeTextPlainPart();
    if (plainText != null) {
      final lines = plainText.split('\r\n');
      for (final line in lines) {
        if (line.startsWith('>')) {
          // break when quoted text starts
          break;
        }
        print(line);
      }
    }
  }
}
}


