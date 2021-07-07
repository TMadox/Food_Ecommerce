// import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_store/Logic/APIRequests.dart';
import 'package:test_store/MainScreens/HomeScreen.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:dio_cache_interceptor_db_store/dio_cache_interceptor_db_store.dart';

void main() {
  // late CacheStore cacheStore;
  // if (!kIsWeb) {
  //   getApplicationDocumentsDirectory().then((dir) {
  //     cacheStore = DbCacheStore(databasePath: dir.path, logStatements: true);
  //     APIRequests.cacheStore = cacheStore;
  //   });
  // } else {
  //   cacheStore = DbCacheStore(databasePath: 'db', logStatements: true);
  //   APIRequests.cacheStore = cacheStore;
  // }
  runApp(ProviderScope(child: MaterialApp(home: HomeScreen())));
}
