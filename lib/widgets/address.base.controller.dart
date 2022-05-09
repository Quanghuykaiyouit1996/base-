import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_admin/address.provider.dart';
import 'package:mobile_admin/cored/auth/auth.controller.dart';
import 'package:mobile_admin/models/address.model.dart';

class AddressBaseController extends GetxController {
  AddressModel? addressModel;
  bool? isFirstTime;

  List<CityModel>? provinces = [];
  List<WardModel>? wards = [];
  List<DistrictModel>? districts = [];
  TextEditingController? cityTextController;
  TextEditingController? districtTextController;

  TextEditingController? wardTextController;
  TextEditingController? addressController;

  AddressBaseController({required this.addressModel});

  final Rx<LocationDetail> _city = CityModel().obs;

  final Rx<LocationDetail> _district = DistrictModel().obs;

  final Rx<LocationDetail> _ward = WardModel().obs;

  late RxBool isSetDefult;
  AuthController authController = Get.find(tag: 'authController');

  Rx<LocationDetail> get city => _city;
  Rx<LocationDetail> get district => _district;
  Rx<LocationDetail> get ward => _ward;
  String? Function(String value) get validateCityAddress => (String value) {
        if (value.isEmpty
            // &&
            //     addressController!.text.isEmpty &&
            //     districtTextController!.text.isEmpty &&
            //     wardTextController!.text.isEmpty
            ) {
          return 'Hãy thêm thành phố';
        }
        return null;
      };

  String? Function(String value) get validateDistrictAddress => (String value) {
        if (value.isEmpty
            //  &&
            //     addressController!.text.isEmpty &&
            //     cityTextController!.text.isEmpty &&
            //     wardTextController!.text.isEmpty
            ) {
          return 'Hãy thêm quận huyện';
        }
        return null;
      };

  String? Function(String value) get validateWardAddress => (String value) {
        if (value.isEmpty
            // &&
            //     addressController!.text.isEmpty &&
            //     districtTextController!.text.isEmpty &&
            //     cityTextController!.text.isEmpty
            ) {
          return 'Hãy thêm phường xã';
        }
        return null;
      };

  String? Function(String value) get validateAddress => (String value) {
        if (value.isEmpty
            // &&
            //     wardTextController!.text.isEmpty &&
            //     districtTextController!.text.isEmpty &&
            //     cityTextController!.text.isEmpty
            ) {
          return 'Hãy thêm ít nhất một trường địa chỉ';
        }
        return null;
      };

  @override
  void onInit() async {
    super.onInit();
    cityTextController ??= TextEditingController();
    districtTextController ??= TextEditingController();
    wardTextController ??= TextEditingController();
    addressController ??= TextEditingController();
  }

  @override
  void dispose() {
    cityTextController?.dispose();
    districtTextController?.dispose();
    addressController?.dispose();
    wardTextController?.dispose();
    super.dispose();
  }

  @override
  void onClose() {
    cityTextController?.text = '';
    districtTextController?.text = '';
    addressController?.text = '';
    wardTextController?.text = '';
    super.onClose();
  }

  void init(AddressModel value) async {
    resetData();
    addressModel = value;
    addressController ??= TextEditingController();
    addressController!.text = addressModel?.address1 ?? '';
    if (addressModel?.isDefault ?? true) {
      isSetDefult = true.obs;
    } else {
      isSetDefult = false.obs;
    }
    await getAll();
  }

  Future<void> getAll() async {
    await getAllCity();
    if (addressModel?.city != null) {
      _city.value = addressModel?.city ?? CityModel();

      await findDistricts(addressModel?.city ?? CityModel());
      if (addressModel?.district != null) {
        await findWards(addressModel?.district ?? DistrictModel());
      }
    }
    isFirstTime = false;
    update();
  }

  Future<void> getAllCity() async {
    var addressProvider = AddressProvider();
    var response = await addressProvider.getCity();
    if (response.isOk && response.body != null) {
      if (response.body is Map) {
        provinces?.clear();
        provinces?.addAll(CitiesModel.fromJson(response.body).cities ?? []);
      }
    }
  }

  Future<void> findDistricts(CityModel city) async {
    _city.value = city;
    updateAddress(city.name ?? '');

    var addressProvider = AddressProvider();
    var response = await addressProvider.getDistrict(city.id);
    if (response.isOk && response.body != null) {
      if (response.body is Map) {
        districts?.clear();
        districts
            ?.addAll(DistrictsModel.fromJson(response.body).districts ?? []);
        _district.value = isFirstTime!
            ? (addressModel?.district ?? DistrictModel())
            : DistrictModel();
        _ward.value =
            isFirstTime! ? (addressModel?.ward ?? WardModel()) : WardModel();
      }
    }
    update();
  }

  Future<void> findWards(DistrictModel district) async {
    _district.value = district;
    var addressProvider = AddressProvider();
    var response = await addressProvider.getWard(district.id);
    if (response.isOk && response.body != null) {
      if (response.body is Map) {
        wards?.clear();
        wards?.addAll(WardsModel.fromJson(response.body).wards ?? []);
        _ward.value =
            isFirstTime! ? (addressModel?.ward ?? WardModel()) : WardModel();
      }
    }
    update();
  }

  Future<void> chooseWard(WardModel wardModel) async {
    _ward.value = wardModel;
  }

  void resetData() {
    _city.value = CityModel();

    _district.value = DistrictModel();

    _ward.value = WardModel();
    isFirstTime = true;
  }

  void updateAddress(String s) {
    cityTextController?.text = s;
    districtTextController?.text = s;
    wardTextController?.text = wardTextController?.text ?? '';
  }
}
