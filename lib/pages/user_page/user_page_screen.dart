import 'package:dndcounterapp/components/ttx_appbar/ttx_appbar.dart';
import 'package:dndcounterapp/core/colors/ttx_theme.dart';
import 'package:dndcounterapp/core/models/user_data_model.dart';
import 'package:dndcounterapp/pages/table_page/table_page.dart';
import 'package:flutter/material.dart';

class UserPageScreen extends StatefulWidget {
  const UserPageScreen({
    super.key,
    required this.signOut,
    required this.userData,
  });

  final VoidCallback signOut;
  final UserDataModelConverted userData;

  @override
  State<UserPageScreen> createState() => _UserPageScreenState();
}

class _UserPageScreenState extends State<UserPageScreen> {
  bool isDefault = true;
  
  @override
  Widget build(BuildContext context) {
    final theme =
        widget.userData.lightTheme ? ColorTheme.light : ColorTheme.dark;

    return Scaffold(
      backgroundColor: theme.backgroundColorSecondary,
      appBar: PreferredSize(
        preferredSize: const Size(1000, 48),
        child: TTxAppBar(
          theme: theme,
          isDefault: isDefault,
          onTap: () {
            setState(() {
              isDefault = !isDefault;
            });
          },
        ),
      ),
      body: isDefault
          ? TablePage(
              userId: widget.userData.userId,
              theme: theme,
            )
          : const Placeholder(),
      drawer: Drawer(
        backgroundColor: theme.backgroundColorSecondary,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 16,
              ),
              child: SizedBox(
                child: Text(
                  '${widget.userData.nickname} (${widget.userData.email})',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: theme.fontColorPrimary),
                ),
              ),
            ),
            const Divider(
              height: 0,
            ),
            InkWell(
              onTap: null,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 10,
                ),
                child: SizedBox(
                  child: Row(
                    children: [
                      Text(
                        'Настройки',
                        style: TextStyle(
                          color: theme.fontColorLabel,
                        ),
                      ),
                      const Spacer(),
                      Icon(
                        Icons.settings_rounded,
                        color: theme.fontColorLabel,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: widget.signOut,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 10,
                ),
                child: SizedBox(
                  child: Row(
                    children: [
                      Text(
                        'Выйти',
                        style: TextStyle(color: theme.fontColorPrimary),
                      ),
                      const Spacer(),
                      Icon(
                        Icons.output_rounded,
                        color: theme.fontColorPrimary,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: Text(
                  'v2.0.22.1',
                  style: TextStyle(
                    color: theme.fontColorLabel,
                    fontSize: 10,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
