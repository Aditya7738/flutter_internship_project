// import 'dart:html';

// import 'package:flutter_cache_manager/flutter_cache_manager.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:path/path.dart' as path;
// import 'dart:io';
// import 'package:http/http.dart' as http;

// class MyCacheManager extends BaseCacheManager {
//   static const key = "customCache";

//   static CacheManager _instance = CacheManager(Config(
//     key,
//     stalePeriod: const Duration(days: 7),
//     maxNrOfCacheObjects: 100,
//     repo: JsonCacheInfoRepository(databaseName: key),
//     fileSystem: IOFileSystem(key),
//     fileService: HttpFileService(),
//   ),);
  

//   @override
//   Future<String> getFilePath() async {
//     var directory = await getTemporaryDirectory();
//     return path.join(directory.path, key);
//   }

//   static Future<FileFetcherResponse?> _myHttpGetter(
//       String url, Map<String, String> headers) async {
//     HttpFileFetcherResponse? response;
//     Uri uri = Uri.parse(url);
//     try {
//       var res = await http.get(uri, headers: headers);
//       response = HttpFileFetcherResponse(res);
//     } on SocketException {
//       print('No internet connection');
//       response = null;
//     }
//     return response;
//   }
// }
