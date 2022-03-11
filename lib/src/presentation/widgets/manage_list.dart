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
  });

  final String title;
  final RxList list;
  final bool isReorderable;
  final SettingsViewController controller;
  final Function addFunction;
  final Function removeFunction;
  final Function removeAllFunction;

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
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
            children: [
              Container(
                child: ReorderableListView.builder(
                  shrinkWrap: true,
                  padding:
                      EdgeInsets.only(top: 8, left: 18, right: 18, bottom: 8),
                  itemCount: list.length,
                  onReorder: (int oldIndex, int newIndex) {},
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
                  child: InkWell(
                      onTap: () {
                        removeAllFunction();
                      },
                      child: Text("Delete all"))),
            ],
          ),
        ),
      ),
    );
  }
}
