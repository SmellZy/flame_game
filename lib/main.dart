import 'package:flame/flame.dart';
import 'package:flame_game/data/repositories/level_repository_impl.dart';
import 'package:flame_game/data/repositories/user_repository_impl.dart';
import 'package:flame_game/data/sources/level_local_datasource.dart';
import 'package:flame_game/data/sources/user_local_datasource.dart';
import 'package:flame_game/domain/repositories/level_repository.dart';
import 'package:flame_game/domain/repositories/user_repository.dart';
import 'package:flame_game/presentation/bloc/level/level_bloc.dart';
import 'package:flame_game/presentation/bloc/user/user_bloc.dart';
import 'package:flame_game/presentation/screens/home_screen.dart';
import 'package:flame_game/presentation/screens/how_to_play_screen.dart';
import 'package:flame_game/presentation/screens/loading_screen.dart';
import 'package:flame_game/presentation/screens/menu/leaderboard_screen.dart';
import 'package:flame_game/presentation/screens/menu/privacy_policy_screen.dart';
import 'package:flame_game/presentation/screens/menu/profile_screen.dart';
import 'package:flame_game/presentation/screens/menu/settings_screen.dart';
import 'package:flame_game/presentation/screens/menu/term_of_use_screen.dart';
import 'package:flame_game/presentation/screens/menu_screen.dart';
import 'package:flame_game/presentation/screens/play_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Flame.device.fullScreen;
  runApp(
    ScreenUtilInit(
      designSize: Size(1080, 1920),
      minTextAdapt: true,
      builder: (context, child) => const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<UserBloc>(
          create: (context) {
            final UserLocalDataSource localDataSource =
                UserLocalDataSourceImpl();
            final UserRepository userRepository = UserRepositoryImpl(
              localDataSource: localDataSource,
            );
            return UserBloc(userRepository);
          },
        ),
        BlocProvider<LevelBloc>(
          create: (context) {
            final LevelLocalDataSource levelLocalDataSource =
                LevelLocalDataSourceImpl();
            final LevelRepository levelRepository = LevelRepositoryImpl(
              localDataSource: levelLocalDataSource,
            );
            return LevelBloc(levelRepository);
          },
        ),
      ],
      child: MaterialApp(
        initialRoute: "/",
        routes: {
          '/': (context) => const LoadingScreen(),
          '/home': (context) => const HomeScreen(),
          '/play': (context) => const PlayScreen(),
          '/howtoplay': (context) => const HowToPlayScreen(),
          '/menu': (context) => const MenuScreen(),
          '/profile': (context) => const ProfileScreen(),
          '/settings': (context) => const SettingsScreen(),
          '/leaderboard': (context) => const LeaderboardScreen(),
          '/privacy': (context) => const PrivacyScreen(),
          '/terms': (context) => const TermsScreen(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
