import 'package:techcombank_clone/models/user.dart';

class Transaction {
  final String id;
  final UserData user;
  final int type;
  final String title;
  final double amount;

  Transaction({
    required this.id,
    required this.user,
    required this.type,
    required this.title,
    required this.amount,
  });
}