import 'package:eva/services/fairy_godmonthers_service.dart';
import 'package:eva/themes/app_text_style_theme.dart';
import 'package:eva/utils/utils_general.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FilterFairyGodmonthersWidget extends StatelessWidget {
  FilterFairyGodmonthersWidget({super.key});

  final FairyGodmonthersService fairyGodmonthersService = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        String categorySelect = fairyGodmonthersService.categorySelect.value;

        return SizedBox(
          height: 45,
          child: ListView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.symmetric(horizontal: 20),
            itemCount: fairyGodmonthersService.filterlist.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              String category = fairyGodmonthersService.filterlist[index];

              bool isSelect = category == categorySelect ? true : false;

              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: InkWell(
                  borderRadius: BorderRadius.circular(800),
                  onTap: () {
                    fairyGodmonthersService.selectCategory(category);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: isSelect == true ? color.secondary : null,
                      borderRadius: BorderRadius.circular(800),
                      border: BoxBorder.all(color: color.primary),
                    ),
                    child: Center(
                      child: Text(
                        fairyGodmonthersService.filterlist[index],
                        style: isSelect == true
                            ? AppTextStyleTheme.title.apply(
                                color: color.primary,
                              )
                            : AppTextStyleTheme.subTitle,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
