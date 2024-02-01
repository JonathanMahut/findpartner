import 'dart:io';

import 'package:findpartner/models/status.dart';
import 'package:findpartner/posts/story/confrim_status.dart';
import 'package:findpartner/services/status_services.dart';
import 'package:findpartner/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class StatusViewModel extends ChangeNotifier {
  // Services
  final StatusService statusService = StatusService();

  // Keys
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // Variables
  bool loading = false;
  String? username;
  File? mediaUrl;
  final picker = ImagePicker();
  String? description;
  String? email;
  String? userDp;
  String? userId;
  String? imgLink;
  bool edit = false;
  String? id;

  // Functions
  void setDescription(String val) {
    print('SetDescription $val');
    description = val;
    notifyListeners();
  }

  pickImage({bool camera = false, BuildContext? context}) async {
    loading = true;
    notifyListeners();
    try {
      XFile? pickedFile = await picker.pickImage(
        source: camera ? ImageSource.camera : ImageSource.gallery,
      );
      CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: pickedFile!.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ],
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Crop Image',
            toolbarColor: Constants.lightAccent,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false,
          ),
          IOSUiSettings(
            minimumAspectRatio: 1.0,
          ),
        ],
      );
      mediaUrl = File(croppedFile!.path);
      loading = false;
      Navigator.of(context!).push(
        CupertinoPageRoute(
          builder: (_) => ConfirmStatus(),
        ),
      );
      notifyListeners();
    } catch (e) {
      loading = false;
      notifyListeners();
      showInSnackBar('Cancelled', context!);
    }
  }

  //send message
  sendStatus(String chatId, StatusModel message) {
    statusService.sendStatus(
      message,
      chatId,
    );
  }

  Future<String> sendFirstStatus(StatusModel message) async {
    final newChatId = await statusService.sendFirstStatus(message);
    return newChatId;
  }

  void resetPost() {
    mediaUrl = null;
    description = null;
    edit = false;
    notifyListeners();
  }

  void showInSnackBar(String value, BuildContext context) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(value)));
  }

  void updateViewers(String statusId, StatusModel status) {
    // Implémentez ici la logique pour mettre à jour les spectateurs du statut
    // par exemple, vous pouvez appeler une fonction de service pour effectuer cette opération
  }
}
