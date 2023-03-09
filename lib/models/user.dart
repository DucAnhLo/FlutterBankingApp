// class MyUser {
//   final String? uid;

//   MyUser({this.uid});

// }


class UserData {
  final String? uid;
  final String? name;
  final String? accountNumber;
  final int? balance;

  UserData({this.uid, this.name, this.accountNumber, this.balance});

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'accountNumber': accountNumber,
      'balance': balance
    };
  }

}
