import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irllink/src/core/services/settings_service.dart';
import 'package:irllink/src/domain/entities/settings.dart';
import 'package:irllink/src/presentation/controllers/settings_view_controller.dart';

class ManageListHiddenUsers extends GetView<SettingsViewController> {
  const ManageListHiddenUsers({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        Settings settings = Get.find<SettingsService>().settings.value;
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
          body: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: settings.hiddenUsersIds!.isEmpty
                      ? Container(
                          padding: const EdgeInsets.only(top: 20),
                          child: const Text(
                            "Nothing in the list! To add users, select them in a chat and press 'Hide user'",
                            textAlign: TextAlign.center,
                          ),
                        )
                      : controller.usernamesHiddenUsers.length !=
                              settings.hiddenUsersIds!.length
                          ? Container(
                              padding: const EdgeInsets.only(top: 20),
                              child: const Column(
                                children: [
                                  CircularProgressIndicator(),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "Loading...",
                                  ),
                                ],
                              ),
                            )
                          : ReorderableListView.builder(
                              shrinkWrap: true,
                              padding: const EdgeInsets.only(
                                  top: 8, left: 18, right: 18, bottom: 8),
                              itemCount: controller.usernamesHiddenUsers.length,
                              onReorder: (int oldIndex, int newIndex) {
                                if (newIndex > oldIndex) {
                                  newIndex -= 1;
                                }
                                final element =
                                    settings.hiddenUsersIds!.removeAt(oldIndex);
                                settings.hiddenUsersIds!
                                    .insert(newIndex, element);
                              },
                              itemBuilder: (BuildContext context, int index) {
                                var elem = settings.hiddenUsersIds![index];

                                return Container(
                                  key: ValueKey(
                                    elem,
                                  ),
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20, bottom: 10, top: 10),
                                  margin:
                                      const EdgeInsets.only(bottom: 5, top: 5),
                                  child: InkWell(
                                    onTap: () {},
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          controller
                                              .usernamesHiddenUsers[index],
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
                                            controller.usernamesHiddenUsers
                                                .removeAt(index);
                                            controller.removeHiddenUser(elem);
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
