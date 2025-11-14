import 'package:flame_game/domain/entities/egg.dart';
import 'package:flame_game/domain/entities/user.dart';
import 'package:flame_game/presentation/bloc/egg/egg_bloc.dart';
import 'package:flame_game/presentation/bloc/user/user_bloc.dart';
import 'package:flame_game/presentation/screens/menu_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Future shomModalShop(BuildContext context) {
  final userBloc = BlocProvider.of<UserBloc>(context);

  void showMessage(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  void handleEggTap(Egg egg, User currentUser) {
    final filename = getEggFilename(egg.eggIcon);
    final isPurchased = currentUser.purshasedEggs?.contains(filename) ?? false;

    if (isPurchased) {
      if (currentUser.currentEgg != egg.eggIcon) {
        final updatedUser = currentUser.copyWith(currentEgg: egg.eggIcon);
        userBloc.add(UpdateUserEvent(user: updatedUser));
      }
    } else {
      if (currentUser.coins! >= egg.buyPrice) {
        final newCoins = currentUser.coins! - egg.buyPrice;
        final newPurchasedEggs = (currentUser.purshasedEggs ?? []).toList()
          ..add(filename);

        final updatedUser = currentUser.copyWith(
          coins: newCoins,
          purshasedEggs: newPurchasedEggs,
          currentEgg: egg.eggIcon,
        );

        userBloc.add(UpdateUserEvent(user: updatedUser));
      } else {
        showMessage("Недостатньо монет для придбання!");
      }
    }
  }

  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) {
      return BlocBuilder<UserBloc, UserState>(
        builder: (userContext, userState) {
          if (userState is! UserLoaded) {
            return Container(
              height: 900.h,
              decoration: BoxDecoration(
                color: const Color.fromARGB(240, 50, 50, 50),
                borderRadius: BorderRadius.circular(30.r),
              ),
              child: const Center(child: CircularProgressIndicator()),
            );
          }

          final User freshUser = userState.user;

          return BlocBuilder<EggBloc, EggState>(
            builder: (eggContext, eggState) {
              if (eggState is EggsLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              List<Egg> eggs = [];
              if (eggState is EggsLoaded) {
                eggs = eggState.eggs;
              }

              return Container(
                height: 900.h,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(240, 50, 50, 50),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.r),
                    topRight: Radius.circular(30.r),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.all(20.w),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 20.h),
                        child: Text(
                          "EGG SHOP",
                          style: TextStyle(
                            fontFamily: "RubikMonoOne",
                            fontSize: 50.sp,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Expanded(
                        child: (eggs.isEmpty && eggState is! EggError)
                            ? const Center(
                                child: Text(
                                  "Немає яєць для відображення.",
                                  style: TextStyle(color: Colors.white70),
                                ),
                              )
                            : (eggState is EggError)
                            ? Center(
                                child: Text(
                                  "Помилка завантаження: ${eggState.message}",
                                  style: TextStyle(color: Colors.red),
                                ),
                              )
                            : GridView.builder(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 20.w,
                                  vertical: 20.h,
                                ),
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3,
                                      childAspectRatio: 0.8,
                                      crossAxisSpacing: 30.w,
                                      mainAxisSpacing: 30.h,
                                    ),
                                itemCount: eggs.length,
                                itemBuilder: (context, index) {
                                  final egg = eggs[index];
                                  final filename = getEggFilename(egg.eggIcon);
                                  final isPurchased =
                                      freshUser.purshasedEggs?.contains(
                                        filename,
                                      ) ??
                                      false;
                                  final isCurrent =
                                      freshUser.currentEgg == egg.eggIcon;

                                  Color cardColor = isPurchased
                                      ? isCurrent
                                            ? const Color(0xFF4CAF50)
                                            : const Color(0xFF9C27B0)
                                      : const Color(0xFF2196F3);

                                  return GestureDetector(
                                    onTap: () => handleEggTap(egg, freshUser),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: cardColor,
                                        borderRadius: BorderRadius.circular(
                                          20.r,
                                        ),
                                        border: isCurrent
                                            ? Border.all(
                                                color: Colors.amberAccent,
                                                width: 5.w,
                                              )
                                            : null,
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            'assets/images/${egg.eggIcon}',
                                            width: 150.w,
                                            height: 150.h,
                                          ),
                                          SizedBox(height: 10.h),
                                          if (!isPurchased)
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "${egg.buyPrice}",
                                                  style: TextStyle(
                                                    fontFamily: "RubikMonoOne",
                                                    fontSize: 30.sp,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                SizedBox(width: 10.w),
                                                Image.asset(
                                                  "assets/images/coin_logo.png",
                                                  width: 40.w,
                                                  height: 40.h,
                                                ),
                                              ],
                                            )
                                          else
                                            Text(
                                              isCurrent ? "SELECTED" : "BOUGHT",
                                              style: TextStyle(
                                                fontFamily: "RubikMonoOne",
                                                fontSize: 25.sp,
                                                color: isCurrent
                                                    ? Colors.black
                                                    : Colors.white,
                                              ),
                                            ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      );
    },
  );
}
