import 'dart:io';

import 'package:app4geracao/control/web/uploadfile.dart';
import 'package:camera_camera/camera_camera.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

const Color kLightGray = Color(0xFFF1F0F5);

class UploadImageWidget extends StatefulWidget {
  final Function(String urlFile) onImageUploaded;
  final String initImage;
  final String placeHolder;
  final double size;
  final bool showExplore;
  const UploadImageWidget(
      {Key key,
      this.showExplore = true,
      this.onImageUploaded,
      this.initImage,
      this.placeHolder = 'assets/images/perfil.jpg',
      this.size = 150})
      : super(key: key);

  @override
  _UploadImageWidgetState createState() =>
      _UploadImageWidgetState(onImageUploaded, initImage, placeHolder);
}

class _UploadImageWidgetState extends State<UploadImageWidget> {
  final Function(String urlFile) onImageUploaded;
  final String initImage;
  final String placeHolder;

  bool isUploading = false;

  _UploadImageWidgetState(
      this.onImageUploaded, this.initImage, this.placeHolder);

  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }

  File image;
  _buildBody() {
    return Stack(
      children: <Widget>[
        Positioned(
          child: _buildPhoto(),
        ),
        _buildRequesting(),
        widget.showExplore
            ? Positioned(
                bottom: 5,
                left: 5,
                child: InkWell(
                  onTap: () => _onAddPhotoClicked(context),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: new BorderRadius.all(
                          Radius.elliptical(widget.size, widget.size)),
                      color: Theme.of(context).primaryColor.withOpacity(0.8),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Icon(
                        Icons.photo_library,
                        color: kLightGray,
                      ),
                    ),
                  ),
                ),
              )
            : Container(),
        Positioned(
          bottom: 5,
          right: 5,
          child: InkWell(
            onTap: () => _onTakePicture(context),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: new BorderRadius.all(
                    Radius.elliptical(widget.size, widget.size)),
                color: Theme.of(context).primaryColor.withOpacity(0.8),
              ),
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
                borderRadius: new BorderRadius.all(
                    Radius.elliptical(widget.size, widget.size)),
                color: Colors.black.withOpacity(0.5)),
            height: widget.size,
            width: widget.size,
            child: Center(
                child: CircularProgressIndicator(
              backgroundColor: Colors.white.withOpacity(0.3),
            )),
          )
        : Container(
            height: widget.size,
            width: widget.size,
          );
  }

  _buildPhoto() {
    return Container(
      margin: EdgeInsets.all(5),
      decoration: new BoxDecoration(
        color: kDarkGray,
        border: Border.all(color: Colors.black, width: 0.0),
        borderRadius:
            new BorderRadius.all(Radius.elliptical(widget.size, widget.size)),
      ),
      height: widget.size,
      width: widget.size,
      child: CircleAvatar(
        backgroundImage: image != null
            ? FileImage(image)
            : initImage == null
                ? Image.asset(placeHolder).image
                : Image.network(
                    initImage,
                    errorBuilder: (context, obj, _) {
                      return Image.asset(placeHolder);
                    },
                  ).image,
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
      String fn = await UploadFile.uploadFile(image.readAsBytesSync());
      if (onImageUploaded != null) onImageUploaded(fn);
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
