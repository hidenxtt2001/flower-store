import 'package:flower_store/src/models/base/staff.dart';

class Manager extends Staff {
  Manager(
      {required sId,
      required name,
      phone,
      required email,
      required role,
      required url})
      : super(
            sId: sId,
            name: name,
            phone: phone,
            email: email,
            role: role,
            url: url);

  Manager.fromJson(Map<String, dynamic> json) : super.fromJson(json);
}
