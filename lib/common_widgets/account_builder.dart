import 'dart:async';

import 'package:flutter/material.dart';
import 'package:otp_flutter/models/account.dart';
import 'package:otp_flutter/services/database_service.dart';

class AccountBuilder extends StatefulWidget {
  const AccountBuilder({
    Key? key,
    required this.future,
    required this.onEdit,
    required this.onDelete,
  }) : super(key: key);

  final Future<List<Account>> future;
  final Function(Account) onEdit;
  final Function(Account) onDelete;

  @override
  State<AccountBuilder> createState() => _AccountBuilderState();
}

class _AccountBuilderState extends State<AccountBuilder> {
  int seconds = 0;
  late Timer _timer;

  Future<String> getSiteName(int id) async {
    final DatabaseService databaseService = DatabaseService();
    final site = await databaseService.site(id);
    return site.name;
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        int _seconds = DateTime.now().second;
        seconds = 30 - ((_seconds + 10) % 30);
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Account>>(
      future: widget.future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (BuildContext context, int index) {
                final account = snapshot.data![index];
                return _buildAccountCard(account, context);
              },
            ));
      },
    );
  }

  Widget _buildAccountCard(Account account, BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            Container(
              height: 80.0,
              width: 40.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey[200],
              ),
              alignment: Alignment.center,
              child: Text('$seconds'),
            ),
            const SizedBox(width: 20.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    account.secretKey,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500,
                      color: account.color,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  FutureBuilder<String>(
                    future: getSiteName(account.siteId ?? 0),
                    builder: (context, snapshot) {
                      return Text('Site: ${snapshot.data}');
                    },
                  ),
                  const SizedBox(height: 4.0),
                ],
              ),
            ),
            const SizedBox(width: 20.0),
            GestureDetector(
              onTap: () => widget.onEdit(account),
              child: Container(
                height: 40.0,
                width: 40.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey[200],
                ),
                alignment: Alignment.center,
                child: Icon(Icons.edit, color: Colors.orange[800]),
              ),
            ),
            const SizedBox(width: 20.0),
            GestureDetector(
              onTap: () {
                // onDelete(account);
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Confirmation'),
                      content: const Text(
                          'Are you sure you want to delete this item?'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            widget.onDelete(account);
                            Navigator.of(context).pop();
                          },
                          child: const Text('Yes'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('No'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: Container(
                height: 40.0,
                width: 40.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey[200],
                ),
                alignment: Alignment.center,
                child: Icon(Icons.delete, color: Colors.red[800]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
