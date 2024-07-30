import 'package:clean_architechture/core/services/network_service.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../config/theme/theme.dart';
import '../models/appsettings.dart';


class DIService {
  static final sl = GetIt.instance;

  Future init() async {
    // #region bloc
    // #endregion

    // #region repo
    // #endregion

    // #region usecase
    // #endregion
    //network
    sl.registerLazySingleton<DioService>(() => DioService(sl()).init());
    //external
    final sharedPreferences = await SharedPreferences.getInstance();
    sl.registerSingleton<SharedPreferences>(sharedPreferences);
    sl.registerSingleton<Dio>(Dio());
    sl.registerSingleton<AppSettings>(await AppSettings.loadSettings());
    //theme
    final theme = await AppTheme().init(sl());
    sl.registerSingleton<AppTheme>(theme);
  }
}
