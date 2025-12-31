import 'package:eva/services/fairy_godmonthers_service.dart';
import 'package:eva/services/user_service.dart';
import 'package:eva/utils/utils_general.dart';
import 'package:eva/ux/screens/apply_to_be_a_fairy_godmonther/remove_or_add_candidature_fairy_godmother_screen.dart';
import 'package:eva/ux/screens/fairy_godmothers/widgets/filter_fairy_godmonthers_widget.dart';
import 'package:eva/ux/screens/fairy_godmothers/widgets/list_fairy_godmonthers_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FairyGodmothersScreen extends StatefulWidget {
  const FairyGodmothersScreen({super.key});

  @override
  State<FairyGodmothersScreen> createState() => _FairyGodmothersScreenState();
}

class _FairyGodmothersScreenState extends State<FairyGodmothersScreen> {
  final FairyGodmonthersService fairyGodmonthersService = Get.put(
    FairyGodmonthersService(),
  );

  final UserService userService = Get.find();

  @override
  void initState() {
    super.initState();

    Get.put(FairyGodmonthersService());
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return Scaffold(
          appBar: AppBar(
            title: Text('Fadas Madrinhas'),
            actionsPadding: EdgeInsets.symmetric(horizontal: 10),
            actions: [
              IconButton(
                onPressed: () {
                  Get.to(() => RemoveOrAddCandidatureFairyGodmotherScreen());
                },
                icon:
                    userService.userModel.value!.volunteerFairyGodmonther ==
                        true
                    ? Icon(
                        Icons.person_remove_alt_1_outlined,
                        color: Colors.red,
                        size: 30,
                      )
                    : Icon(
                        Icons.person_add_alt,
                        color: color.primary,
                        size: 30,
                      ),
              ),
            ],
          ),
          body: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SearchBar(
                    leading: Icon(Icons.search),
                    hintText: 'Pesquisar por nome',
                  ),
                ),

                SizedBox(height: 20),

                FilterFairyGodmonthersWidget(),

                SizedBox(height: 20),

                ListFairyGodmonthersWidget(),
              ],
            ),
          ),
        );
      },
    );
  }
}
