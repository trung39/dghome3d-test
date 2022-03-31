import 'package:equatable/equatable.dart';

/// The status of actions.
/// Including initial, submitting, success and failed status
abstract class SubmissionStatus extends Equatable{
  final String message;
  const SubmissionStatus({String? message}) : message = message ?? "";

  @override
  List<Object> get props => [
    toString()
  ];
}

class InitialStatus extends SubmissionStatus {
  const InitialStatus({String? message}): super(message: message);

  @override
  String toString() {
    return 'InitialStatus{$message}';
  }

  @override
  List<Object> get props => [
    toString()
  ];
}

class Submitting extends SubmissionStatus {
  const Submitting({String? message}): super(message: message);

  @override
  String toString() {
    return 'Submitting{$message}';
  }

  @override
  List<Object> get props => [
    toString()
  ];
}

class SubmissionSuccess extends SubmissionStatus {
  const SubmissionSuccess({String? message}): super(message: message);
  @override
  String toString() {
    return 'SubmissionSuccess{$message}';
  }

  @override
  List<Object> get props => [
    toString()
  ];
}

class SubmissionFailed extends SubmissionStatus {
  const SubmissionFailed({String? message}): super(message: message);
  @override
  String toString() {
    return 'SubmissionFailed{$message}';
  }

  @override
  List<Object> get props => [
    toString()
  ];
}
