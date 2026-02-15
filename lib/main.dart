import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:movies_module/core/di/dependency_injection.dart';
import 'package:movies_module/core/routing/app_router.dart';
import 'package:movies_module/core/routing/routes.dart';
import 'package:movies_module/core/utils/app_bloc_observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupGetIt();
  Bloc.observer = AppBlocObserver();
  runApp(const MoviesCrossApp());
}

class MoviesCrossApp extends StatelessWidget {
  const MoviesCrossApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.movies,
      onGenerateRoute: AppRouter.generateRoute,
    );
  }
}
