import 'dart:convert';

class Account {
  final int? id;
  final String issuer;
  final String secretKey;

  Account({
    this.id,
    required this.issuer,
    required this.secretKey,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'issuer': issuer,
      'secretKey': secretKey,
    };
  }

  factory Account.fromMap(Map<String, dynamic> map) {
    return Account(
      id: map['id']?.toInt() ?? 0,
      issuer: map['issuer'] ?? '',
      secretKey: map['secretKey'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'Account(id: $id, issuer: $issuer, secretKey: $secretKey)';
  }
}
