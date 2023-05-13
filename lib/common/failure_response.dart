import 'package:equatable/equatable.dart';

abstract class FailureResponse extends Equatable {
  final String errorMessage;

  const FailureResponse(
    this.errorMessage,
  );

  @override
  List<Object?> get props => [
        errorMessage,
      ];
}

class ServerFailure extends FailureResponse {
  const ServerFailure(String message) : super(message);
}
