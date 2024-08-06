import 'package:clean_architechture/app/data/category/local_category_datasource.dart';
import 'package:clean_architechture/app/data/clothes/local_clothes_datasource.dart';
import 'package:clean_architechture/app/features/closet/manager/closet/closet_bloc.dart';
import 'package:clean_architechture/core/services/network_service.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../app/data/closet/local_closet_datasource.dart';
import '../../app/features/closet/manager/category/category_bloc.dart';
import '../../app/features/closet/manager/clothes/clothes_bloc.dart';
import '../../config/theme/theme.dart';
import '../models/appsettings.dart';
import 'isar/isar_service.dart';


class DIService {
  static final sl = GetIt.instance;

  Future init() async {
    // #region bloc
    sl.registerFactory(() => CreateCategoryBloc(sl()));
    sl.registerFactory(() => GetCategoryBloc(sl()));
    sl.registerFactory(() => UpdateCategoryBloc(sl()));
    sl.registerFactory(() => DeleteCategoryBloc(sl()));

    sl.registerFactory(() => CreateClothesBloc(sl()));
    sl.registerFactory(() => GetClothesBloc(sl()));
    sl.registerFactory(() => UpdateClothesBloc(sl()));
    sl.registerFactory(() => DeleteClothesBloc(sl()));

    sl.registerFactory(() => CreateClosetBloc(sl()));
    sl.registerFactory(() => UpdateClosetBloc(sl()));
    sl.registerFactory(() => DeleteClosetBloc(sl()));
    sl.registerFactory(() => GetClosetBloc(sl()));

    // #endregion

    // #region data
    sl.registerLazySingleton<LocalCategoryDataSource>(() => LocalCategoryDataSourceImpl(sl()));
    sl.registerLazySingleton<LocalClothesDataSource>(() => LocalClothesDataSourceImpl(sl()));
    sl.registerLazySingleton<LocalClosetDataSource>(() => LocalClosetDataSourceImpl(sl()));
    // #endregion

    // #region usecase
    // #endregion
    //network
    sl.registerLazySingleton<DioService>(() => DioService(sl()).init());
    //external
    final sharedPreferences = await SharedPreferences.getInstance();
    sl.registerSingleton<SharedPreferences>(sharedPreferences);
    final isarService = await LocalDbProvider().init();
    sl.registerSingleton<LocalDbProvider>(isarService);
    sl.registerSingleton<Dio>(Dio());
    sl.registerSingleton<AppSettings>(await AppSettings.loadSettings());
    //theme
    final theme = await AppTheme().init(sl());
    sl.registerSingleton<AppTheme>(theme);
  }
}
