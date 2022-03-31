part of 'welcome_cubit.dart';

class WelcomeState extends Equatable {
  const WelcomeState({this.isLoggedIn = false, this.status = const InitialStatus(), this.errorText = ""});
  @override
  List<Object> get props => [
    isLoggedIn, status.toString()
  ];
  final bool isLoggedIn;
  final SubmissionStatus status;
  final String errorText;

  WelcomeState copyWith({
    bool? isLoggedIn,
    SubmissionStatus? status,
    String? errorText,
  }) {
    return WelcomeState(
      isLoggedIn: isLoggedIn ?? false,
      status: status ?? const InitialStatus(),
      errorText: errorText ?? "",
    );
  }
}
