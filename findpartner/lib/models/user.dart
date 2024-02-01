import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:findpartner/models/sexual_orientation_type.dart';
import 'package:findpartner/models/sexual_practice_type.dart';
import 'package:findpartner/models/sexual_preference_type.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class UserModel {
  String? username;
  String? email;
  String? photoUrl;
  String? country;
  String? bio;
  String? id;
  Timestamp? signedUpAt;
  Timestamp? lastSeen;
  bool? isOnline;
  bool? isCouple;
  bool? isSingle;
  List<String>? albumPublic;
  List<String>? albumPrivate;
  List<UserModel>? bannedUsers;
  List<UserModel>? preferredUsers;
  List<SexualPracticeType>? acceptedSexualPracticeTypes;
  List<SexualPracticeType>? refusedSexualPracticeTypes;
  List<SexualPracticeType>? feelingAcceptedsexualPracticeTypes;
  List<SexualPreferenceType>? acceptedSexualPreferenceTypes;
  List<SexualPreferenceType>? refusedSexualPreferenceTypes;
  List<SexualPreferenceType>? sexualPreferenceTypes;
  List<SexualOrientationType>? sexualOrientationTypes;
  String? displayName;
  String? phoneNumber;
  String? gender;
  String? website;
  num? totalFollowers;
  num? totalFollowing;
  num? totalPosts;
  num? totalFlashes;
  String? theme;
  String? language;
  String? countryCode;
  String? postalAdress;
  String? city;
  double? latitude;
  double? longitude;

  UserModel({
    this.username,
    this.email,
    this.id,
    this.photoUrl,
    this.signedUpAt,
    this.isOnline,
    this.isCouple,
    this.isSingle,
    this.lastSeen,
    this.bio,
    this.country,
    this.albumPublic,
    this.albumPrivate,
    this.bannedUsers,
    this.preferredUsers,
    this.acceptedSexualPracticeTypes,
    this.refusedSexualPracticeTypes,
    this.feelingAcceptedsexualPracticeTypes,
    this.acceptedSexualPreferenceTypes,
    this.refusedSexualPreferenceTypes,
    this.sexualPreferenceTypes,
    this.sexualOrientationTypes,
    this.displayName,
    this.phoneNumber,
    this.gender,
    this.website,
    this.totalFollowers,
    this.totalFollowing,
    this.totalPosts,
    this.totalFlashes,
    this.theme,
    this.language,
    this.countryCode,
    this.postalAdress,
    this.city,
    this.latitude,
    this.longitude,
  });

  Future<void> updateLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark placemark = placemarks.first;
    country = placemark.country;
    postalAdress = placemark.postalCode;
    city = placemark.locality;
    latitude = position.latitude;
    longitude = position.longitude;
  }

  UserModel.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    email = json['email'];
    country = json['country'];
    photoUrl = json['photoUrl'];
    signedUpAt = json['signedUpAt'];
    isOnline = json['isOnline'];
    isCouple = json['isCouple'];
    isSingle = json['isSingle'];
    lastSeen = json['lastSeen'];
    bio = json['bio'];
    id = json['id'];
    displayName = json['displayName'];
    phoneNumber = json['phoneNumber'];
    gender = json['gender'];
    website = json['website'];
    totalFollowers = json['totalFollowers'];
    totalFollowing = json['totalFollowing'];
    totalPosts = json['totalPosts'];
    totalFlashes = json['totalFlashes'];
    theme = json['theme'];
    language = json['language'];
    countryCode = json['countryCode'];
    postalAdress = json['postalAdress'];
    city = json['city'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    albumPublic = List<String>.from(json['albumPublic'] ?? []);
    albumPrivate = List<String>.from(json['albumPrivate'] ?? []);
    bannedUsers = json['bannedUsers'] != null
        ? List<UserModel>.from(
            json['bannedUsers'].map((x) => UserModel.fromJson(x)))
        : [];
    preferredUsers = json['preferredUsers'] != null
        ? List<UserModel>.from(
            json['preferredUsers'].map((x) => UserModel.fromJson(x)))
        : [];
    acceptedSexualPracticeTypes = json['acceptedSexualPracticeTypes'] != null
        ? List<SexualPracticeType>.from(json['acceptedSexualPracticeTypes']
            .map((x) => SexualPracticeType.values[x]))
        : [];
    refusedSexualPracticeTypes = json['refusedSexualPracticeTypes'] != null
        ? List<SexualPracticeType>.from(json['refusedSexualPracticeTypes']
            .map((x) => SexualPracticeType.values[x]))
        : [];
    feelingAcceptedsexualPracticeTypes =
        json['feelingAcceptedsexualPracticeTypes'] != null
            ? List<SexualPracticeType>.from(
                json['feelingAcceptedsexualPracticeTypes']
                    .map((x) => SexualPracticeType.values[x]))
            : [];
    acceptedSexualPreferenceTypes = json['acceptedSexualPreferenceTypes'] !=
            null
        ? List<SexualPreferenceType>.from(json['acceptedSexualPreferenceTypes']
            .map((x) => SexualPreferenceType.values[x]))
        : [];
    refusedSexualPreferenceTypes = json['refusedSexualPreferenceTypes'] != null
        ? List<SexualPreferenceType>.from(json['refusedSexualPreferenceTypes']
            .map((x) => SexualPreferenceType.values[x]))
        : [];
    sexualPreferenceTypes = json['sexualPreferenceTypes'] != null
        ? List<SexualPreferenceType>.from(json['sexualPreferenceTypes']
            .map((x) => SexualPreferenceType.values[x]))
        : [];
    sexualOrientationTypes = json['sexualOrientationTypes'] != null
        ? List<SexualOrientationType>.from(json['sexualOrientationTypes']
            .map((x) => SexualOrientationType.values[x]))
        : [];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = username;
    data['country'] = country;
    data['email'] = email;
    data['photoUrl'] = photoUrl;
    data['bio'] = bio;
    data['signedUpAt'] = signedUpAt;
    data['isOnline'] = isOnline;
    data['isCouple'] = isCouple;
    data['isSingle'] = isSingle;
    data['lastSeen'] = lastSeen;
    data['id'] = id;
    data['displayName'] = displayName;
    data['phoneNumber'] = phoneNumber;
    data['gender'] = gender;
    data['website'] = website;
    data['totalFollowers'] = totalFollowers;
    data['totalFollowing'] = totalFollowing;
    data['totalPosts'] = totalPosts;
    data['totalFlashes'] = totalFlashes;
    data['theme'] = theme;
    data['language'] = language;
    data['countryCode'] = countryCode;
    data['postalAdress'] = postalAdress;
    data['city'] = city;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['albumPublic'] = albumPublic;
    data['albumPrivate'] = albumPrivate;
    data['bannedUsers'] = bannedUsers!.map((user) => user.toJson()).toList();
    data['preferredUsers'] =
        preferredUsers!.map((user) => user.toJson()).toList();
    data['acceptedSexualPracticeTypes'] =
        acceptedSexualPracticeTypes!.map((e) => e.index).toList();
    data['refusedSexualPracticeTypes'] =
        refusedSexualPracticeTypes!.map((e) => e.index).toList();
    data['feelingAcceptedsexualPracticeTypes'] =
        feelingAcceptedsexualPracticeTypes!.map((e) => e.index).toList();
    data['acceptedSexualPreferenceTypes'] =
        acceptedSexualPreferenceTypes!.map((e) => e.index).toList();
    data['refusedSexualPreferenceTypes'] =
        refusedSexualPreferenceTypes!.map((e) => e.index).toList();
    data['sexualPreferenceTypes'] =
        sexualPreferenceTypes!.map((e) => e.index).toList();
    data['sexualOrientationTypes'] =
        sexualOrientationTypes!.map((e) => e.index).toList();
    return data;
  }
}
