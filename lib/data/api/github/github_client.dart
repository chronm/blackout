import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pub_semver/pub_semver.dart';

class GithubClient {
  final Dio _dio;

  GithubClient(this._dio);

  Future<Version> getVersion() async {
    var response = await _dio.get<String>("https://blackout.chronm.dev/api/version.txt");
    return Version.parse(response.data.replaceAll("\n", ""));
  }

  Future<String> getDownloadUrl() async {
    var response = await _dio.get<String>("https://api.github.com/repos/chronm/blackout-mobile/releases/latest");
    return jsonDecode(response.data)["assets"][0]["browser_download_url"];
  }

  Future<String> downloadApk(String url) async {
    var directory = await getApplicationDocumentsDirectory();
    await _dio.download(url, "${directory.path}/blackout.apk");
    return "${directory.path}/blackout.apk";
  }
}
