import 'package:techcombank_clone/models/user.dart';

class Transactions {
  final UserData user_id;
  final int type;
  final String title;
  final int amount;

  Transactions({
    required this.user_id,
    required this.type,
    required this.title,
    required this.amount,
  });
}
