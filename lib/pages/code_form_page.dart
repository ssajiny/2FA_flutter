import 'package:flutter/material.dart';
import 'package:otp_flutter/common_widgets/color_picker.dart';
import 'package:otp_flutter/common_widgets/site_selector.dart';
import 'package:otp_flutter/models/account.dart';
import 'package:otp_flutter/models/site.dart';
import 'package:otp_flutter/services/database_service.dart';

class CodeFormPage extends StatefulWidget {
  const CodeFormPage({super.key, this.account});
  final Account? account;

  @override
  State<CodeFormPage> createState() => _CodeFormPageState();
}

class _CodeFormPageState extends State<CodeFormPage> {
  final TextEditingController _secretController = TextEditingController();
  static final List<Color> _colors = [
    Color(Colors.black.value),
    Color(Colors.blue.value),
    Color(Colors.green.value),
    Color(Colors.orange.value),
    Color(Colors.red.value),
    Color(Colors.yellow.value),
  ];
  static final List<Site> _sites = [];

  final DatabaseService _databaseService = DatabaseService();

  int _selectedColor = 0;
  int _selectedSite = 0;

  @override
  void initState() {
    super.initState();
    if (widget.account != null) {
      _secretController.text = widget.account!.secretKey;
      _selectedColor = _colors.indexOf(widget.account!.color);
      if (widget.account != null) {
        _selectedSite =
            _sites.indexWhere((e) => e.id == widget.account!.siteId);
      }
    }
  }

  Future<List<Site>> _getSites() async {
    final sites = await _databaseService.sites();
    _sites.clear();
    _sites.addAll(sites);
    return _sites;
  }

  Future<void> _onSave() async {
    final secret = _secretController.text;
    final color = _colors[_selectedColor];
    final site = _sites[_selectedSite];

    widget.account == null
        ? await _databaseService.insertAccount(
            Account(secretKey: secret, color: color, siteId: site.id),
          )
        : await _databaseService.updateAccount(
            Account(
              id: widget.account!.id,
              secretKey: secret,
              color: color,
              siteId: site.id,
            ),
          );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('New Code Record'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: _secretController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter the Secret Code',
                ),
              ),
              const SizedBox(height: 16.0),
              ColorPicker(
                colors: _colors,
                selectedIndex: _selectedColor,
                onChanged: (value) {
                  setState(() {
                    _selectedColor = value;
                  });
                },
              ),
              const SizedBox(height: 24.0),
              FutureBuilder<List<Site>>(
                future: _getSites(),
                builder: (context, snapshot) {
                  return SiteSelector(
                    sites: _sites.map((e) {
                      return e.name;
                    }).toList(),
                    selectedIndex: _selectedSite,
                    onChanged: (value) {
                      setState(() {
                        _selectedSite = value;
                      });
                    },
                  );
                },
              ),
              const SizedBox(height: 24.0),
              SizedBox(
                height: 45.0,
                child: ElevatedButton(
                  onPressed: _onSave,
                  child: const Text(
                    'Save the Account data',
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
