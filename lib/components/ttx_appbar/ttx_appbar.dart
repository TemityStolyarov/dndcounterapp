import 'package:flutter/material.dart';

class TTxAppBar extends StatelessWidget {
  const TTxAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      child: Row(
        children: [
          SizedBox(
            height: 24,
            width: 24,
            child: InkWell(
              onTap: () {
                Scaffold.of(context).openDrawer();
              },
              radius: 20,
              splashColor: Colors.transparent,
              focusColor: Colors.transparent,
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              child: const Icon(
                Icons.account_circle_rounded,
                size: 28,
              ),
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
