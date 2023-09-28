import 'package:flutter/material.dart';
import 'package:otp_flutter/models/account.dart';
import 'package:otp_flutter/services/database_service.dart';

class AccountBuilder extends StatelessWidget {
  const AccountBuilder({
    Key? key,
    required this.future,
    required this.onEdit,
    required this.onDelete,
  }) : super(key: key);

  final Future<List<Account>> future;
  final Function(Account) onEdit;
  final Function(Account) onDelete;

  Future<String> getSiteName(int id) async {
    final DatabaseService _databaseService = DatabaseService();
    final site = await _databaseService.site(id);
    return site.name;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Account>>(
      future: future,
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
              height: 40.0,
              width: 40.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey[200],
              ),
              alignment: Alignment.center,
              // child: FaIcon(FontAwesomeIcons.dog, size: 18.0),
            ),
            const SizedBox(width: 20.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    account.secretKey,
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  FutureBuilder<String>(
                    future: getSiteName(account.siteId),
                    builder: (context, snapshot) {
                      return Text('Site: ${snapshot.data}');
                    },
                  ),
                  const SizedBox(height: 4.0),
                  Row(
                    children: [
                      Container(
                        height: 15.0,
                        width: 15.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.0),
                          color: account.color,
                          border: Border.all(
                            color: Colors.black,
                            width: 1.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 20.0),
            GestureDetector(
              onTap: () => onEdit(account),
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
              onTap: () => onDelete(account),
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
