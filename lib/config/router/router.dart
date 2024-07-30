import 'dart:io';

import 'package:clean_architechture/config/router/routes.dart';
import 'package:go_router/go_router.dart';

import '../../features/base/presentation/pages/root_view.dart';


final GoRouter router = GoRouter(routes: [
  GoRoute(
    path: AppRoutes.rootScreen,
    builder: (c, s) => const RootView(),
    redirect: (context, state) async {
      // var prefService = DiService.sl<SharePreferenceService>();
      // var user = prefService.getUser();
      // if( user == null){
      //   DiService.sl<DioService>().setupToken("");
      //   return null;
      // }
      // DiService.sl<DioService>().setupToken(user!.accessToken);
      // return AppRoutes.rootView;

      return null;
    },
  ),
  // GoRoute(
  //   path: AppRoutes.loginScreen,
  //   builder: (c, s) => BlocProvider<GetLocalAuthBloc>(
  //     create: (context) =>
  //         DIService.sl<GetLocalAuthBloc>()..add(const GetLocalAuthEvent()),
  //     child: BlocBuilder<GetLocalAuthBloc, GetLocalAuthState>(
  //         builder: (context, state) {
  //       final auth = AuthEntity.getCurrentData();
  //       if (auth != null) {
  //         return const QuickLoginScreen();
  //       } else {
  //         return const LoginScreen();
  //       }
  //     }),
  //   ),
  // ),

]);
