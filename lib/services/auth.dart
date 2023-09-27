import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:logger/logger.dart';
import 'package:otp_flutter/screens/home_screen.dart';
import 'package:otp_flutter/services/database_service.dart';

final logger = Logger();

// class AuthCheck extends StatefulWidget {
//   const AuthCheck({super.key});

//   @override
//   State<AuthCheck> createState() => _AuthCheckState();
// }

// class _AuthCheckState extends State<AuthCheck> {
//   final DatabaseService _databaseService = DatabaseService();
//   final LocalAuthentication auth = LocalAuthentication();

//   @override
//   void initState() {
//     super.initState();
//   }

//   Future<void> _authenticate() async {
//     bool authenticated = false;
//     try {
//       authenticated = await auth.authenticate(
//         localizedReason: 'Let OS determine authentication method',
//         options: const AuthenticationOptions(
//           stickyAuth: true,
//         ),
//       );
//     } on PlatformException catch (e) {
//       logger.d('Error log: ', error: e);
//       return;
//     }

//     if (!mounted) {
//       return;
//     }

//     if (authenticated) {
//       runApp(const MaterialApp(
//         home: HomeScreen(),
//       ));
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         body: ListView(
//           padding: const EdgeInsets.only(top: 200.0),
//           children: <Widget>[
//             Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 Column(
//                   children: <Widget>[
//                     ElevatedButton(
//                       onPressed: _authenticate,
//                       style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors.indigoAccent),
//                       child: const Row(
//                         mainAxisSize: MainAxisSize.min,
//                         children: <Widget>[
//                           Text('Log In', style: TextStyle(fontSize: 25.0))
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
