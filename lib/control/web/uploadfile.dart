import 'dart:convert';

import 'package:flutter/material.dart' as material;
import 'package:http/http.dart' as http;
import 'package:image/image.dart';

import 'aws.dart';

class UploadFile {
  static Image _cropImage(Image image) {
    if (image.width == image.height) return image;
    bool widthMaior = image.width > image.height;
    int size = widthMaior ? image.height : image.width;
    int major = widthMaior ? image.width : image.height;
    int half = (size / 2).round();
    int halfMajor = (major / 2).round();
    int x0 = !widthMaior ? 0 : halfMajor - half;
    int y0 = widthMaior ? 0 : halfMajor - half;
    return copyCrop(image, x0, y0, size, size);
  }

  static List<int> _resizeCroppedImage(Image image, int size) {
    Image thumbnail = copyResize(image, width: size);
    JpegEncoder pngEncoder = new JpegEncoder();
    return pngEncoder.encodeImage(thumbnail);
  }

  static Future<String> uploadFile(List<int> contents) async {
    Image editImage = decodeImage(contents);
    String filename = await _uploadFileAux(contents, 'original_');
    filename = filename.replaceAll('"', '');
    var cropped = _cropImage(editImage);
    var thumbnail128 = _resizeCroppedImage(cropped, 128);
    await _uploadFileAux(thumbnail128, 't128_', fileName: filename);
    var thumbnail512 = _resizeCroppedImage(cropped, 512);
    await _uploadFileAux(thumbnail512, 't512_', fileName: filename);
    return filename;
  }

  static _uploadFileAux(List<int> contents, String leading,
      {String fileName}) async {
    try {
      String url = '$awsurl/uploadfile';
      String base64REsult = base64.encode(contents);
      Map<String, dynamic> body = {
        'body': base64REsult,
        'extension': '.jpg',
        'leading': leading,
      };
      if (fileName != null) body.addAll({'fileName': fileName});
      var response = await http
          .put(url,
              headers: awskey,
              body: jsonEncode(body),
              encoding: Encoding.getByName('UTF-8'))
          .timeout(Duration(seconds: 10));

      return response.body;
    } catch (e, s) {
      material.debugPrint('$e - $s');
    }
  }
}
