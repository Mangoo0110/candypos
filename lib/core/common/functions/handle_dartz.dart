import 'package:dartz/dartz.dart';

import '../../api_handler/failure.dart';
import '../../utils/func/dekhao.dart';

T? handleDartz<T>({required Either<DataCRUDFailure, T> dataResult,}) {
  return dataResult.fold((l) {
        dekhao("Error: $l");
        return null;
      }, (r) {
        return r;
      });
}