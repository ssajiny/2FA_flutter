import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:otp_flutter/models/account.dart';
import 'package:otp_flutter/services/database_service.dart';

final logger = Logger();

// class AddScreen extends StatefulWidget {
//   const AddScreen({super.key});

//   @override
//   State<AddScreen> createState() => _AddScreenState();
// }

// class _AddScreenState extends State<AddScreen> {
//   final DatabaseService _databaseService = DatabaseService();
//   TextEditingController issuerController = TextEditingController();
//   TextEditingController passwordController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         FocusScope.of(context).unfocus();
//       },
//       child: Padding(
//         padding: const EdgeInsets.all(10),
//         child: ListView(
//           children: [
//             Container(
//                 alignment: Alignment.center,
//                 padding: const EdgeInsets.all(10),
//                 child: const Text(
//                   'Please Enter The Key',
//                   style: TextStyle(
//                       color: Colors.indigoAccent,
//                       fontWeight: FontWeight.w500,
//                       fontSize: 30.0),
//                 )),
//             Container(
//                 alignment: Alignment.center,
//                 padding: const EdgeInsets.all(15),
//                 child: const Icon(
//                   Icons.lock_outlined,
//                   size: 40,
//                   color: Colors.indigo,
//                 )),
//             Container(
//                 padding: const EdgeInsets.all(10),
//                 child: TextField(
//                   controller: issuerController,
//                   decoration: const InputDecoration(
//                     border: OutlineInputBorder(),
//                     labelText: 'Issuer',
//                   ),
//                 )),
//             Container(
//                 padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
//                 child: TextField(
//                   obscureText: true,
//                   controller: passwordController,
//                   decoration: const InputDecoration(
//                     border: OutlineInputBorder(),
//                     labelText: 'Password',
//                   ),
//                 )),
//             const SizedBox(
//               height: 20,
//             ),
//             Container(
//                 height: 50,
//                 padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
//                 child: ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.indigoAccent),
//                   child: const Text('Send'),
//                   onPressed: () async {
//                     await _databaseService.insertAccount(Account(
//                         issuer: issuerController.text,
//                         secretKey: passwordController.text));
//                     logger.d(
//                         'input name: ${issuerController.text}, input password:  ${passwordController.text}');
//                     FocusScope.of(context).requestFocus(FocusNode());
//                   },
//                 )),
//           ],
//         ),
//       ),
//     );
//   }
// }
