import 'package:flutter/scheduler.dart';

enum FormStatus {
  FillForm,
  Loading,
  Error,
  Success,
}

enum RoleType {
  Warehouse,
  Seller,
  Manager,
  Supplier,
}

enum RequestStatus {
  Unknown,
  Pending,
  Done,
  Cancel,
}

extension RequestExtension on RequestStatus {
  static RequestStatus getValue(int index) {
    switch (index) {
      case 1:
        return RequestStatus.Pending;
      case 2:
        return RequestStatus.Done;
      case 3:
        return RequestStatus.Cancel;
      default:
        return RequestStatus.Unknown;
    }
  }

  void talk() {
    print('meow');
  }
}
