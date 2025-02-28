enum Failure {socketFailure, authFailure, severFailure, firebaseFailure, unknownFailure, outOfMemoryError, noData, timeout}
class DataCRUDFailure {
  final Failure failure;
  final String message;

  DataCRUDFailure({required this.failure, required this.message});
}