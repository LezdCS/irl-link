import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/settings_view_controller.dart';

class ManageListHiddenUsers extends GetView {
  ManageListHiddenUsers({
    required this.controller,
  });

  final SettingsViewController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Theme.of(context).textTheme.bodyText1!.color,
            ),
            onPressed: () => Get.back(),
          ),
          actions: [],
          backgroundColor: Theme.of(context).colorScheme.secondary,
          title: Text(
            "Manage hidden users",
            style: TextStyle(
              color: Theme.of(context).textTheme.bodyText1!.color,
            ),
          ),
          centerTitle: false,
        ),
        body: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.background,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: controller.settings.value.hiddenUsersIds!.length <= 0
                    ? Container(
                        padding: EdgeInsets.only(top: 20),
                        child: Text(
                          "Nothing in the list!",
                          style: TextStyle(
                            color: Theme.of(context).textTheme.bodyText1!.color,
                          ),
                        ),
                      )
                    : controller.usernamesHiddenUsers.length !=
                            controller.settings.value.hiddenUsersIds!.length
                        ? Container(
                            padding: EdgeInsets.only(top: 20),
                            child: Column(
                              children: [
                                CircularProgressIndicator(),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Loading...",
                                  style: TextStyle(
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .color,
                                  ),
                                ),
                              ],
                            ),
                          )
                        : ReorderableListView.builder(
                            shrinkWrap: true,
                            padding: EdgeInsets.only(
                                top: 8, left: 18, right: 18, bottom: 8),
                            itemCount: controller.usernamesHiddenUsers.length,
                            onReorder: (int oldIndex, int newIndex) {
                              if (newIndex > oldIndex) {
                                newIndex -= 1;
                              }
                              final element = controller
                                  .settings.value.hiddenUsersIds!
                                  .removeAt(oldIndex);
                              controller.settings.value.hiddenUsersIds!
                                  .insert(newIndex, element);
                            },
                            itemBuilder: (BuildContext context, int index) {
                              var elem = controller
                                  .settings.value.hiddenUsersIds![index];

                              return Container(
                                key: ValueKey(
                                  elem,
                                ),
                                color: Theme.of(context).colorScheme.secondary,
                                padding: EdgeInsets.only(
                                    left: 20, right: 20, bottom: 10, top: 10),
                                margin: EdgeInsets.only(bottom: 5, top: 5),
                                child: InkWell(
                                  onTap: () {},
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        controller.usernamesHiddenUsers[index],
                                        style: TextStyle(
                                          color: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .color,
                                          fontSize: 20,
                                        ),
                                      ),
                                      Container(
                                        child: InkWell(
                                          onTap: () {
                                            controller.usernamesHiddenUsers
                                                .removeAt(index);
                                            controller.removeHiddenUser(elem);
                                          },
                                          child: Icon(
                                            Icons.close,
                                            color: Colors.red,
                                            size: 30,
                                          ),
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
      ),
    );
  }
}
