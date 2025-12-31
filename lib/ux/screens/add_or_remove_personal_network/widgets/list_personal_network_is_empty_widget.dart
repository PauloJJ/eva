import 'package:eva/services/add_or_remove_personal_network_service.dart';
import 'package:eva/themes/app_text_style_theme.dart';
import 'package:eva/utils/utils_general.dart';
import 'package:flutter/material.dart';

class ListPersonalNetworkIsEmptyWidget extends StatelessWidget {
  const ListPersonalNetworkIsEmptyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Sua rede de confiança está vazia. Adicione uma pessoa para começar.',
          textAlign: TextAlign.center,
          style: AppTextStyleTheme.title.apply(
            color: Colors.grey.shade700,
          ),
        ),

        SizedBox(height: 20),

        Center(
          child: OutlinedButton(
            onPressed: () {
              AddOrRemovePersonalNetworkService().showBottomAddOrEditPersonal(
                isEdit: false,
              );
            },
            child: SizedBox(
              width: size.width,
              height: 50,
              child: Center(
                child: Text(
                  'Adicionar',
                  style: AppTextStyleTheme.h3,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
