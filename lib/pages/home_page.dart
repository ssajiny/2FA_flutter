import 'package:flutter/material.dart';
import 'package:otp_flutter/common_widgets/account_builder.dart';
import 'package:otp_flutter/common_widgets/site_builder.dart';
import 'package:otp_flutter/models/account.dart';
import 'package:otp_flutter/models/site.dart';
import 'package:otp_flutter/pages/code_form_page.dart';
import 'package:otp_flutter/pages/qr_form_page.dart';
import 'package:otp_flutter/pages/site_form_page.dart';
import 'package:otp_flutter/services/database_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final DatabaseService _databaseService = DatabaseService();

  Future<List<Account>> _getAccounts() async {
    return await _databaseService.accounts();
  }

  Future<List<Site>> _getSites() async {
    return await _databaseService.sites();
  }

  Future<void> _onAccountDelete(Account account) async {
    await _databaseService.deleteAccount(account.id!);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('My Authenticator'),
          centerTitle: true,
          bottom: const TabBar(
            tabs: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: Text('Accounts'),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: Text('Sites'),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            AccountBuilder(
              future: _getAccounts(),
              onEdit: (value) {
                {
                  Navigator.of(context)
                      .push(
                        MaterialPageRoute(
                          builder: (_) => CodeFormPage(account: value),
                          fullscreenDialog: true,
                        ),
                      )
                      .then((_) => setState(() {}));
                }
              },
              onDelete: _onAccountDelete,
            ),
            SiteBuilder(
              future: _getSites(),
            ),
          ],
        ),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(
                        MaterialPageRoute(
                          builder: (_) => const CodeFormPage(),
                          fullscreenDialog: true,
                        ),
                      )
                      .then((_) => setState(() {}));
                },
                heroTag: 'addCode',
                child: const Icon(Icons.code_sharp)),
            const SizedBox(height: 12.0),
            FloatingActionButton(
              onPressed: () {
                Navigator.of(context)
                    .push(
                      MaterialPageRoute(
                        builder: (_) => const QRFormPage(),
                        fullscreenDialog: true,
                      ),
                    )
                    .then((_) => setState(() {}));
              },
              heroTag: 'addQR',
              child: const Icon(Icons.qr_code_2_sharp),
            ),
            const SizedBox(height: 12.0),
            FloatingActionButton(
              onPressed: () {
                Navigator.of(context)
                    .push(
                      MaterialPageRoute(
                        builder: (_) => const SiteFormPage(),
                        fullscreenDialog: true,
                      ),
                    )
                    .then((_) => setState(() {}));
              },
              heroTag: 'addSite',
              child: const Icon(Icons.domain_add_sharp),
            ),
          ],
        ),
      ),
    );
  }
}
