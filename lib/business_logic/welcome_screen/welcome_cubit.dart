import 'package:bloc/bloc.dart';
import 'package:dghome3d/data/data_provider.dart';
import 'package:dghome3d/data/firebase_helper.dart';
import 'package:dghome3d/data/model/app_user.dart';
import 'package:dghome3d/data/submission_status.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

part 'welcome_state.dart';

class WelcomeCubit extends Cubit<WelcomeState> {
  DataProvider dataProvider;
  WelcomeCubit(this.dataProvider) : super(const WelcomeState());

  Future checkLoggedIn() async {
    await Future.delayed(const Duration(milliseconds: 500));
    emit(state.copyWith(status: const Submitting()));
    await Future.delayed(const Duration(milliseconds: 1000));
    AppUser? appUser = await dataProvider.getUser();
    if(appUser != null) {
      emit(state.copyWith(isLoggedIn: true, status: const SubmissionSuccess()));
    } else {
      emit(state.copyWith(status: const SubmissionSuccess()));
    }
  }

  loginWithGoogle() async {
    await FirebaseHelper.signInWithGoogle().then((value) async {
      await _loginSuccess(value);
    });
  }

  loginWithFacebook() async {
    await FirebaseHelper.signInWithFacebook().then((value) async {
      await _loginSuccess(value);
    }).onError((error, stackTrace) async {
      addError(error!, stackTrace);
    });
  }

  Future<void> _loginSuccess(UserCredential userCredential) async {
    if (userCredential.user != null) {
      AppUser appUser = AppUser.fromFirebase(userCredential.user!);
      if (appUser.email == null) {
        String newEmail = userCredential.additionalUserInfo?.profile?['email'] ?? "";
        appUser = appUser.copyWith(email: newEmail);
      }
      await dataProvider.saveLoginUser(appUser);
      emit(state.copyWith(isLoggedIn: true, status: SubmissionSuccess()));
    }
  }

  @override
  void onChange(Change<WelcomeState> change) {
    super.onChange(change);
    print(change);
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    super.onError(error, stackTrace);
    if (kDebugMode) {
      print(error);
    }
    emit(state.copyWith(errorText: error.toString()));
  }
}
