import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppUser {
  String? uid;
  String? name;
  String? phoneNumber;
  String? email;
  int? expirationTime;

  String get expirationDateTime {
    if (expirationTime == null) {
      return "";
    }
    return DateTime.fromMillisecondsSinceEpoch(expirationTime ?? 0).toString();
  }

  AppUser(
      {this.uid, this.name, this.phoneNumber, this.email, this.expirationTime});

  AppUser.fromFirebase(User user) {
    uid = user.uid;
    name = user.displayName;
    phoneNumber = user.phoneNumber;
    email = user.email;
    expirationTime = _getExpirationTime();
  }

  AppUser.fromJson(dynamic json) {
    uid = json['uid'];
    name = json['name'];
    phoneNumber = json['phone_number'];
    email = json['email'];
    expirationTime = json['expiration_time'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['uid'] = uid;
    map['name'] = name;
    map['phone_number'] = phoneNumber;
    map['email'] = email;
    map['expiration_time'] = expirationTime;
    return map;
  }

  int _getExpirationTime() {
    int currentTimeStamp = DateTime.now().millisecondsSinceEpoch;
    int expireIn = 2 * 60 * 1000; // 5 minutes
    return currentTimeStamp + expireIn;
  }

  AppUser copyWith({
    String? uid,
    String? name,
    String? phoneNumber,
    String? email,
    int? expirationTime,
  }) {
    return AppUser(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email ?? this.email,
      expirationTime: expirationTime ?? this.expirationTime,
    );
  }
}