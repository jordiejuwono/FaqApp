import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'failure_response.dart';

abstract class UseCase<T, Params> {
  const UseCase();

  Future<Either<FailureResponse, T>> execute(Params params);
}

class NoParam extends Equatable {
  const NoParam();
  @override
  List<Object?> get props => [];
}
