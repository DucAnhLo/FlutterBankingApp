
import 'dart:convert';


class UserData {
  final String? uid;
  final String? name;
  final String? accountNumber;
  int? balance;

  UserData({this.uid, this.name,this.accountNumber, this.balance});

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

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'accountNumber': accountNumber,
      'balance': balance,
    };
  }

  // Override the == operator
    @override
    bool operator ==(other) {
      return other is UserData &&
          other.uid == uid &&
          other.name == name &&
          other.accountNumber == accountNumber &&
          other.balance == balance;
    }

    // Override the hashCode function
    @override
    int get hashCode =>
        uid.hashCode ^ name.hashCode ^ accountNumber.hashCode ^ balance.hashCode;
  }
