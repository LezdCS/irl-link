import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irllink/routes/app_routes.dart';
import 'package:irllink/src/presentation/controllers/HomeViewController.dart';
import 'package:irllink/src/presentation/widgets/WebPageView.dart';
import 'package:irllink/src/presentation/widgets/split_view_custom.dart';

class HomeView extends GetView<HomeViewController> {
  final HomeViewController controller = Get.find<HomeViewController>();

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          GestureDetector(
            onTap: () => {
              FocusScope.of(context).unfocus(),
            },
            child: Container(
              constraints: BoxConstraints.expand(),
              decoration: BoxDecoration(
                color: Color(0xFF480A52),
              ),
              child: SafeArea(
                child: SplitViewCustom(
                  controller: controller.splitViewController,
                  gripColor: Color(0xFF480A52),
                  gripColorActive: Color(0xFF480A52),
                  gripSize: 22,
                  viewMode: SplitViewMode.Vertical,
                  indicator: SplitIndicator(
                    viewMode: SplitViewMode.Vertical,
                    color: Color(0xFFFFFFFF),
                  ),
                  activeIndicator: SplitIndicator(
                    color: Color(0xFFFFFFFF),
                    viewMode: SplitViewMode.Vertical,
                    isActive: true,
                  ),
                  children: [
                    _tabBarCustomWindows(height, width),
                    _twitchChat(width),
                  ],
                  onWeightChanged: (w) {
                    print("Horizon: $w");
                  },
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0.0,
            left: 0.0,
            right: 0.0,
            child: _bottomNavBar(height, width),
          ),
        ],
      ),
    );
  }

  Widget _bottomNavBar(double height, double width) {
    return Obx(
      () => Container(
        height: height * 0.07,
        decoration: BoxDecoration(
          color: Color(0xFF480A52),
        ),
        child: Row(
          children: [
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(left: 10),
              height: double.maxFinite,
              width: width * 0.7,
              child: Stack(
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: Image(
                      image: AssetImage("lib/assets/chatinput.png"),
                    ),
                    // child: SvgPicture.asset(
                    //   './lib/assets/chatinput.svg',
                    //   semanticsLabel: 'Waves',
                    // ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: TextField(
                      maxLines: 1,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintStyle: TextStyle(color: Colors.white, fontSize: 14),
                        hintText: 'Send a message',
                        isDense: true,
                        contentPadding: EdgeInsets.only(left: 10),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: width * 0.15,
              height: double.maxFinite,
              child: InkWell(
                onTap: () {
                  controller.sound.value = !controller.sound.value;
                },
                child: Icon(
                  controller.sound.value ? Icons.volume_up : Icons.volume_off,
                  color:
                      controller.sound.value ? Colors.white : Color(0xFFd63031),
                  size: 22,
                ),
              ),
            ),
            Container(
              width: width * 0.15,
              height: double.maxFinite,
              child: InkWell(
                onTap: () {
                  Get.toNamed(Routes.SETTINGS);
                },
                child: Icon(
                  Icons.settings,
                  color: Colors.white,
                  size: 22,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _tabBarCustomWindows(double height, double width) {
    return SizedBox(
      height: height / 2,
      width: width,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50.0),
          child: AppBar(
            backgroundColor: Color(0xFF480A52),
            bottom: TabBar(
              controller: controller.tabController,
              isScrollable: true,
              indicatorColor: Colors.purple,
              labelPadding: EdgeInsets.symmetric(
                  horizontal:
                      width / (controller.internetPages.length > 2 ? 9 : 5)),
              tabs: List<Tab>.generate(
                controller.internetPages.length,
                (int index) => Tab(
                  child: Text(
                    controller.internetPages[index].title,
                    style: TextStyle(
                        color: controller.tabController.index == index
                            ? Colors.purple
                            : Colors.white),
                  ),
                ),
              ),
            ),
          ),
        ),
        body: SizedBox(
          height: double.infinity,
          child: TabBarView(
            controller: controller.tabController,
            children: List<TabBarPageWidget>.generate(
              controller.internetPages.length,
              (int index) =>
                  TabBarPageWidget(controller.internetPages[index].url),
            ),
          ),
        ),
      ),
    );
  }

  Widget _twitchChat(double width) {
    return Container(
      width: width,
      padding: EdgeInsets.only(left: 10),
      decoration: BoxDecoration(
        color: Color(0xFF480A52),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Welcome to the lezd_ chat room!",
            style: TextStyle(
              color: Color(0xFF878585),
              fontFamily: 'Roboto',
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
