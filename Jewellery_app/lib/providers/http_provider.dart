import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:http/http.dart' as http;

class HTTPProvider {
  Future<http.Response> getData(String url, Map<String, String> headers) async {
    var file = await DefaultCacheManager().getSingleFile(url, headers: headers);

    if (file != null && await file.exists()) {
      String result = await file.readAsString();
      
      return http.Response(result, 200);
    }
    return http.Response("", 404);
  }
}
