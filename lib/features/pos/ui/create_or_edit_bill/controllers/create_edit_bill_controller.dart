// import 'package:easypos/features/billing/data/models/customer_record_model.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';

// import '../../../core/failure.dart';
// import '../../../features/billing/data/datasources/firebase/firebase_billing_datasource.dart';
// import '../../../features/billing/data/models/enums_of_models.dart';
// import '../../../features/billing/data/models/bill_model.dart';
// import '../../../features/billing/data/models/sale_item_model.dart';
// import '../../../features/billing/data/models/payment_model.dart';
// import '../../../models/uploading_meta_data_model.dart';
// import '../../../core/utils/dekhao.dart';

// class CreateEditBillController extends ChangeNotifier {

//   late BillModel _currentBill;
//   String _storeId;
//   String _userId;

//   late FirebaseBillingRepoImpl _firebaseBillingRepoImpl;

//   CreateEditBillController({
//     required BillModel? bill,
//     required String storeId,
//     required String userId
//   }): 
//     _storeId = storeId,
//     _userId = userId {

//       if(bill == null){
//         _currentBill = _newBill();
//       } else{
//         _currentBill = bill;
//       }

//     _firebaseBillingRepoImpl = FirebaseBillingRepoImpl(storeId: _storeId, userId: _userId);
//   }

//   BillType get billType => _currentBill.billType;

//   @override
//   void dispose() {
//     super.dispose();
//   }

//   void changeCurrentBillType({required BillType billType}) {
//     _currentBill.changeCurrentBillType(billType: billType);
//     notifyListeners();
//   }

//   _newBill(){
//     final bill = BillModel(
//       billId: _firebaseBillingRepoImpl.newBillId(),
//       localBillNo: '',
//       billType: BillType.walkIn, 
//       billerName: 'Owner', 
//       billerId: '', 
//       customerRecord: null, 
//       saleItemList: [], 
//       subTotal: 0,
//       idMappedTax: {},
//       grandTotal: 0, 
//       customerPaidAmount: 0, 
//       dueAmount: 0, 
//       billedAt: DateTime.now(), 
//       deliveryCharge: 0, 
//       deliveryInfo: null,
//       paymentList: [], 
//       saleDiscount: null, 
//       billingStatus: BillingStatus.onHold,
//       uploadMetaDetails: UploadMetaDetails.newInstance());
    
//     _currentBill = bill;
//     notifyListeners();
//     return bill;
//   }

//   void changeCustomer({required CustomerRecordModel customerRecord}) {
//     _currentBill.changeCustomer(customerRecord: customerRecord);
//   }

//   void removeCustomer() => _currentBill.removeCustomer();

//   void addItemToCurrentBill({required SaleItem billedItem}) {

//     int index = _currentBill.saleItemList.indexWhere((element) => (element.itemId == billedItem.itemId && element.price == billedItem.price && element.itemName == billedItem.itemName));
//     if(index >= 0) {
//       dekhao("incrementing existing item to current bill");
//       dekhao(_currentBill.saleItemList[index].toMap());
//       _currentBill.incementItemQuantityItemAt(incrementBy: billedItem.quantity, index: index);
//     } else {
//       dekhao("adding new item to current bill");
//       _currentBill.addNewItem(billedItem);
//     }
//     dekhao(_currentBill.toMap());
//     notifyListeners();
//   }

//   removeAllItemsOfCurrentBill() {
//     _currentBill.removeAllItems();
//     notifyListeners();
//   }

//   void addPayment({required PaymentModel paymentModel}) {
//     _currentBill.addPayment(paymentModel: paymentModel);
//   }
  
//   Future<bool> confirmCheckout() async{
    
//     _currentBill.changeBillingStatus(billingStatus: BillingStatus.processed);

//     return await uploadBill().then((value) {
//       if(value) {
//         _newBill();
//         return true;
//       } else {
//         Fluttertoast.showToast(msg: 'Checkout failed!');
//         return false;
//       }
//     });
    
//   }

//   Future<bool> holdBilledCheck() async{

//     _currentBill.changeBillingStatus(billingStatus: BillingStatus.onHold);

//     return await uploadBill().then((value) {
//       if(value) {
//         _newBill();
//         return true;
//       } else {
//         Fluttertoast.showToast(msg: 'Check hold failed!');
//         return false;
//       }
//     });

//   }

//   Future<bool> uploadBill() async{

//     return await _firebaseBillingRepoImpl.uploadBill(bill: _currentBill,).then((dataResult) {
//       return dataResult.fold(
//         (dataFailure) {
//           errorToast(dataFailure: dataFailure);
//           return false;
//         }, 
//         (dataStream) {
//           Fluttertoast.showToast(msg: 'Bill is saved.');
//           return true;
//         }
//       );
//     });
//   }

//   void errorToast({required DataCRUDFailure dataFailure}) {
//     if(dataFailure.failure == Failure.socketFailure) {
//       Fluttertoast.showToast(msg: "Failed! You are offline. Check your internet connection");
//     }
//     if(dataFailure.failure == Failure.severFailure) {
//       Fluttertoast.showToast(msg: "Failure: Server failed.");
//     } else {
//       Fluttertoast.showToast(msg: dataFailure.message);
//     }
//   }
// }