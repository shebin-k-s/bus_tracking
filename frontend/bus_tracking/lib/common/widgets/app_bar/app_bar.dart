import 'package:bus_tracking/common/helpers/is_dark_mode.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BasicAppbar extends StatelessWidget implements PreferredSizeWidget {
  final Color? backgroundColor;
  final bool hideBack;
  final Widget? title;
  final Widget? action;

  const BasicAppbar({
    super.key,
    this.backgroundColor,
    this.hideBack = false,
    this.title,
    this.action,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: title ?? const Text(''),
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      centerTitle: true,
      leadingWidth: 75,
      leading: hideBack
          ? null
          : IconButton(
              onPressed: () async {
                if (FocusManager.instance.primaryFocus?.hasFocus ?? false) {
                  FocusScope.of(context).unfocus();
                  Future.delayed(const Duration(milliseconds: 500), () {
                    Navigator.pop(context);
                  });
                } else {
                  Navigator.pop(context);
                }
                // FocusScope.of(context).unfocus();
                // Navigator.pop(context);
              },
              icon: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 0.5,
                    color: context.isDarkMode ? Colors.white : Colors.black,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.arrow_back_ios_new,
                  size: 20,
                ),
              ),
            ),
      backgroundColor: backgroundColor ?? Colors.transparent,
      systemOverlayStyle: context.isDarkMode
          ? SystemUiOverlayStyle.light
          : SystemUiOverlayStyle.dark,
      actions: [
        action ?? Container(),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
