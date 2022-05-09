import 'package:get/get.dart';
import 'package:base/models/building.model.dart';
import 'package:base/models/room.model.dart';

import 'room.detail.provider.dart';

class RoomDetailController extends GetxController {
  final RoomDetailProvider provider = RoomDetailProvider();
  final Rx<Room> room = Room().obs;
  String? roomId;
  Buildings? building;
  @override
  void onInit() {
    super.onInit();
    if (Get.arguments is List) {
      roomId = Get.arguments[0];

      building = Get.arguments[1];
    } else {
      roomId = Get.arguments;
    }
    getRoom();
  }

  void getRoom() async {
    var response = await provider.getRoom(roomId);

    if (response.isOk && response.body != null) {
      var roomModel = Room.fromJson(response.body['room']);

      room.value = roomModel;
    }
    update();
  }
}
