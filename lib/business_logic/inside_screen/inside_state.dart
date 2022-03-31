part of 'inside_cubit.dart';

class InsideState extends Equatable {
  const InsideState({this.errorText, this.appUser, this.signedOut = false});
  @override
  List<Object?> get props => [
    errorText, appUser, signedOut
  ];
  final AppUser? appUser;
  final String? errorText;
  final bool signedOut;

  InsideState copyWith({
    AppUser? appUser,
    String? errorText,
    bool? signedOut,
  }) {
    return InsideState(
      appUser: appUser ?? this.appUser,
      errorText: errorText ?? "",
      signedOut: signedOut ?? false,
    );
  }
}
