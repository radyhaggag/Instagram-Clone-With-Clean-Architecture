import 'package:dartz/dartz.dart';

import '../../error/failure.dart';

abstract class BaseUseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

abstract class StreamUseCase<Type, Params> {
  Either<Failure, Stream<Type>> call(Params params);
}

class NoParams {
  NoParams._internal();
  static final NoParams _instance = NoParams._internal();
  factory NoParams() => _instance;
}
