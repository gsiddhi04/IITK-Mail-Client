import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'list.dart';


void main() {
  // WidgetFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Email Login Page',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: EmailLoginPage(),
    );
  }
}

class EmailLoginPage extends StatelessWidget {
   EmailLoginPage({super.key});
  final TextEditingController email=TextEditingController();
  final TextEditingController password=TextEditingController();

//   @override
//   _EmailLoginPageState createState()=> _EmailLoginPageState
// }

// class _EmailLoginPageState extends State<EmailLoginPage>{
//   final TextEditingController _emailcontroller = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();

//   Future<void> _login() async{
//     try{
//       final UserCredentials userCredential = await FirebaseAuth.instance,signInWithEmailAndPassword(
//         Email: _emailcontroller.text,
//         Password: _passwordController.text,
//       );
//       Navigator.push(
//         context,
//         MaterialPageRoute(builder: (context) => EmailListPage()),
//       );
//     } on FirebaseAuthException catch(e){
//       if (e.code == 'user-not-found'){
//         _showErrorDialog('Invalid email. Try Again!');
//       }else if (e.code=='wrong-password'){
//         _showErrorDialog('Wrong credentials.')
//       }
//     }
//   }

//   void _showErrorDialog(String message){
//     showDialog(
//       context: context,
//       builder: (buildContext context){
//         return AlertDialog(
//           title: Text('Error'),
//           content: Text(message),
//           actions: <Widget>[
//             TextButton(
//               child: Text('OK'),
//               onPressed: (){
//                 Navigator.of(context).pop();
//               }
//             )
//           ]
//         )
//       }
//     )
//   }
// }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Email Login'),
      ),
      backgroundColor: Colors.pink[50],
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage('https://www.iitk.ac.in/new/images/page-images/logo/bluelog.jpg'),
                backgroundColor: Colors.transparent,
              ),
              const SizedBox(height:20),
              const TextField(
                decoration: InputDecoration(
                  labelText: 'Email',
                  labelStyle: TextStyle(
                    fontFamily: '', 
                    fontSize: 16.0,
                    color: Colors.blue,
                  ),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              const TextField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                   Navigator.push(
                     context,
                     MaterialPageRoute(builder: (context) => EmailListPage(email: email.text,password: password.text)),
                  );
                },
                child: const Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
