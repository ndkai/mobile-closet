import 'entities/pageable.dart';
import 'package:result_dart/result_dart.dart';

typedef LoadCallback<T> = Future<Result<Pageable<T>, Exception>> Function(
  int page,
  int limit,
);
