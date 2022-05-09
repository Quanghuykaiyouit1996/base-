import 'package:get/get.dart';
import 'package:base/cored/buildings/info/components/roomInfo/room.provide.dart';
import 'package:base/models/room.model.dart';

import '../../building.info.controller.dart';

class RoomInfoController extends GetxController {
  RoomInfoController();
  final RoomProvider provider = RoomProvider();
  final List<Room> rooms = <Room>[].obs;
  final buildingController = Get.put(BuildingsInfoController());

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getListRoom();
  }

  Future<void> getListRoom() async {
    var response = await provider.getAllRoom(buildingController.buildingId);
    rooms.clear();
    if (response.isOk && response.body != null) {
      var model = RoomModel.fromJson(response.body);
      rooms.addAll(model.rooms ?? []);
    } else {
      print(response.body);
    }
  }
}
