import 'package:json_annotation/json_annotation.dart';

part 'address.model.g.dart';

@JsonSerializable(explicitToJson: true)
class ListAddressModel {
  @JsonKey(name: 'results')
  List<AddressModel>? addresses;
  int? count;

  ListAddressModel({this.addresses});

  factory ListAddressModel.fromJson(Map<String, dynamic> data) =>
      _$ListAddressModelFromJson(data);

  Map<String, dynamic> toJson() => _$ListAddressModelToJson(this);
}

@JsonSerializable(explicitToJson: true, includeIfNull: true)
class AddressModel {
  String? id;
  String? createdAt;
  String? updatedAt;
  @JsonKey(name: 'default')
  bool? isDefault;
  @JsonKey(name: 'name')
  String? firstName;
  String? lastName;
  @JsonKey(name: 'address1')
  String? address1;
  @JsonKey(name: 'address2')
  String? address2;
  @JsonKey(name: 'phone')
  String? phoneNumber;
  @JsonKey(name: 'comment')
  String? note;
  @JsonKey(name: 'email')
  String? email;
  @JsonKey(name: 'district')
  DistrictModel? district;
  @JsonKey(name: 'city')
  CityModel? city;
  @JsonKey(name: 'ward')
  WardModel? ward;
  bool? selected;

  AddressModel(
      {this.id,
      this.createdAt,
      this.updatedAt,
      this.isDefault,
      this.firstName,
      this.lastName,
      this.address1,
      this.address2,
      this.email,
      this.phoneNumber,
      this.note,
      this.city,
      this.district,
      this.ward,
      this.selected});

  factory AddressModel.fromJson(Map<String, dynamic> data) =>
      _$AddressModelFromJson(data);

  Map<String, dynamic> toJson() => _$AddressModelToJson(this);

  AddressModel copyWith({
    String? id,
    String? createdAt,
    String? updatedAt,
    bool? isDefault,
    String? firstName,
    String? lastName,
    String? address1,
    String? address2,
    String? phoneNumber,
    String? note,
    String? vat,
    String? vatName,
    String? email,
    DistrictModel? district,
    CityModel? city,
    WardModel? ward,
    double? longitude,
    double? latitude,
    bool? selected,
  }) {
    return AddressModel(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isDefault: isDefault ?? this.isDefault,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      district: district ?? this.district,
      city: city ?? this.city,
      ward: ward ?? this.ward,
      email: email ?? this.email,
      address1: address1 ?? this.address1,
      address2: address2 ?? this.address2,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      note: note ?? this.note,
      selected: selected ?? this.selected,
    );
  }
}

@JsonSerializable(explicitToJson: true)
class AddressRequestModel {
  AddressDetailRequestModel? address;

  AddressRequestModel({this.address});

  factory AddressRequestModel.fromJson(Map<String, dynamic> data) =>
      _$AddressRequestModelFromJson(data);

