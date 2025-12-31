import 'package:eva/models/user_model.dart';
import 'package:eva/services/user_service.dart';
import 'package:eva/themes/app_text_style_theme.dart';
import 'package:eva/utils/open_url_and_email_util.dart';
import 'package:eva/utils/utils_general.dart';
import 'package:eva/ux/components/card_action_component.dart';
import 'package:eva/ux/screens/profile_edit_user/profile_edit_user_screen.dart';
import 'package:eva/ux/screens/user_profile/widgets/card_fairy_godmonther_widget.dart';
import 'package:eva/ux/screens/user_profile/widgets/support_network_widget.dart';
import 'package:eva/ux/screens/user_profile/widgets/user_datas_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserProfileScreen extends StatelessWidget {
  UserProfileScreen({super.key});

  final UserService userService = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () {
          UserModel userModel = userService.userModel.value!;

          return SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(height: 30),

                      Center(
                        child: CircleAvatar(
                          radius: 60,
                          backgroundImage: NetworkImage(userModel.profileImage),
                        ),
                      ),

                      SizedBox(height: 30),

                      Text(
                        'Informações pessoais',
                        style: AppTextStyleTheme.title,
                      ),

                      SizedBox(height: 15),

                      UserDatasWidget(),

                      SizedBox(height: 20),

                      InkWell(
                        onTap: () {
                          Get.to(() => ProfileEditUserScreen());
                        },
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          decoration: BoxDecoration(
                            color: color.secondary,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ListTile(
                            leading: Icon(
                              Icons.edit_note_outlined,
                              size: 30,
                              color: color.primary,
                            ),
                            title: Text(
                              'Editar Perfil',
                              style: AppTextStyleTheme.title.apply(
                                color: color.primary,
                              ),
                            ),
                            trailing: Icon(Icons.arrow_forward),
                          ),
                        ),
                      ),

                      SizedBox(height: 30),

                      Text(
                        'Sua rede de Apoio',
                        style: AppTextStyleTheme.h3,
                      ),

                      SizedBox(height: 5),

                      Text(
                        'Gerencie sua rede de apoio: adicione ou remova quem você confia',
                        style: AppTextStyleTheme.subTitle,
                      ),

                      SizedBox(height: 15),

                      SupportNetworkWidget(),

                      SizedBox(height: 30),

                      Text(
                        'Rede de Proteção Local',
                        style: AppTextStyleTheme.title,
                      ),

                      SizedBox(height: 15),

                      CardActionComponent(
                        title: 'DEAM - Delegacia da mulher',
                        image: 'assets/images/profile_component_01.png',
                        function: () {},
                      ),

                      SizedBox(height: 15),

                      CardActionComponent(
                        title: 'CREAS - Centro de Referência',
                        image: 'assets/images/profile_component_02.png',
                        function: () {
                          openUrlUtil(
                            'https://creas.municipal.com.br/creas-centro-de-referencia-especializado-da-assistenicia-social-governador-valadares-mg/',
                          );
                        },
                      ),

                      SizedBox(height: 15),

                      CardActionComponent(
                        title: 'Policlínica Municipal',
                        image: 'assets/images/profile_component_03.png',
                        function: () {
                          openUrlUtil(
                            'https://www.oabmg.org.br/',
                          );
                        },
                      ),

                      SizedBox(height: 15),

                      CardActionComponent(
                        title: 'OAB - Ordem dos Advogados',
                        image: 'assets/images/profile_component_04.png',
                        function: () {
                          openUrlUtil(
                            'https://www.oabmg.org.br/',
                          );
                        },
                      ),

                      SizedBox(height: 15),

                      CardActionComponent(
                        title: 'Defensoria Pública',
                        image: 'assets/images/profile_component_05.png',
                        function: () {
                          openUrlUtil(
                            'https://defensoria.mg.def.br/unidade/governador-valadares/',
                          );
                        },
                      ),

                      SizedBox(height: 20),

                      CardFairyGodmontherWidget(),

                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
