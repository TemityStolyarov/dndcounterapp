import 'package:dndcounterapp/core/colors/color_palette.dart';
import 'package:dndcounterapp/core/data/user_repository.dart';
import 'package:dndcounterapp/core/models/table_data_model.dart';
import 'package:dndcounterapp/core/models/user_data_model.dart';
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
    final userRepository = UserRepository();

    return Scaffold(
      backgroundColor: ColorPalette.backgroundColor,
      body: FutureBuilder(
        future: userRepository.getTableData(userData.userId),
        builder: (context, AsyncSnapshot<TableDataModel> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }

          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          final TableDataModel tablesData = snapshot.data!;

          return Column(
            children: [
              Text(
                tablesData.name.toString(),
              ),
            ],
          );
        },
      ),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        foregroundColor: ColorPalette.fontBaseColor,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.panorama_fish_eye_outlined),
              tooltip: userData.nickname,
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      ),
      drawer: Drawer(
        child: Column(
          mainAxisSize: MainAxisSize.max,
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
            InkWell(
              onTap: () => print('Settings page is unavailible'),
              child: const Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 10,
                ),
                child: SizedBox(
                  child: Row(
                    children: [
                      Text('Настройки'),
                      Spacer(),
                      Icon(Icons.settings_rounded),
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
