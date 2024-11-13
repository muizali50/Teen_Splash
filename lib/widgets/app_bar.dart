import 'package:flutter/material.dart';
import 'package:teen_splash/features/users/views/sub_features/chat_room_screen/views/chat_room_screen.dart';

class AppBarWidget extends StatefulWidget {
  final bool isMenyIcon;
  final bool isBackIcon;
  final bool isChatIcon;
  final bool isTittle;
  final String? title;
  final bool? isGuest;
  const AppBarWidget({
    this.isMenyIcon = false,
    this.isBackIcon = false,
    this.isChatIcon = false,
    this.isTittle = false,
    this.title,
    this.isGuest = false,
    super.key,
  });

  @override
  State<AppBarWidget> createState() => _AppBarWidgetState();
}

class _AppBarWidgetState extends State<AppBarWidget> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 100,
      leading: widget.isMenyIcon
          ? Padding(
              padding: const EdgeInsets.only(
                left: 16.0,
              ),
              child: Align(
                alignment: Alignment.center,
                child: Builder(
                  builder: (context) {
                    return InkWell(
                      onTap: () {
                        Scaffold.of(context).openDrawer();
                      },
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          color: const Color(0xFFF4F4F4),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: ImageIcon(
                            color: Theme.of(context).colorScheme.secondary,
                            const AssetImage(
                              'assets/icons/menu.png',
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            )
          : widget.isBackIcon
              ? Padding(
                  padding: const EdgeInsets.only(
                    left: 16.0,
                  ),
                  child: Align(
                    alignment: Alignment.center,
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          color: const Color(0xFFF4F4F4),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: ImageIcon(
                            color: Theme.of(context).colorScheme.secondary,
                            const AssetImage(
                              'assets/icons/back.png',
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              : null,
      actions: widget.isChatIcon
          ? [
              Padding(
                padding: const EdgeInsets.only(
                  right: 16.0,
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (
                            context,
                          ) =>
                              ChatRoomScreen(
                            isGuest: widget.isGuest == true ? true : null,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF4F4F4),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: ImageIcon(
                          color: Theme.of(context).colorScheme.secondary,
                          const AssetImage(
                            'assets/icons/chat.png',
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ]
          : null,
      title: widget.isTittle
          ? Text(
              widget.title.toString(),
              style: TextStyle(
                fontFamily: 'Lexend',
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Theme.of(context).colorScheme.surface,
              ),
            )
          : null,
      centerTitle: true,
      automaticallyImplyLeading: false,
      elevation: 0.0,
      scrolledUnderElevation: 0.0,
      backgroundColor: Colors.transparent,
    );
  }
}