  Map<String, dynamic> toJson() => _$AddressRequestModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class AddressDetailRequestModel {
  String? phoneNumber;
  String? firstName;
  String? lastName;
  String? note;
  String? address1;
  String? address2;
  String? districtName;
  String? cityName;
  int? districtId;
  int? cityId;
  bool? isDefault;
  double? latitude;
  double? longitude;

  AddressDetailRequestModel(
      {this.phoneNumber,
      this.firstName,
      this.lastName,
      this.note,
      this.address1,
      this.address2,
      this.districtName,
      this.cityName,
      this.districtId,
      this.cityId,
      this.isDefault,
      this.latitude,
      this.longitude});

  factory AddressDetailRequestModel.fromJson(Map<String, dynamic> data) =>
      _$AddressDetailRequestModelFromJson(data);

  Map<String, dynamic> toJson() => _$AddressDetailRequestModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class AddressResponseModel {
  AddressDetailResponseModel? address;
  String? error;

  AddressResponseModel({this.address, this.error});

  factory AddressResponseModel.fromJson(Map<String, dynamic> data) =>
      _$AddressResponseModelFromJson(data);

  Map<String, dynamic> toJson() => _$AddressResponseModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class AddressDetailResponseModel {
  bool? isDefault;
  String? address1;
  String? phoneNumber;
  int? districtId;
  String? districtName;
  int? cityId;
  String? cityName;
  Owner? owner;
  String? firstName;
  String? lastName;
  String? address2;
  String? note;
  String? haravanId;
  String? sourceId;
  String? id;
  String? createdAt;
  String? updatedAt;
  double? latitude;
  double? longitude;

  AddressDetailResponseModel(
      {this.isDefault,
      this.address1,
      this.phoneNumber,
      this.districtId,
      this.districtName,
      this.cityId,
      this.cityName,
      this.owner,
      this.firstName,
      this.lastName,
      this.address2,
      this.note,
      this.haravanId,
      this.sourceId,
      this.id,
      this.createdAt,
      this.updatedAt,
      this.latitude,
      this.longitude});

  factory AddressDetailResponseModel.fromJson(Map<String, dynamic> data) =>
      _$AddressDetailResponseModelFromJson(data);

  Map<String, dynamic> toJson() => _$AddressDetailResponseModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Owner {
  String? id;

  Owner({this.id});

  factory Owner.fromJson(Map<String, dynamic> data) => _$OwnerFromJson(data);

  Map<String, dynamic> toJson() => _$OwnerToJson(this);
}

@JsonSerializable(explicitToJson: true)
class LocationDetail {
  int? id;
  String? name;
}

@JsonSerializable(explicitToJson: true)
class CountriesModel {
  @JsonKey(name: 'results')
  List<CountryModel>? countries;

  CountriesModel({this.countries});

  factory CountriesModel.fromJson(Map<String, dynamic> data) =>
      _$CountriesModelFromJson(data);

  Map<String, dynamic> toJson() => _$CountriesModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class CountryModel extends LocationDetail {
  @override
  int? id;
  @override
  String? name;

  CountryModel({this.id, this.name});

  factory CountryModel.fromJson(Map<String, dynamic> data) =>
      _$CountryModelFromJson(data);

  Map<String, dynamic> toJson() => _$CountryModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class CitiesModel {
  @JsonKey(name: 'cities')
  List<CityModel>? cities;

  CitiesModel({this.cities});

  factory CitiesModel.fromJson(Map<String, dynamic> data) =>
      _$CitiesModelFromJson(data);

  Map<String, dynamic> toJson() => _$CitiesModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class CityModel extends LocationDetail {
  @override
  int? id;
  String? provinceCode;
  @override
  String? name;

  CityModel({this.id, this.provinceCode, this.name});

  factory CityModel.fromJson(Map<String, dynamic> data) =>
      _$CityModelFromJson(data);

  Map<String, dynamic> toJson() => _$CityModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class DistrictsModel {
  @JsonKey(name: 'districts')
  List<DistrictModel>? districts;

  DistrictsModel({this.districts});
  factory DistrictsModel.fromJson(Map<String, dynamic> data) =>
      _$DistrictsModelFromJson(data);

  Map<String, dynamic> toJson() => _$DistrictsModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class DistrictModel extends LocationDetail {
  @override
  int? id;
  String? code;
  @override
  String? name;

  DistrictModel({this.id, this.code, this.name});
  factory DistrictModel.fromJson(Map<String, dynamic> data) =>
      _$DistrictModelFromJson(data);

  Map<String, dynamic> toJson() => _$DistrictModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class WardsModel {
  @JsonKey(name: 'wards')
  List<WardModel>? wards;

  WardsModel({this.wards});

  factory WardsModel.fromJson(Map<String, dynamic> data) =>
      _$WardsModelFromJson(data);

  Map<String, dynamic> toJson() => _$WardsModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class WardModel extends LocationDetail {
  @override
  int? id;
  String? provinceCode;
  @override
  String? name;

  WardModel({this.id, this.provinceCode, this.name});

  factory WardModel.fromJson(Map<String, dynamic> data) =>
      _$WardModelFromJson(data);

  Map<String, dynamic> toJson() => _$WardModelToJson(this);
}
