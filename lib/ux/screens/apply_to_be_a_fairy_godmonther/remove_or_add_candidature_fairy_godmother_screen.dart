import 'package:eva/services/remove_or_add_candidature_fairy_godmonther_service.dart';
import 'package:eva/services/user_service.dart';
import 'package:eva/ux/screens/apply_to_be_a_fairy_godmonther/widgets/add_candidature_fairy_godmonther_widget.dart';
import 'package:eva/ux/screens/apply_to_be_a_fairy_godmonther/widgets/remove_candidature_fairygodmonther_widget.dart';
import 'package:eva/ux/screens/loadings/loadings_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RemoveOrAddCandidatureFairyGodmotherScreen extends StatelessWidget {
  RemoveOrAddCandidatureFairyGodmotherScreen({super.key});

  final UserService userService = Get.find();

  final RemoveOrAddCandidatureFairyGodmontherService
  removeOrAddCandidatureFairyGodmontherService = Get.put(
    RemoveOrAddCandidatureFairyGodmontherService(),
  );

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        if (removeOrAddCandidatureFairyGodmontherService.isLoading.value ==
            true) {
          return LoadingsScreen(
            loadingIndex: 2,
          );
        } else {
          if (userService.userModel.value!.volunteerFairyGodmonther == false) {
            return AddCandidatureFairyGodmontherWidget();
          } else {
            return RemoveCandidatureFairygodmontherWidget();
          }
        }
      },
    );
  }
}
