import 'dart:typed_data';
import 'package:flutter/services.dart';

import '../../../../core/core.dart';
import '../../../../core/resources/constats.dart';
import '../models/map_model.dart';

abstract class MapRemoteDataSource {
  Future<MapModel> getMaps(String mapType, int x, int y, int zoom);
}

class MapRemoteDataSourceImpl extends MapRemoteDataSource {
  @override
  Future<MapModel> getMaps(String mapType, int x, int y, int zoom) async {
    try {
      final uri = Uri.parse(
          "https://tile.openweathermap.org/map/$mapType/$zoom/$x/$y.png?appid=$API_KEY");

      final ByteData imageData = await NetworkAssetBundle(uri).load("");
      return MapModel.fromByteData(imageData);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
