import 'package:flame/game.dart';
import 'package:flame_game/domain/entities/level.dart';
import 'package:flame_game/domain/entities/user.dart';
import 'package:flame_game/game/components/game_over_overlay.dart';
import 'package:flame_game/game/components/game_pause_overlay.dart';
import 'package:flame_game/game/egg_tapper.dart';
import 'package:flame_game/presentation/bloc/user/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyGameWidget extends StatefulWidget {
  final Level level;
  final UserBloc userBloc;
  final User user;
  final List<Level> allLevels;
  final int currentLevelIndex;

  const MyGameWidget({
    super.key,
    required this.level,
    required this.userBloc,
    required this.user,
    required this.allLevels,
    required this.currentLevelIndex,
  });

  @override
  State<MyGameWidget> createState() => _MyGameWidgetState();
}

class _MyGameWidgetState extends State<MyGameWidget> {
  late HitTheEggGame _game;

  @override
  void initState() {
    super.initState();
    _initializeGame(widget.level);
  }

  void _initializeGame(Level level) {
    _game = HitTheEggGame(
      levelConfig: level,
      userBloc: widget.userBloc,
      user: widget.user,
    );
  }

  void _loadNextLevel() {
    if (mounted) {
      final nextIndex = widget.currentLevelIndex + 1;

      if (nextIndex < widget.allLevels.length) {
        final currentUserState = context.read<UserBloc>().state;
        User freshUser;

        if (currentUserState is UserLoaded) {
          freshUser = currentUserState.user;
        } else {
          freshUser = widget.user;
          debugPrint(
            "Попередження: _loadNextLevel не зміг отримати свіжий UserLoaded стан.",
          );
        }

        Navigator.of(context).pushReplacement(
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                MyGameWidget(
                  level: widget.allLevels[nextIndex],
                  userBloc: widget.userBloc,
                  user: freshUser,
                  allLevels: widget.allLevels,
                  currentLevelIndex: nextIndex,
                ),
            transitionDuration: Duration.zero,
          ),
        );
      } else {
        Navigator.of(context).pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GameWidget(
      game: _game,
      overlayBuilderMap: {
        'GameOverOverlay': (context, game) =>
            GameOverOverlay(game: _game, onNextLevel: _loadNextLevel),
        'GamePauseOverlay': GamePauseOverlay.builder,
      },
    );
  }
}
