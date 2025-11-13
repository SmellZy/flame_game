import 'package:flame_game/domain/entities/user.dart';
import 'package:flame_game/presentation/bloc/user/user_bloc.dart';
import 'package:flame_game/presentation/widgets/main_background_component.dart';
import 'package:flame_game/presentation/widgets/profile_text_field.dart';
import 'package:flame_game/presentation/widgets/purple_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? _selectedAvatar;

  late final TextEditingController _usernameController;
  late final TextEditingController _emailController;

  User? _currentUser;

  bool _isInitialLoad = true;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController();
    _emailController = TextEditingController();

    context.read<UserBloc>().add(GetUserEvent());
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void goBack(dynamic context) {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        User? user;
        if (state is UserLoaded) {
          user = state.user;
          _currentUser = user;

          if (_isInitialLoad) {
            _selectedAvatar = user.avatarPath;
            _usernameController.text = user.username ?? "";
            _emailController.text = user.email ?? ""; 
            _isInitialLoad = false;
          }
        }

        final String currentAvatarPath =
            _selectedAvatar ?? "assets/images/avatars/avatar1.png";

        return Scaffold(
          body: MainBackgroundComponent(
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.all(40.w),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        IconButton(
                          onPressed: () {
                            goBack(context);
                          },
                          icon: Image.asset(
                            "assets/images/back.png",
                            width: 205.w,
                            height: 205.h,
                          ),
                        ),
                      ],
                    ),
                    PurpleContainer(
                      height: 1000.h,
                      width: 790.w,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Profile",
                            style: TextStyle(
                              fontFamily: "RubikMonoOne",
                              fontSize: 75.sp,
                              color: Colors.white,
                            ),
                          ),
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              Image.asset(
                                "assets/images/level_icon.png",
                                width: 355.w,
                                height: 361.h,
                              ),
                              Stack(
                                alignment: Alignment.bottomCenter,
                                children: [
                                  Container(
                                    width: 220.w,
                                    height: 200.h,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30.r),
                                      image: DecorationImage(
                                        image: AssetImage(currentAvatarPath),
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    padding: EdgeInsets.only(top: 50.h),
                                    onPressed: () {
                                      showModalBottomSheet(
                                        context: context,
                                        builder: (context) {
                                          return StatefulBuilder(
                                            builder: (sheetContext, sheetSetState) {
                                              return Container(
                                                height: 800.h,
                                                decoration: BoxDecoration(
                                                  color: const Color.fromARGB(
                                                    133,
                                                    158,
                                                    158,
                                                    158,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                    8.0,
                                                  ),
                                                  child: GridView.builder(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                          horizontal: 20.w,
                                                          vertical: 20.h,
                                                        ),
                                                    gridDelegate:
                                                        SliverGridDelegateWithFixedCrossAxisCount(
                                                          crossAxisCount: 3,
                                                          childAspectRatio: 1.0,
                                                          crossAxisSpacing:
                                                              42.w,
                                                          mainAxisSpacing: 87.h,
                                                        ),
                                                    itemCount: 2,
                                                    itemBuilder: (context, index) {
                                                      final avatarPath =
                                                          "assets/images/avatars/avatar${index + 1}.png";

                                                      final bool isSelected =
                                                          avatarPath ==
                                                          _selectedAvatar;

                                                      return Container(
                                                        decoration: BoxDecoration(
                                                          color: isSelected
                                                              ? const Color.fromARGB(
                                                                  255,
                                                                  195,
                                                                  146,
                                                                  218,
                                                                )
                                                              : const Color(
                                                                  0xFFFF6CD8,
                                                                ),
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                20.r,
                                                              ),
                                                        ),
                                                        child: IconButton(
                                                          onPressed: () {
                                                            setState(() {
                                                              _selectedAvatar =
                                                                  avatarPath;
                                                            });

                                                            sheetSetState(
                                                              () {},
                                                            );

                                                            Navigator.pop(
                                                              context,
                                                            );
                                                          },
                                                          icon: Image.asset(
                                                            avatarPath,
                                                            width: 50,
                                                            height: 50,
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ),
                                              );
                                            },
                                          );
                                        },
                                      );
                                    },
                                    icon: Image.asset(
                                      "assets/images/edit_button.png",
                                      width: 50.w,
                                      height: 50.h,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          ProfileTextField(
                            controller: _usernameController,
                            hintText: "USERNAME",
                          ),
                          SizedBox(height: 60.h),
                          ProfileTextField(
                            controller: _emailController,
                            hintText: "EMAIL",
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        debugPrint(_emailController.text);
                        final updatedUser = _currentUser!.copyWith(
                          username: _usernameController.text,
                          email: _emailController.text,
                          avatarPath: _selectedAvatar,
                        );
                        context.read<UserBloc>().add(
                          UpdateUserEvent(user: updatedUser),
                        );
                        goBack(context);
                      },
                      icon: Image.asset(
                        "assets/images/save_button.png",
                        width: 688.w,
                        height: 347.h,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
