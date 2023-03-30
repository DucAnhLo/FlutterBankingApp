import 'package:techcombank_clone/models/user.dart';

class TransactionLink {
  final UserData transactionToId;
  final UserData transactionFromId;
  final DateTime dateTime;

  TransactionLink({
    required this.transactionToId,
    required this.transactionFromId,
    required this.dateTime
  });

}