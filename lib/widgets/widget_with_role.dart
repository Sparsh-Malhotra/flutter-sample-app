import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pathshala/app_contants.dart';

class WidgetWithRole extends StatefulWidget {
  const WidgetWithRole({
    Key? key,
    required this.child,
    required this.allowedRoles,
  }) : super(key: key);

  final Widget child;
  final List<Roles> allowedRoles;

  @override
  State<WidgetWithRole> createState() {
    return _WidgetWithRoleState();
  }
}

class _WidgetWithRoleState extends State<WidgetWithRole> {
  late final dynamic userDetails;
  late final Roles userRole;

  @override
  void initState() {
    if (GetStorage().hasData('user_details')) {
      userDetails = GetStorage().read('user_details');
      userRole = Roles.fromId(userDetails['profile']['groups'][0]);
    } else {
      userRole = Roles.guest;
    }
    super.initState();
  }

  bool get isAllowed => widget.allowedRoles.contains(userRole);

  @override
  Widget build(BuildContext context) {
    if (isAllowed) {
      return widget.child;
    } else {
      return Container();
    }
  }
}
