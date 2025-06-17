import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irllink/src/domain/entities/chat/chat_message.dart'
    show Platform;
import 'package:irllink/src/presentation/controllers/settings/hidden_users_settings_controller.dart';

class ManageListHiddenUsers extends GetView<HiddenUsersSettingsController> {
  const ManageListHiddenUsers({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Theme.of(context).textTheme.bodyLarge!.color,
              ),
              onPressed: () => Get.back(),
            ),
            actions: const [],
            title: Text(
              "manage_hidden_users".tr,
            ),
          ),
          body: DecoratedBox(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: controller.hiddenUsers.isEmpty
                      ? Container(
                          padding: const EdgeInsets.only(top: 20),
                          child: const Text(
                            "Nothing in the list! To add users, select them in a chat and press 'Hide user'",
                            textAlign: TextAlign.center,
                          ),
                        )
                      : ReorderableListView.builder(
                          shrinkWrap: true,
                          padding: const EdgeInsets.only(
                            top: 8,
                            left: 18,
                            right: 18,
                            bottom: 8,
                          ),
                          itemCount: controller.hiddenUsers.length,
                          onReorder: (int oldIndex, int newIndex) {
                            if (newIndex > oldIndex) {
                              newIndex -= 1;
                            }
                            final element =
                                controller.hiddenUsers.removeAt(oldIndex);
                            controller.hiddenUsers.insert(newIndex, element);
                          },
                          itemBuilder: (BuildContext context, int index) {
                            var elem = controller.hiddenUsers[index];

                            return Container(
                              key: ValueKey(
                                elem,
                              ),
                              color: Theme.of(context).colorScheme.secondary,
                              padding: const EdgeInsets.only(
                                left: 20,
                                right: 20,
                                bottom: 10,
                                top: 10,
                              ),
                              margin: const EdgeInsets.only(bottom: 5, top: 5),
                              child: InkWell(
                                onTap: () {},
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Image.asset(
                                      elem.platform == Platform.twitch
                                          ? "lib/assets/twitch/twitch_logo.png"
                                          : elem.platform == Platform.kick
                                              ? "lib/assets/kick/kickLogo.png"
                                              : "lib/assets/youtube/youtubeLogo.png",
                                      width: 30,
                                    ),
                                    Text(
                                      controller.hiddenUsers[index].id,
                                      style: TextStyle(
                                        color: Theme.of(context)
                                            .textTheme
                                            .bodyLarge!
                                            .color,
                                        fontSize: 12,
                                      ),
                                    ),
                                    Text(
                                      controller.hiddenUsers[index].username,
                                      style: TextStyle(
                                        color: Theme.of(context)
                                            .textTheme
                                            .bodyLarge!
                                            .color,
                                        fontSize: 20,
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        controller.removeHiddenUser(
                                          controller.hiddenUsers[index],
                                        );
                                      },
                                      child: const Icon(
                                        Icons.close,
                                        color: Colors.red,
                                        size: 30,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                ),
                Container(),
              ],
            ),
          ),
        );
      },
    );
  }
}
