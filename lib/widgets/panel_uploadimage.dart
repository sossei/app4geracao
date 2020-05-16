import 'dart:convert';
import 'dart:io';

import 'package:app4geracao/control/web/aws.dart';
import 'package:camera_camera/camera_camera.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:permission_handler/permission_handler.dart';

const Color kLightGray = Color(0xFFF1F0F5);

class UploadImageWidget extends StatefulWidget {
  final Function(String urlFile) onImageUploaded;

  const UploadImageWidget({Key key, this.onImageUploaded}) : super(key: key);
  @override
  _UploadImageWidgetState createState() =>
      _UploadImageWidgetState(onImageUploaded);
}

class _UploadImageWidgetState extends State<UploadImageWidget> {
  final Function(String urlFile) onImageUploaded;
  bool isUploading = false;
  _UploadImageWidgetState(this.onImageUploaded);
  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }

  File image;
  _buildBody() {
    return Stack(
      children: <Widget>[
        Positioned(
          child: _buildAddPhoto(),
        ),
        _buildRequesting(),
        Positioned(
          bottom: 5,
          left: 5,
          child: InkWell(
            onTap: () => _onAddPhotoClicked(context),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius:
                      new BorderRadius.all(Radius.elliptical(150, 150)),
                  color: Colors.blueGrey),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Icon(
                  Icons.photo_library,
                  color: kLightGray,
                ),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 5,
          right: 5,
          child: InkWell(
            onTap: () => _onTakePicture(context),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius:
                      new BorderRadius.all(Radius.elliptical(150, 150)),
                  color: Colors.blueGrey),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Icon(
                  Icons.camera_alt,
                  color: kLightGray,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  _buildRequesting() {
    return isUploading
        ? Container(
            margin: EdgeInsets.all(5),
            decoration: BoxDecoration(
                borderRadius: new BorderRadius.all(Radius.elliptical(150, 150)),
                color: Colors.black.withOpacity(0.5)),
            height: 150,
            width: 150,
            child: Center(child: CircularProgressIndicator()),
          )
        : Container(
            height: 150,
            width: 150,
          );
  }

  _buildAddPhoto() {
    return Container(
      margin: EdgeInsets.all(5),
      decoration: new BoxDecoration(
        color: kDarkGray,
        border: Border.all(color: Colors.black, width: 0.0),
        borderRadius: new BorderRadius.all(Radius.elliptical(150, 150)),
      ),
      height: 150,
      width: 150,
      child: CircleAvatar(
        backgroundImage: image != null
            ? FileImage(image)
            : Image.asset('assets/images/perfil.jpg').image,
        radius: 200.0,
      ),
    );
  }

  _showOpenAppSettingsDialog(context) {
    return CustomDialog.show(
      context,
      'Permission needed',
      'Photos permission is needed to select photos',
      'Open settings',
      openAppSettings,
    );
  }

  _onTakePicture(context) async {
    Permission permission = Permission.camera;
    if (await _checkPermission(permission)) {
      image = await Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Camera(
                    mode: CameraMode.normal,
                    imageMask: CameraFocus.circle(
                      color: Colors.black.withOpacity(0.8),
                    ),
                  )));
      await _uploadFile();
      setState(() {});
    }
  }

  _onAddPhotoClicked(context) async {
    Permission permission;
    if (Platform.isIOS) {
      permission = Permission.photos;
    } else {
      permission = Permission.storage;
    }
    if (await _checkPermission(permission)) {
      _selectPicture();
    }
  }

  Future<bool> _checkPermission(Permission permission) async {
    PermissionStatus permissionStatus = await permission.status;
    print(permissionStatus);
    if (permissionStatus == PermissionStatus.restricted) {
      _showOpenAppSettingsDialog(context);
      permissionStatus = await permission.status;
      if (permissionStatus != PermissionStatus.granted) {
        return false;
      }
    }
    if (permissionStatus == PermissionStatus.permanentlyDenied) {
      _showOpenAppSettingsDialog(context);
      permissionStatus = await permission.status;
      if (permissionStatus != PermissionStatus.granted) {
        return false;
      }
    }
    if (permissionStatus == PermissionStatus.undetermined) {
      permissionStatus = await permission.request();
      if (permissionStatus != PermissionStatus.granted) {
        return false;
      }
    }
    if (permissionStatus == PermissionStatus.denied) {
      if (Platform.isIOS) {
        _showOpenAppSettingsDialog(context);
      } else {
        permissionStatus = await permission.request();
      }
      if (permissionStatus != PermissionStatus.granted) {
        return false;
      }
    }
    if (permissionStatus == PermissionStatus.granted) {
      return true;
    }
    return false;
  }

  _selectPicture() async {
    image = await ImagePicker.pickImage(
      source: ImageSource.gallery,
    );
    await _uploadFile();
    setState(() {});
  }

  _uploadFile() async {
    setState(() {
      isUploading = true;
    });
    try {
      String url = '$awsurl/uploadfile';
      String base64REsult = base64.encode(image.readAsBytesSync());
      Map<String, dynamic> body = {
        'body': base64REsult,
        'extension': path.extension(image.path),
      };
      var response = await http
          .put(url,
              headers: awskey,
              body: jsonEncode(body),
              encoding: Encoding.getByName('UTF-8'))
          .timeout(Duration(seconds: 10));

      String nomeDoArquivo = response.body;
      debugPrint(nomeDoArquivo);
      if (onImageUploaded != null) onImageUploaded(nomeDoArquivo);
    } catch (e, s) {
      debugPrint('$e - $s');
    }
    setState(() {
      isUploading = false;
    });
  }
}

const Color kDarkGray = Color(0xFFA3A3A3);

class GalleryItem {
  GalleryItem({this.id, this.resource, this.isSvg = false});

  final String id;
  String resource;
  final bool isSvg;
}

class CustomDialog {
  static void show(context, String heading, String subHeading,
      String positiveButtonText, Function onPressedPositive,
      [String negativeButtonText, Function onPressedNegative]) {
    if (Platform.isIOS) {
      // iOS-specific code
      showDialog(
        context: context,
        useRootNavigator: false,
        builder: (_) => AlertDialog(
          title: Text(
            heading,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          content: Text(
            subHeading,
            style: TextStyle(
              color: kDarkGray,
            ),
          ),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                negativeButtonText ?? 'Cancel',
                style: TextStyle(color: Colors.red),
              ),
            ),
            FlatButton(
              onPressed: onPressedPositive,
              child: Text(positiveButtonText),
            ),
          ],
        ),
      );
    } else {
      showDialog(
        useRootNavigator: false,
        context: context,
        builder: (_) => AlertDialog(
          title: Text(
            heading,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          content: Text(
            subHeading,
            style: TextStyle(
              color: kDarkGray,
            ),
          ),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                if (onPressedNegative != null) {
                  onPressedNegative();
                } else {
                  Navigator.pop(context);
                }
              },
              child: Text(
                negativeButtonText ?? 'Cancel',
                style: TextStyle(color: Colors.red),
              ),
            ),
            FlatButton(
              onPressed: onPressedPositive,
              child: Text(positiveButtonText),
            ),
          ],
        ),
      );
    }
  }
}
