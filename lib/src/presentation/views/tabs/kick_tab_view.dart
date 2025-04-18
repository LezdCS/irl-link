import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irllink/src/presentation/controllers/kick_tab_view_controller.dart';

class KickTabView extends GetView<KickTabViewController> {
  const KickTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          spacing: 10,
          children: [
            Obx(
              () => controller.kickCategories.isEmpty
                  ? const SizedBox.shrink()
                  : SizedBox(
                      width: 400,
                      child: DropdownButtonFormField<int>(
                        isExpanded: true,
                        decoration: const InputDecoration(
                          labelText: 'Select Category',
                          border: OutlineInputBorder(),
                        ),
                        items: controller.kickCategories.map((category) {
                          return DropdownMenuItem<int>(
                            value: category.id,
                            child: Text(category.name),
                          );
                        }).toList(),
                        onChanged: (int? newValue) {
                          // Handle category selection
                        },
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
