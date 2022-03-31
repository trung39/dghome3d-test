import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dghome3d/data/data_provider.dart';
import 'package:dghome3d/data/model/app_user.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

part 'inside_state.dart';

class InsideCubit extends Cubit<InsideState> {
  DataProvider dataProvider;
  InsideCubit(this.dataProvider) : super(const InsideState());


  void getData() async {
    AppUser? appUser = await dataProvider.getUser();
    if (appUser == null) {
      emit(state.copyWith(errorText: "There was an error, please login again"));
    } else {
      emit(state.copyWith(appUser: appUser));
    }
  }

  void signOut({String? message}) {
    FirebaseAuth.instance.signOut();
    dataProvider.removeUser();
    emit(state.copyWith(signedOut: true, errorText: message));
  }

  Timer? timer;
  int get expireTime {
    if (state.appUser == null || state.appUser!.expirationTime == null) {
      return -1;
    }
    return state.appUser!.expirationTime!;
  }

  setupSignOutTimer() {
    if (timer != null) {
      timer!.cancel();
    }
    // expireTime == -1: user has not been initiate
    if (expireTime == -1) {
      return;
    }
    String message = "Your login session has expired, please login again";
    int millisToSignOut = expireTime - DateTime.now().millisecondsSinceEpoch;
    print('Time remain: ${DateTime.fromMillisecondsSinceEpoch(millisToSignOut)}');
    if (millisToSignOut < 0) {
      signOut(message: message);
    } else {
      timer = Timer(Duration(milliseconds: millisToSignOut), () {
        signOut(message: message);
      });
    }
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    super.onError(error, stackTrace);
    if (kDebugMode) {
      print(error);
    }
  }
  @override
  void onChange(Change<InsideState> change) {
    super.onChange(change);
    print(change);
  }
}
