import 'package:fluttertoast/fluttertoast.dart';

import '../../api_handler/failure.dart';


void failureToast(DataCRUDFailure dataFailure){
  if(dataFailure.failure == Failure.socketFailure) {
    Fluttertoast.showToast(msg: "You are offline. Check your internet connection");
  }
  if(dataFailure.failure == Failure.noData) {
    Fluttertoast.showToast(msg: "Doesn't exist!");
  }
  if(dataFailure.failure == Failure.severFailure) {
    Fluttertoast.showToast(msg: "Failure: Server failed.");
  } else {
    Fluttertoast.showToast(msg: dataFailure.message);
  }
}