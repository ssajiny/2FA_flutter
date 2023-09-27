import 'package:flutter/material.dart';
import 'package:otp_flutter/common_widgets/account_builder.dart';
import 'package:otp_flutter/models/account.dart';
import 'package:otp_flutter/services/database_service.dart';

// class ListScreen extends StatefulWidget {
//   const ListScreen({super.key});

//   @override
//   State<ListScreen> createState() => _ListScreenState();
// }

// class _ListScreenState extends State<ListScreen> {
//   final DatabaseService _databaseService = DatabaseService();

//   Future<List<Account>> _getAccount() async {
//     return await _databaseService.account();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(body: AccountBuilder(future: _getAccount()));
//   }
// }
