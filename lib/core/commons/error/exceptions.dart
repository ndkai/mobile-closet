import 'package:equatable/equatable.dart';

class GenericException extends Equatable implements Exception {
  final String message;

  const GenericException({required this.message});

  @override
  List<Object?> get props => [message];
}

class UnhandledFailure extends GenericException {
  const UnhandledFailure({required super.message});
}

class ServerException implements Exception {}

class CacheException implements Exception {}
