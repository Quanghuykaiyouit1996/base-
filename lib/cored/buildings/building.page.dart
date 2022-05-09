import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:base/config/pages/app.page.dart';
import 'package:base/models/building.model.dart';
import 'package:base/utils/helpes/utilities.dart';
import 'package:base/utils/icon/custom.icon.dart';
import 'package:base/widgets/address.base.controller.dart';
import 'package:base/widgets/button.widget.dart';
import 'package:base/widgets/custom.list.dart';
import 'package:base/widgets/image.product.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'building.controller.dart';
import 'components/address.filter.dart';

class BuildingPage extends StatefulWidget {
  const BuildingPage({Key? key}) : super(key: key);

  @override
  State<BuildingPage> createState() => _BuildingPageState();
}

class _BuildingPageState extends State<BuildingPage>
    with TickerProviderStateMixin {
  final controller = Get.put(BuildingController());

  late AnimationController controllerAnimate;
  late final Animation<double> opacity;
  late final Animation<double> position;
  late final Animation<double> height;

  Future<void> _playAnimation() async {
    try {
      if (controllerAnimate.isCompleted) {
        await controllerAnimate.reverse().orCancel;
      } else {
        await controllerAnimate.forward().orCancel;
      }
    } on TickerCanceled {
      // the animation got canceled, probably because it was disposed of
    }
  }

  @override
  void initState() {
    super.initState();
    controllerAnimate = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    opacity = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: controllerAnimate,
        curve: const Interval(
          0.0,
          0.5,
          curve: Curves.ease,
        ),
      ),
    );

    position = Tween<double>(
      begin: -170.0,
      end: 0,
    ).animate(
      CurvedAnimation(
        parent: controllerAnimate,
        curve: const Interval(
          0.5,
          1,
          curve: Curves.ease,
        ),
      ),
    );
    height = Tween<double>(
      begin: 0,
      end: double.infinity,
    ).animate(
      CurvedAnimation(
        parent: controllerAnimate,
        curve: const Interval(
          0,
          0,
          curve: Curves.ease,
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFF5F8FD),
        actions: [
          IconButton(
            icon: const Icon(
              MyFlutterApp.plus,
              color: Color(0xFF00A79E),
            ),
            onPressed: () {
              Get.toNamed(Routes.EDITANDADDBUILDING);
            },
          )
        ],
        title: const Text('Quản lý nhà'),
        centerTitle: true,
        bottom: PreferredSize(
            preferredSize: const Size.fromHeight(kToolbarHeight * 7 / 8),
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                _playAnimation();
              },
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15.0, vertical: 12),
                child: Obx(() => Row(
                      children: [
                        Icon(MyFlutterApp.ic_address,
                            color: controller.address.value.isEmpty
                                ? const Color(0xFF9D9BC9)
                                : const Color(0xFFFDB913)),
                        const SizedBox(width: 16),
                        Text(
                          controller.address.value.isEmpty
                              ? 'Nhấn để chọn khu vực'
                              : controller.address.value,
                          style: TextStyle(
                              color: controller.address.value.isEmpty
                                  ? const Color(0xFF9D9BC9)
                                  : const Color(0xFFFDB913),
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              height: 16 / 14),
                        )
                      ],
                    )),
              ),
            )),
      ),
      body: Stack(
        children: [
          StreamBuilder<bool>(
              stream: Utilities.streamIsLoading.stream,
              builder: (context, snapshot) {
                if (snapshot.data ?? false) {
                  return const SizedBox.shrink();
                }
                return Obx(() => controller.buildings.isEmpty
                    ? const Center(child: Text('Không có dữ liệu'))
                    : RefreshIndicator(
                        onRefresh: () async {
                          controller.getBuilding();
                        },
                        child: CustomList(
                          heightItem: 101,
                          scrollController: controller.controller,
                          scrollPhysics: const BouncingScrollPhysics(
                              parent: AlwaysScrollableScrollPhysics()),
                          widthItem: Get.size.width,
                          itemCount: controller.buildings.length,
                          onClickItem: (index) {
                            Get.toNamed(Routes.BUILDING_INFO,
                                arguments: controller.buildings[index].id);
                          },
                          padding: const EdgeInsets.only(bottom: 16),
                          customWidget: (index) {
                            return Column(
                              children: [
                                Expanded(
                                    child: ChildBuilding(
                                        building: controller.buildings[index])),
                                const Divider(
                                  height: 1,
                                ),
                              ],
                            );
                          },
                        ),
                      ));
              }),
          AnimatedBuilder(
            builder: (context, child) {
              return Opacity(
                  opacity: opacity.value,
                  child: Center(
                      child: Container(
                          height: height.value,
                          alignment: Alignment.topCenter,
                          color: Colors.black.withOpacity(0.8),
                          child: Stack(
                            children: [
                              Positioned.fill(child: GestureDetector(
                                onTap: () {
                                  _playAnimation();
                                },
                              )),
                              Positioned(
                                top: position.value,
                                left: 0,
                                child: AddressFilter(
                                    actionAnimation: _playAnimation),
                              ),
                            ],
                          ))));
            },
            animation: controllerAnimate,
          )
        ],
      ),
    );
  }
}

class AddressFilter extends StatelessWidget {
  final controller = Get.find<BuildingController>();
  final Function actionAnimation;
  AddressFilter({Key? key, required this.actionAnimation}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: Get.size.width,
        color: const Color(0xFFF5F5F5),
        height: 170,
        child: AddressFilterBuilding(
            controller: controller.addressBaseController,
            actionAnimation: actionAnimation));
  }
}

class ChildBuilding extends StatelessWidget {
  final Buildings building;

  const ChildBuilding({Key? key, required this.building}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          ImageProductInRow(
              imageUrl: building.images
                  ?.firstWhere((element) => element.source != null,
                      orElse: () => BuildingImage(source: ''))
                  .source,
              onTopImage: Positioned(
                left: 0,
                bottom: 0,
                height: 20,
                child: Container(
                    width: 100 - 16,
                    color: building.isAvaiable ? Colors.green : Colors.red,
                    padding: const EdgeInsets.symmetric(vertical: 1),
                    alignment: Alignment.center,
                    child: Text(building.isAvaiable ? '5/10' : '10/10',
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            height: 12 / 10,
                            fontSize: 10))),
              )),
          const SizedBox(
            width: 8,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(building.name ?? '',
                    style: const TextStyle(
                        color: Color(0xFF16154E), fontSize: 12)),
                const SizedBox(
                  height: 4,
                ),
                Text(Utilities.getAddress(building.address),
                    style: const TextStyle(
                        color: Color(0xFF16154E), fontSize: 10)),
              ],
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          const Icon(
            MyFlutterApp.right_open,
            color: Color(0xFF9D9BC9),
          )
        ],
      ),
    );
  }
}
