import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irllink/src/domain/entities/settings/browser_tab_settings.dart';
import 'package:irllink/src/presentation/controllers/kick_tab_view_controller.dart';
import 'package:irllink/src/presentation/views/tabs/twitch_tab_view.dart';
import 'package:irllink/src/presentation/widgets/web_page_view.dart';

class KickTabView extends GetView<KickTabViewController> {
  const KickTabView({super.key});
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 10,
          children: [
            Wrap(
              children: [
                SizedBox(
                  width: 14,
                  height: 14,
                  child: AnimatedBuilder(
                    animation: controller.refreshDataAnimationController,
                    builder: (context, child) {
                      return CircularProgressIndicator(
                        value: controller.refreshDataAnimationController.value,
                        strokeWidth: 2,
                        color: Theme.of(context).colorScheme.tertiary,
                        backgroundColor:
                            Theme.of(context).colorScheme.tertiaryContainer,
                      );
                    },
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  "refresh_data".tr,
                  style: const TextStyle(
                    fontSize: 10,
                  ),
                ),
              ],
            ),
            Obx(
              () => controller.kickCategories.isEmpty
                  ? const SizedBox.shrink()
                  : DropdownButtonFormField<int>(
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
            TextFormField(
              controller: controller.titleFormController,
              focusNode: controller.focus,
              decoration: const InputDecoration(
                labelText: 'Stream Title',
                border: OutlineInputBorder(),
              ),
            ),
            Obx(
              () => shortcutButton(
                context: context,
                text: controller.displayKickPlayer.value
                    ? "hide_stream".tr
                    : "show_stream".tr,
                onTap: () => {
                  controller.displayKickPlayer.toggle(),
                },
                isOn: controller.displayKickPlayer.value,
              ),
            ),
            Obx(
              () => Visibility(
                visible: controller.displayKickPlayer.value,
                child: SizedBox(
                  height: 200,
                  width: double.infinity,
                  child: WebPageView(
                    BrowserTab(
                      iOSAudioSource: false,
                      id: '1',
                      title: '',
                      toggled: true,
                      url:
                          'https://player.kick.com/${controller.homeViewController.kickData?.kickUser.name}',
                    ),
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
