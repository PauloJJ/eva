import 'package:eva/models/user_model.dart';
import 'package:eva/themes/app_text_style_theme.dart';
import 'package:eva/utils/open_url_and_email_util.dart';
import 'package:eva/utils/utils_general.dart';
import 'package:flutter/material.dart';

class ShowDatasUserWidget extends StatelessWidget {
  final UserModel userModel;

  const ShowDatasUserWidget({
    super.key,
    required this.userModel,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          contentPadding: EdgeInsets.all(0),
          leading: CircleAvatar(
            radius: 30,
            backgroundImage: NetworkImage(userModel.profileImage),
          ),
          title: Text(
            userModel.name,
            style: AppTextStyleTheme.title,
          ),
          subtitle: Text(
            userModel.professionFairyGodmonther!,
          ),
        ),

        Divider(height: 20),

        ListTile(
          onTap: () {
            openUrlUtil(
              'https://api.whatsapp.com/send/?phone=${userModel.countryCode}${userModel.phoneNumber}&text=Ol%C3%A1%21+Vim+pelo+app+Eva.+Vi+que+voc%C3%AA+se+candidatou+como+fada+madrinha+e+gostaria+de+pedir+sua+ajuda.&type=phone_number&app_absent=0',
            );
          },
          contentPadding: EdgeInsets.all(0),
          leading: Image.asset(
            'assets/images/whatszapp.png',
            height: 35,
          ),
          title: Text(
            userModel.phoneNumber,
            style: AppTextStyleTheme.title.apply(color: color.primary),
          ),
        ),

        ListTile(
          onTap: () {
            openEmail(
              email: userModel.email,
              message:
                  'subject=Olá preciso da sua ajuda&body=Olá! Encontrei seu perfil no app Eva e vi que você se candidatou como fada madrinha. Gostaria muito do seu apoio.',
            );
          },
          contentPadding: EdgeInsets.all(0),
          leading: Icon(
            Icons.email_outlined,
            color: color.primary,
            size: 36,
          ),
          title: FittedBox(
            child: Text(
              userModel.email,
              style: AppTextStyleTheme.title.apply(color: color.primary),
            ),
          ),
        ),
      ],
    );
  }
}
