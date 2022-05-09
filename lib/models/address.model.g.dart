// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListAddressModel _$ListAddressModelFromJson(Map<String, dynamic> json) {
  return ListAddressModel(
    addresses: (json['results'] as List<dynamic>?)
        ?.map((e) => AddressModel.fromJson(e as Map<String, dynamic>))
        .toList(),
  )..count = json['count'] as int?;
}

Map<String, dynamic> _$ListAddressModelToJson(ListAddressModel instance) =>
    <String, dynamic>{
      'results': instance.addresses?.map((e) => e.toJson()).toList(),
      'count': instance.count,
    };

AddressModel _$AddressModelFromJson(Map<String, dynamic> json) {
  return AddressModel(
    id: json['id'] as String?,
    createdAt: json['createdAt'] as String?,
    updatedAt: json['updatedAt'] as String?,
    isDefault: json['default'] as bool?,
    firstName: json['name'] as String?,
    lastName: json['lastName'] as String?,
    address1: json['address1'] as String?,
    address2: json['address2'] as String?,
    email: json['email'] as String?,
    phoneNumber: json['phone'] as String?,
    note: json['comment'] as String?,
    city: json['city'] == null
        ? null
        : CityModel.fromJson(json['city'] as Map<String, dynamic>),
    district: json['district'] == null
        ? null
        : DistrictModel.fromJson(json['district'] as Map<String, dynamic>),
    ward: json['ward'] == null
        ? null
        : WardModel.fromJson(json['ward'] as Map<String, dynamic>),
    selected: json['selected'] as bool?,
  );
}

Map<String, dynamic> _$AddressModelToJson(AddressModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'default': instance.isDefault,
      'name': instance.firstName,
      'lastName': instance.lastName,
      'address1': instance.address1,
      'address2': instance.address2,
      'phone': instance.phoneNumber,
      'comment': instance.note,
      'email': instance.email,
      'district': instance.district?.toJson(),
      'city': instance.city?.toJson(),
      'ward': instance.ward?.toJson(),
      'selected': instance.selected,
    };

