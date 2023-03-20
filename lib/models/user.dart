// class MyUser {
//   final String? uid;

//   MyUser({this.uid});

// }


class UserData {
  final String? uid;
  final String? name;
  final String? accountNumber;
  int? balance;

  UserData({this.uid, this.name, this.accountNumber, this.balance});

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        uid: json['uid'],
        name: json['name'],
        accountNumber: json['accountNumber'],
        balance: json['balance'],
      );

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'name': name,
        'accountNumber': accountNumber,
        'balance': balance,
      };
}
