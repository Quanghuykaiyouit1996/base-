class Constant {
  static String baseUrl = 'https://api.dev.318.suplo.vn/v1';
  static String baseUrlNotApi = 'https://312.suplo.vn';
  static int countPopupShow = 0;

  static Future<void> init() async {
    // var dataFirebase = await FirebaseFirestore.instance
    //     .collection('setting')
    //     .doc('baseUrl')
    //     .get();
    // if (dataFirebase.exists &&
    //     dataFirebase.data() != null &&
    //     dataFirebase.data()?['baseUrl'] != null) {
    //   var string = dataFirebase.data()?['baseUrl'];
    //   baseUrlNotApi = string;
    //   baseUrl = '$string/api';
    // }
  }
}

enum TypeService { fortune, all, service, device, rule }

extension TypeServiceExtention on TypeService {
  toShortString() {
    switch (this) {
      case TypeService.fortune:
        return 'Tài sản';
      case TypeService.all:
        return 'Tất cả';
      case TypeService.device:
        return 'Thiết bị';
      case TypeService.rule:
        return 'Nội quy';
      case TypeService.service:
        return 'Dịch vụ';
      default:
        return '';
    }
  }
}
