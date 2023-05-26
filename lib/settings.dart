import 'package:bank_flutter/signIn.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsPage1 extends StatefulWidget {
  SettingsPage1({Key? key}) : super(key: key);

  @override
  State<SettingsPage1> createState() => _SettingsPage1State();
}

class _SettingsPage1State extends State<SettingsPage1> {
  bool isTheme = false;

  @override
  void initState() {
    isTheme = Get.theme.brightness == Brightness.dark;
    super.initState();
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Center(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'SchoolDis',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w200),
                  ),
                  SizedBox(width: 10),
                  Image.asset(
                    'assets/images/logo.png',
                    scale: 2.1,
                  )
                ],
              ),
              Text(
                'SchoolDis - это приложение предназначено к применению в различных учебных заведениях для возможности дистанционного обучения ',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w100),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Настройки"),
      ),
      //backgroundColor: const Color(0xfff6f6f6),
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 400),
          child: ListView(
            children: [
              _SingleSection(
                title: "Основные",
                children: [
                  _CustomListTile(
                    title: "О приложении",
                    icon: Icons.info_outline,
                    funct: () {
                      _showBottomSheet(context);
                    },
                  ),
                  _CustomListTile(
                      title: "Темная тема",
                      icon: Icons.dark_mode_outlined,
                      trailing: CupertinoSwitch(
                          value: isTheme,
                          onChanged: (value) {
                            setState(() {
                              isTheme = !isTheme;
                              Get.changeThemeMode(
                                  isTheme ? ThemeMode.dark : ThemeMode.light);
                            });
                          })),
                  _CustomListTile(
                    title: "Поддержка",
                    icon: Icons.contact_support_outlined,
                    funct: () {},
                  ),
                ],
              ),
              Padding(padding: EdgeInsets.only(top: 410)),
              Center(
                child: TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: Color.fromARGB(255, 188, 26, 26),
                    textStyle: const TextStyle(fontSize: 20),
                  ),
                  onPressed: () async {
                    await FirebaseAuth.instance.signOut();
                    // ignore: use_build_context_synchronously
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SignInPageNew()),
                        (t) => false);
                  },
                  child: const Text('Выход'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CustomListTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final Widget? trailing;
  final Function()? funct;
  const _CustomListTile(
      {Key? key,
      required this.title,
      required this.icon,
      this.trailing,
      this.funct})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Text(title),
        leading: Icon(icon),
        trailing: trailing ?? const Icon(Icons.arrow_forward_ios, size: 18),
        onTap: funct);
  }
}

class _CustomListTile1 extends StatelessWidget {
  final String title;
  final Function()? funct;
  const _CustomListTile1({Key? key, required this.title, this.funct})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(title: Text(title), onTap: funct);
  }
}

class _SingleSection extends StatelessWidget {
  final String title;
  final List<Widget> children;
  const _SingleSection({
    Key? key,
    required this.title,
    required this.children,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title.toUpperCase(),
            style:
                Theme.of(context).textTheme.headline3?.copyWith(fontSize: 16),
          ),
        ),
        Container(
          width: double.infinity,
          //color: Colors.white,
          child: Column(
            children: children,
          ),
        ),
      ],
    );
  }
}
