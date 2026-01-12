import 'package:eva/themes/app_text_style_theme.dart';
import 'package:eva/ux_adm/screens/home_adm/scheduling_police_woman_adm/scheduling_police_woman_adm_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeAdmScreen extends StatelessWidget {
  const HomeAdmScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
            icon: Icon(
              Icons.logout,
              size: 35,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              SizedBox(height: 30),

              Image.asset(
                'assets/images/logo_transparente.png',
                height: 200,
              ),

              SizedBox(height: 20),

              InkWell(
                onTap: () {
                  Get.to(() => SchedulingPoliceWomanAdmScreen());
                },
                borderRadius: BorderRadius.circular(10),
                child: Card(
                  margin: EdgeInsets.all(0),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: ListTile(
                      leading: Image.asset(
                        'assets/images/profile_component_01.png',
                      ),
                      title: Text(
                        'Agendamento Delegacia da Mulher',
                        style: AppTextStyleTheme.title,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
