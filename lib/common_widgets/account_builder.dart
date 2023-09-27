import 'package:flutter/material.dart';
import 'package:otp_flutter/models/account.dart';

class AccountBuilder extends StatelessWidget {
  const AccountBuilder({
    Key? key,
    required this.future,
  }) : super(key: key);

  final Future<List<Account>> future;

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
            child: ListView.separated(
              itemCount: snapshot.data!.length,
              itemBuilder: (BuildContext context, int index) {
                final item = snapshot.data![index];
                return ListTile(
                  title: Text(
                    item.issuer,
                    style: const TextStyle(color: Colors.black38),
                  ),
                  subtitle: Text(
                    item.secretKey,
                    style: const TextStyle(
                        color: Colors.indigoAccent, fontSize: 30),
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const Divider(
                  height: 30,
                );
              },
            ));
      },
    );
  }
}
