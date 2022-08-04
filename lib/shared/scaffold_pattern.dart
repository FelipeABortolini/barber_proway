// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math' as math;

import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:get_it/get_it.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:line_icons/line_icons.dart';

import '../core/assets.dart';
import '../infra/model/user_model.dart';
import '../presenter/edit_profile/edit_profile_page.dart';
import '../presenter/home/home_page.dart';
import '../presenter/schedule/schedule_page.dart';

class ScaffoldPattern extends StatefulWidget {
  const ScaffoldPattern({
    required this.bodyPage,
    Key? key,
  }) : super(key: key);

  final Widget bodyPage;
  @override
  State<ScaffoldPattern> createState() => _ScaffoldPatternState();
}

class _ScaffoldPatternState extends State<ScaffoldPattern> {
  late int indexpage = 0;
  var _bottomNavIndex = 0;

  @override
  Widget build(BuildContext context) {
    // var size = MediaQuery.of(context).size;
    final scaffoldKey = GlobalKey<ScaffoldState>();

    void setIndex(int index) {
      setState(() {
        indexpage = index;
        _bottomNavIndex = index;
      });
    }

    return Scaffold(
      key: scaffoldKey,
      resizeToAvoidBottomInset: false,
      endDrawer: DrawerWidget(
        name: 'Vinicius',
        photoProfile: imgProfile,
      ),
      backgroundColor: const Color.fromARGB(255, 24, 24, 24),
      floatingActionButton: SizedBox(
        height: 90,
        width: 90,
        child: FloatingActionButton(
          elevation: 50,
          focusColor: Colors.grey,
          backgroundColor: const Color.fromARGB(255, 42, 42, 42),
          onPressed: () {
            setIndex(9);
            Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (context) => HomePage(scaffoldKeymed: scaffoldKey)),
            );
          },
          child: const Text('NAVALHA',
              style: TextStyle(
                  fontFamily: 'Bevan',
                  fontSize: 12,
                  color: Color.fromARGB(255, 255, 255, 255))),
          // child: const Icon(Icons.home, size: 30),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar(
        leftCornerRadius: 32,
        rightCornerRadius: 32,
        backgroundColor: const Color.fromARGB(255, 24, 24, 24),
        icons: const [
          Icons.account_circle_rounded,
          LineIcons.instagram,
          Icons.calendar_month_outlined,
          Icons.settings,
        ],
        iconSize: 27,
        activeIndex: _bottomNavIndex,
        inactiveColor: Colors.white,
        activeColor: Colors.white,
        borderWidth: 0.9,
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.verySmoothEdge,
        onTap: (index) {
          // scaffoldKey.currentState!.openEndDrawer();

          // if (index == 1) {
          //   scaffoldKey.currentState!.openEndDrawer();
          // }

          switch (index) {
            case 0:
              {
                // TODO chamar pagina perfil

                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => const EditProfilePage()),
                );
                break;
              }
            case 3:
              {
                scaffoldKey.currentState!.openEndDrawer();

                break;
              }
            case 2:
              {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const SchedulePage()),
                );
                break;
              }

            default:
          }
        },
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(imgFundoGeral),
            fit: BoxFit.cover,
          ),
        ),
        child: widget.bodyPage,
      ),
    );
  }
}

// class DrawerWidget extends StatelessWidget {
//   final String photoProfile;
//   final String name;

//   const DrawerWidget({
//     Key? key,
//     required this.photoProfile,
//     required this.name,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return Scaffold(body: DrawerWidgetState(),);
//   }
// }

class DrawerWidget extends HookConsumerWidget {
  final String photoProfile;
  final String name;

  DrawerWidget({
    required this.photoProfile,
    required this.name,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final darkMode = ref.watch(darkModeProvider);

    return Drawer(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          bottomLeft: Radius.circular(20),
        ),
      ),
      backgroundColor: darkMode.darkMode
                        ? const Color.fromARGB(255, 44, 44, 44)
                        : Color.fromARGB(255, 255, 255, 255),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Center(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 80,
                    backgroundColor: darkMode.darkMode
                        ? Color.fromARGB(255, 255, 253, 253)
                        : Color.fromARGB(255, 83, 80, 80),
                    child: Image.asset(
                      photoProfile,
                    ),
                  ),
                  NameUser(),
                  const SizedBox(
                    height: 25,
                  ),
                  const ContainerDrawer1(
                    textTopic: 'Editar cadastro',
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const ContainerDrawerSchedule(
                    textTopic: 'Minha agenda',
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const ContainerDrawer1(
                    textTopic: 'Redes sociais',
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const ContainerDrawer1(
                    textTopic: 'Sair',
                  ),
                ],
              ),
            ),
          ),
          const DarkLightMode(),
        ],
      ),
    );
  }
}

class ProfilePhoto extends HookConsumerWidget {
  const ProfilePhoto({
    Key? key,
    required this.widget,
  }) : super(key: key);

