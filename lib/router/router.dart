
import 'package:auto_route/auto_route.dart';
import 'package:morphology_finder/features/home/view/home_screen.dart';

part 'router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes {
    return [
      AutoRoute(
        page: HomeRoute.page,
        path: '/',
      ),
    ];
  }
}
