import 'package:eva/services/admob_service.dart';
import 'package:eva/services/bottom_navigation_service.dart';
import 'package:eva/services/files_service.dart';
import 'package:eva/ux/screens/actions/actions_screen.dart';
import 'package:eva/ux/screens/files/files_screen.dart';
import 'package:eva/ux/screens/home/home_screen.dart';
import 'package:eva/ux/screens/user_profile/user_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomNavigationComponent extends StatefulWidget {
  const BottomNavigationComponent({super.key});

  @override
  State<BottomNavigationComponent> createState() =>
      _BottomNavigationComponentState();
}

class _BottomNavigationComponentState extends State<BottomNavigationComponent> {
  final BottomNavigationService bottomNavigationService = Get.put(
    BottomNavigationService(),
  );

  @override
  void initState() {
    super.initState();

    Get.put(AdmobService());
    Get.put(FilesService());
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return Scaffold(
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: bottomNavigationService.index.value,
            showUnselectedLabels: false,

            onTap: (value) {
              bottomNavigationService.navigatorPage(value);
            },
            items: [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home_outlined,
                  size: 30,
                ),
                label: 'Home',
                activeIcon: Icon(
                  Icons.home,
                  size: 33,
                ),
              ),

              BottomNavigationBarItem(
                icon: Icon(
                  Icons.security_outlined,
                  size: 30,
                ),
                label: 'Ações',
                activeIcon: Icon(
                  Icons.security,
                  size: 33,
                ),
              ),

              BottomNavigationBarItem(
                icon: Icon(
                  Icons.document_scanner_outlined,
                  size: 30,
                ),
                label: 'Provas',
                activeIcon: Icon(
                  Icons.document_scanner,
                  size: 33,
                ),
              ),

              BottomNavigationBarItem(
                icon: Icon(
                  Icons.person_outline_sharp,
                  size: 30,
                ),
                label: 'Perfil',
                activeIcon: Icon(
                  Icons.person_sharp,
                  size: 33,
                ),
              ),
            ],
          ),

          body: PageView(
            controller: bottomNavigationService.pageController,
            physics: NeverScrollableScrollPhysics(),
            children: [
              HomeScreen(),
              ActionsScreen(),
              FilesScreen(),
              UserProfileScreen(),
            ],
          ),
        );
      },
    );
  }
}
