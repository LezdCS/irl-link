import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ManageList extends GetView {
  ManageList({
    required this.title,
    required this.list,
    required this.isReorderable,
    required this.controller,
    required this.addFunction,
    required this.removeFunction,
  });

  final String title;
  final List list;
  final bool isReorderable;
  final GetxController controller;
  final Function addFunction;
  final Function removeFunction;

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
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
        child: ReorderableListView.builder(
          padding: EdgeInsets.only(top: 8, left: 18, right: 18, bottom: 8),
          itemCount: list.length,
          onReorder: (int oldIndex, int newIndex) {},
          itemBuilder: (BuildContext context, int index) {
            var elem = list[index];
            return Container(child: Text(elem));
          },
        ),
      ),
    );
  }
}
