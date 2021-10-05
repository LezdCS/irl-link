import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irl_link/Controller/HomeViewController.dart';
import 'package:irl_link/Widget/WebPageView.dart';
import 'package:irl_link/views/settingsView.dart';
import 'package:split_view/split_view.dart';

class HomeView extends GetView<HomeViewController> {
  final HomeViewController controller = Get.put(HomeViewController());

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
              child: SafeArea(
                child: SplitView(
                  controller: controller.splitViewController,
                  gripColor: Color(0xFF222f3e),
                  gripColorActive: Color(0xFF222f3e),
                  gripSize: 20,
                  viewMode: SplitViewMode.Vertical,
                  indicator: SplitIndicator(
                    viewMode: SplitViewMode.Vertical,
                    color: Color(0xFF8395a7),
                  ),
                  activeIndicator: SplitIndicator(
                    color: Color(0xFF8395a7),
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
              decoration: BoxDecoration(
                color: Color(0xFF222f3e),
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
        child: Row(
          children: [
            Container(
              width: width * 0.6,
              height: double.maxFinite,
              child: TextField(
                maxLines: 2,
                decoration: InputDecoration(
                  fillColor: Color(0xFF8395a7),
                  filled: true,
                  hintText: 'Chat (stream offline)',
                  isDense: true,
                  contentPadding: EdgeInsets.only(bottom: 40 / 2, left: 5),
                  border: new OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(0.0),
                    ),
                    borderSide: new BorderSide(
                      color: Colors.black,
                      width: 1.0,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              width: width * 0.2,
              height: double.maxFinite,
              child: InkWell(
                onTap: () {
                  controller.sound.value = !controller.sound.value;
                },
                child: Icon(
                  controller.sound.value ? Icons.volume_up : Icons.volume_off,
                  color:
                      controller.sound.value ? Colors.grey : Color(0xFFd63031),
                  size: 22,
                ),
              ),
              decoration: BoxDecoration(
                border: Border(
                  left: BorderSide(
                    color: Colors.black,
                    width: 3.0,
                  ),
                ),
              ),
            ),
            Container(
              width: width * 0.2,
              height: double.maxFinite,
              child: InkWell(
                onTap: () {
                  Get.to(SettingsView());
                },
                child: Icon(
                  Icons.settings,
                  color: Colors.grey,
                  size: 22,
                ),
              ),
              decoration: BoxDecoration(
                border: Border(
                  left: BorderSide(
                    color: Colors.black,
                    width: 3.0,
                  ),
                ),
              ),
            ),
          ],
        ),
        decoration: BoxDecoration(
          color: Color(0xFF222f3e),
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
            backgroundColor: Color(0xFF222f3e),
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
      padding: EdgeInsets.only(left: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Welcome to the lezd_ chat room!",
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
      decoration: BoxDecoration(
        color: Color(0xFF222f3e),
      ),
    );
  }
}
