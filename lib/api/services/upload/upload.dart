import 'dart:io';

import 'package:roomeasy/api/services/base/baseModel.dart';
import 'package:roomeasy/api/constant/constant.dart';
import 'package:roomeasy/model/response/response.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class UploadService extends BaseService {
  UploadService() : super();

  Future singlePhoto(File file) async {
    var uri = Uri.https(Apiconstants.baseUrl,
        "${Apiconstants.apiVersion}${Apiconstants.uploadEndpoint}");

    var request = http.MultipartRequest(
      'POST',
      uri,
    );

    request.headers.addAll(await getHeaderFormData());
  }
}
