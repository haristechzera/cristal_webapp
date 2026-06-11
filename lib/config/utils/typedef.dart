

import 'package:dartz/dartz.dart';

import '../errors/failure.dart';



typedef ResultStream<T> = Stream<Either<Failure, T>>;

typedef ResultVoid = ResultFuture<void>;

typedef ResultInt = ResultFuture<int>;

typedef DataMap = Map<String, dynamic>;
// ✅ correct
typedef ResultFuture<T> = Future<Either<Failure, T>>;