  final DrawerWidget widget;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final darkMode = ref.watch(darkModeProvider);

    return CircleAvatar(
      radius: 80,
      backgroundColor: darkMode.darkMode
          ? Color.fromARGB(255, 255, 253, 253)
          : Color.fromARGB(255, 83, 80, 80),
      child: Image.asset(
        widget.photoProfile,
      ),
    );
  }
}

class ArrowLeft extends HookConsumerWidget {
  const ArrowLeft({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final darkMode = ref.watch(darkModeProvider);

    return IconButton(
      onPressed: () {},
      icon: Icon(
        Icons.arrow_forward_ios_rounded,
        color: darkMode.darkMode ? Colors.white : Colors.black,
        size: 30,
      ),
    );
  }
}

class NameUser extends HookConsumerWidget {
  const NameUser({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final darkMode = ref.watch(darkModeProvider);

    UsuarioModel usuario = GetIt.I.get<UsuarioModel>();
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: Text(
        usuario.userName!.contains(' ')
            ? usuario.userName!.substring(0, usuario.userName!.indexOf(' '))
            : usuario.userName!,
        style: TextStyle(
          color: darkMode.darkMode ? Colors.white : Colors.black,
          fontSize: 22,
          shadows: const [
            Shadow(
              offset: Offset(0, 2),
              blurRadius: 3,
              color: Color.fromARGB(255, 0, 0, 0),
            )
          ],
        ),
      ),
    );
  }
}

final darkModeProvider = ChangeNotifierProvider(
  (ref) => DarkModeController(),
);

class DarkModeController extends ChangeNotifier {
  bool darkMode = true;

  void changeMode(bool newDarkMode) {
    darkMode = newDarkMode;
    notifyListeners();
  }
}

class DarkLightMode extends HookConsumerWidget {
  const DarkLightMode({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final darkMode = ref.watch(darkModeProvider);

    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: () {
        ref.watch(darkModeProvider).changeMode(!darkMode.darkMode);
        print(darkMode.darkMode);
      },
      child: Transform.rotate(
        angle: 320 * math.pi / 180,
        child: Icon(
          Icons.nightlight,
          color: darkMode.darkMode ? Colors.white : Colors.black,
          shadows: const [
            Shadow(
              offset: Offset(0, 3),
              blurRadius: 5,
              color: Color.fromARGB(255, 0, 0, 0),
            )
          ],
          size: 30,
        ),
      ),
    );
  }
}

class ContainerDrawer1 extends HookConsumerWidget {
  final String textTopic;

  const ContainerDrawer1({
    Key? key,
    required this.textTopic,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final darkMode = ref.watch(darkModeProvider);

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: ((context) => const EditProfilePage()),
          ),
        );
      },
      child: Ink(
        decoration: BoxDecoration(
          color: darkMode.darkMode ? const Color.fromARGB(36, 36, 36, 1) : const Color.fromARGB(255, 255, 255, 1),
          borderRadius: BorderRadius.circular(30),
          boxShadow: const [
            BoxShadow(
              color: Color.fromARGB(100, 0, 0, 0),
              blurRadius: 5,
              spreadRadius: 1,
            ),
          ],
        ),
        child: ListTile(
          title: Center(
            child: Text(textTopic,
                style: TextStyle(
                  color: darkMode.darkMode ?  const Color.fromARGB(255, 255, 255, 1) : const Color.fromARGB(36, 36, 36, 1),
                  fontSize: 18,
                  shadows: const [
                    Shadow(
                      offset: Offset(0, 1),
                      blurRadius: 3,
                      color: Color.fromARGB(255, 0, 0, 0),
                    )
                  ],
                )),
          ),
        ),
      ),
    );
  }
}

class ContainerDrawerSchedule extends HookConsumerWidget {
  final String textTopic;

  const ContainerDrawerSchedule({
    Key? key,
    required this.textTopic,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final darkMode = ref.watch(darkModeProvider);

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: ((context) => const SchedulePage()),
          ),
        );
      },
      child: Ink(
        decoration: BoxDecoration(
          color: darkMode.darkMode ? const Color.fromARGB(36, 36, 36, 1) : const Color.fromARGB(255, 255, 255, 1),
          borderRadius: BorderRadius.circular(30),
          boxShadow: const [
            BoxShadow(
              color: Color.fromARGB(100, 0, 0, 0),
              blurRadius: 5,
              spreadRadius: 1,
            ),
          ],
        ),
        child: ListTile(
          title: Center(
            child: Text(textTopic,
                style: TextStyle(
                  color: darkMode.darkMode ?  const Color.fromARGB(255, 255, 255, 1) : const Color.fromARGB(36, 36, 36, 1),
                  fontSize: 18,
                  shadows: const [
                    Shadow(
                      offset: Offset(0, 1),
                      blurRadius: 3,
                      color: Color.fromARGB(255, 0, 0, 0),
                    )
                  ],
                ),),
          ),
        ),
      ),
    );
  }
}
