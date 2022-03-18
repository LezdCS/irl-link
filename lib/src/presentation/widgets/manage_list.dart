import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irllink/src/presentation/controllers/settings_view_controller.dart';

class ManageList extends GetView {
  ManageList({
    required this.title,
    required this.list,
    required this.isReorderable,
    required this.controller,
    required this.addFunction,
    required this.removeFunction,
    required this.removeAllFunction,
    required this.addDialogWidget,
  });

  final String title;
  final RxList list;
  final bool isReorderable;
  final SettingsViewController controller;
  final Function addFunction;
  final Function removeFunction;
  final Function removeAllFunction;
  final Widget addDialogWidget;

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
            this.title,
            style: TextStyle(
              color: Theme.of(context).textTheme.bodyText1!.color,
            ),
          ),
          centerTitle: false,
        ),
        body: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: ReorderableListView.builder(
                  shrinkWrap: true,
                  padding:
                      EdgeInsets.only(top: 8, left: 18, right: 18, bottom: 8),
                  itemCount: list.length,
                  onReorder: (int oldIndex, int newIndex) {
                    if (newIndex == list.length) {
                      newIndex -= 1;
                    }
                    var element = list[oldIndex];
                    list.removeAt(oldIndex);
                    list.insert(newIndex, element);
                  },
                  itemBuilder: (BuildContext context, int index) {
                    var elem = list[index];
                    return Row(
                      key: ValueKey(
                        list[index],
                      ),
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          child: Text(elem),
                        ),
                        Container(
                          child: InkWell(
                            onTap: () {
                              removeFunction(elem);
                            },
                            child: Icon(
                              Icons.close,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.only(bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: 120,
                      padding: EdgeInsets.only(
                        top: 10,
                        bottom: 10,
                        left: 5,
                        right: 5,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.all(
                          Radius.circular(2),
                        ),
                      ),
                      child: InkWell(
                        onTap: () {
                          Get.defaultDialog(
                              content: addDialogWidget,
                              title: "Add",
                              textCancel: "Cancel",
                              textConfirm: "Add",
                              titleStyle: TextStyle(color: Colors.white),
                              backgroundColor: Color(0xFF282828),
                              buttonColor: Color(0xFF9147ff),
                              cancelTextColor: Color(0xFF9147ff),
                              confirmTextColor: Colors.white,
                              radius: 10,
                              onConfirm: () {
                                addFunction();
                              });
                        },
                        child: Text(
                          "Add",
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    Container(
                      width: 120,
                      padding: EdgeInsets.only(
                        top: 10,
                        bottom: 10,
                        left: 5,
                        right: 5,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.all(
                          Radius.circular(2),
                        ),
                      ),
                      child: InkWell(
                        onTap: () {
                          removeAllFunction();
                        },
                        child: Text(
                          "Remove all",
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