AddressRequestModel _$AddressRequestModelFromJson(Map<String, dynamic> json) {
  return AddressRequestModel(
    address: json['address'] == null
        ? null
        : AddressDetailRequestModel.fromJson(
            json['address'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$AddressRequestModelToJson(
        AddressRequestModel instance) =>
    <String, dynamic>{
      'address': instance.address?.toJson(),
    };

AddressDetailRequestModel _$AddressDetailRequestModelFromJson(
    Map<String, dynamic> json) {
  return AddressDetailRequestModel(
    phoneNumber: json['phoneNumber'] as String?,
    firstName: json['firstName'] as String?,
    lastName: json['lastName'] as String?,
    note: json['note'] as String?,
    address1: json['address1'] as String?,
    address2: json['address2'] as String?,
    districtName: json['districtName'] as String?,
    cityName: json['cityName'] as String?,
    districtId: json['districtId'] as int?,
    cityId: json['cityId'] as int?,
    isDefault: json['isDefault'] as bool?,
    latitude: (json['latitude'] as num?)?.toDouble(),
    longitude: (json['longitude'] as num?)?.toDouble(),
  );
}

Map<String, dynamic> _$AddressDetailRequestModelToJson(
        AddressDetailRequestModel instance) =>
    <String, dynamic>{
      'phoneNumber': instance.phoneNumber,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'note': instance.note,
      'address1': instance.address1,
      'address2': instance.address2,
      'districtName': instance.districtName,
      'cityName': instance.cityName,
      'districtId': instance.districtId,
      'cityId': instance.cityId,
      'isDefault': instance.isDefault,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };

AddressResponseModel _$AddressResponseModelFromJson(Map<String, dynamic> json) {
  return AddressResponseModel(
    address: json['address'] == null
        ? null
        : AddressDetailResponseModel.fromJson(
            json['address'] as Map<String, dynamic>),
    error: json['error'] as String?,
  );
}

Map<String, dynamic> _$AddressResponseModelToJson(
        AddressResponseModel instance) =>
    <String, dynamic>{
      'address': instance.address?.toJson(),
      'error': instance.error,
    };

AddressDetailResponseModel _$AddressDetailResponseModelFromJson(
    Map<String, dynamic> json) {
  return AddressDetailResponseModel(
    isDefault: json['isDefault'] as bool?,
    address1: json['address1'] as String?,
    phoneNumber: json['phoneNumber'] as String?,
    districtId: json['districtId'] as int?,
    districtName: json['districtName'] as String?,
    cityId: json['cityId'] as int?,
    cityName: json['cityName'] as String?,
    owner: json['owner'] == null
        ? null
        : Owner.fromJson(json['owner'] as Map<String, dynamic>),
    firstName: json['firstName'] as String?,
    lastName: json['lastName'] as String?,
    address2: json['address2'] as String?,
    note: json['note'] as String?,
    haravanId: json['haravanId'] as String?,
    sourceId: json['sourceId'] as String?,
    id: json['id'] as String?,
    createdAt: json['createdAt'] as String?,
    updatedAt: json['updatedAt'] as String?,
    latitude: (json['latitude'] as num?)?.toDouble(),
    longitude: (json['longitude'] as num?)?.toDouble(),
  );
}

Map<String, dynamic> _$AddressDetailResponseModelToJson(
        AddressDetailResponseModel instance) =>
    <String, dynamic>{
      'isDefault': instance.isDefault,
      'address1': instance.address1,
      'phoneNumber': instance.phoneNumber,
      'districtId': instance.districtId,
      'districtName': instance.districtName,
      'cityId': instance.cityId,
      'cityName': instance.cityName,
      'owner': instance.owner?.toJson(),
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'address2': instance.address2,
      'note': instance.note,
      'haravanId': instance.haravanId,
      'sourceId': instance.sourceId,
      'id': instance.id,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };

Owner _$OwnerFromJson(Map<String, dynamic> json) {
  return Owner(
    id: json['id'] as String?,
  );
}

Map<String, dynamic> _$OwnerToJson(Owner instance) => <String, dynamic>{
      'id': instance.id,
    };

LocationDetail _$LocationDetailFromJson(Map<String, dynamic> json) {
  return LocationDetail()
    ..id = json['id'] as int?
    ..name = json['name'] as String?;
}

Map<String, dynamic> _$LocationDetailToJson(LocationDetail instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };

CountriesModel _$CountriesModelFromJson(Map<String, dynamic> json) {
  return CountriesModel(
    countries: (json['results'] as List<dynamic>?)
        ?.map((e) => CountryModel.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$CountriesModelToJson(CountriesModel instance) =>
    <String, dynamic>{
      'results': instance.countries?.map((e) => e.toJson()).toList(),
    };

CountryModel _$CountryModelFromJson(Map<String, dynamic> json) {
  return CountryModel(
    id: json['id'] as int?,
    name: json['name'] as String?,
  );
}

Map<String, dynamic> _$CountryModelToJson(CountryModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };

CitiesModel _$CitiesModelFromJson(Map<String, dynamic> json) {
  return CitiesModel(
    cities: (json['cities'] as List<dynamic>?)
        ?.map((e) => CityModel.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$CitiesModelToJson(CitiesModel instance) =>
    <String, dynamic>{
      'cities': instance.cities?.map((e) => e.toJson()).toList(),
    };

CityModel _$CityModelFromJson(Map<String, dynamic> json) {
  return CityModel(
    id: json['id'] as int?,
    provinceCode: json['provinceCode'] as String?,
    name: json['name'] as String?,
  );
}

Map<String, dynamic> _$CityModelToJson(CityModel instance) => <String, dynamic>{
      'id': instance.id,
      'provinceCode': instance.provinceCode,
      'name': instance.name,
    };

DistrictsModel _$DistrictsModelFromJson(Map<String, dynamic> json) {
  return DistrictsModel(
    districts: (json['districts'] as List<dynamic>?)
        ?.map((e) => DistrictModel.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$DistrictsModelToJson(DistrictsModel instance) =>
    <String, dynamic>{
      'districts': instance.districts?.map((e) => e.toJson()).toList(),
    };

DistrictModel _$DistrictModelFromJson(Map<String, dynamic> json) {
  return DistrictModel(
    id: json['id'] as int?,
    code: json['code'] as String?,
    name: json['name'] as String?,
  );
}

Map<String, dynamic> _$DistrictModelToJson(DistrictModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'name': instance.name,
    };

WardsModel _$WardsModelFromJson(Map<String, dynamic> json) {
  return WardsModel(
    wards: (json['wards'] as List<dynamic>?)
        ?.map((e) => WardModel.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$WardsModelToJson(WardsModel instance) =>
    <String, dynamic>{
      'wards': instance.wards?.map((e) => e.toJson()).toList(),
    };

WardModel _$WardModelFromJson(Map<String, dynamic> json) {
  return WardModel(
    id: json['id'] as int?,
    provinceCode: json['provinceCode'] as String?,
    name: json['name'] as String?,
  );
}

Map<String, dynamic> _$WardModelToJson(WardModel instance) => <String, dynamic>{
      'id': instance.id,
      'provinceCode': instance.provinceCode,
      'name': instance.name,
    };
