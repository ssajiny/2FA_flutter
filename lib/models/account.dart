import 'dart:convert';
import 'package:flutter/widgets.dart';

class Account {
  final int? id;
  final int? siteId;
  final Color color;
  final String secretKey;

  Account({
    this.id,
    this.siteId,
    required this.color,
    required this.secretKey,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'siteId': siteId,
      'color': color.value,
      'secretKey': secretKey,
    };
  }

  factory Account.fromMap(Map<String, dynamic> map) {
    return Account(
      id: map['id']?.toInt() ?? 0,
      siteId: map['siteId'].toInt() ?? 0,
      color: Color(map['color']),
      secretKey: map['secretKey'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Account.fromJson(String source) =>
      Account.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Account(id: $id, siteId: $siteId, color: $color, secretKey: $secretKey)';
  }
}
