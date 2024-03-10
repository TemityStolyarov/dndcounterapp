import 'package:dndcounterapp/components/ttx_appbar/ttx_appbar.dart';
import 'package:dndcounterapp/core/colors/color_palette.dart';
import 'package:dndcounterapp/core/models/user_data_model.dart';
import 'package:dndcounterapp/pages/table_page/table_page.dart';
import 'package:flutter/material.dart';

class UserPageScreen extends StatelessWidget {
  const UserPageScreen({
    super.key,
    required this.signOut,
    required this.userData,
  });

  final VoidCallback signOut;
  final UserDataModelConverted userData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.backgroundColor,
      body: Stack(
        children: [
          TablePage(userId: userData.userId),
          const TTxAppBar(),
        ],
      ),
      drawer: Drawer(
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
                  '${userData.nickname} (${userData.email})',
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            const Divider(
              height: 0,
            ),
            const InkWell(
              onTap: null,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 10,
                ),
                child: SizedBox(
                  child: Row(
                    children: [
                      Text(
                        'Настройки',
                        style: TextStyle(
                          color: ColorPalette.attKD,
                        ),
                      ),
                      Spacer(),
                      Icon(
                        Icons.settings_rounded,
                        color: ColorPalette.attKD,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: signOut,
              child: const Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 10,
                ),
                child: SizedBox(
                  child: Row(
                    children: [
                      Text('Выйти'),
                      Spacer(),
                      Icon(Icons.output_rounded),
                    ],
                  ),
                ),
              ),
            ),
            const Spacer(),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Center(
                child: Text(
                  'v2.0.22.1',
                  style: TextStyle(
                    color: ColorPalette.attKD,
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
