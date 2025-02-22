import 'package:flutter/material.dart';
import 'package:tasks_admin/core/routing/navigation_manager.dart';
import 'package:tasks_admin/core/utils/color_manager.dart';

import '../../../../../generated/l10n.dart';

class CreateTaskAppbar extends StatelessWidget {
  const CreateTaskAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 2,
      shadowColor: ColorManager.grey,
      backgroundColor: ColorManager.white,
      title: Text(S.of(context).create_task,
          style: TextStyle(color: ColorManager.primary)),
      centerTitle: true,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios,
          color: ColorManager.primary,
        ),
        onPressed: () => context.pop(),
      ),
    );
  }
}
