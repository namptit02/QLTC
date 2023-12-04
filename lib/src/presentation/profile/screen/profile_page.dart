import 'dart:io' show Directory, File, Platform;

import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:csv/csv.dart';
// import 'package:expenditure_management/src/data/models/spending.dart';
import 'package:expenditure_management/src/data/models/user.dart' as myuser;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_switch/flutter_switch.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';
// import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

// import '../../../core/function/loading_animation.dart';
import '../../../core/function/route_function.dart';
import '../../../core/setting/bloc/setting_cubit.dart';
import '../../../core/setting/localization/app_localizations.dart';
import '../../../core/utils/constants/app_colors.dart';
import '../../../core/utils/constants/app_styles.dart';
import '../../../core/utils/constants/list.dart';
import '../../change_password/screen/change_password.dart';
import '../../edit_profile/screen/edit_profile_page.dart';
import '../../history/screen/history_page.dart';
import '../widget/info_widget.dart';
import '../widget/setting_item.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  var numberFormat = NumberFormat.currency(locale: "vi_VI");
  int language = 0;
  bool darkMode = false;
  bool loginMethod = false;

  @override
  void initState() {
    SharedPreferences.getInstance().then((value) {
      setState(() {
        language = value.getInt('language') ??
            (Platform.localeName.split('_')[0] == "vi" ? 0 : 1);
        darkMode = value.getBool("isDark") ?? false;
        loginMethod = value.getBool("login") ?? false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("info")
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  myuser.User user =
                      myuser.User.fromFirebase(snapshot.requireData);
                  return InfoWidget(user: user);
                }
                return const InfoWidget();
              },
            ),
            const SizedBox(height: 10),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 40),
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      settingItem(
                        text: AppLocalizations.of(context).translate('account'),
                        action: () {
                          Navigator.of(context).push(createRoute(
                            screen: const EditProfilePage(),
                            begin: const Offset(1, 0),
                          ));
                        },
                        icon: FontAwesomeIcons.solidUser,
                        color: const Color.fromRGBO(0, 150, 255, 1),
                      ),
                      if (loginMethod) const SizedBox(height: 20),
                      if (loginMethod)
                        settingItem(
                          text: AppLocalizations.of(context)
                              .translate('change_password'),
                          action: () {
                            Navigator.of(context).push(createRoute(
                              screen: const ChangePassword(),
                              begin: const Offset(1, 0),
                            ));
                          },
                          icon: FontAwesomeIcons.lock,
                          color: const Color.fromRGBO(233, 116, 81, 1),
                        ),
                      const SizedBox(height: 20),
                      settingItem(
                        text:
                            AppLocalizations.of(context).translate('language'),
                        action: _showBottomSheet,
                        icon: Icons.translate_outlined,
                        color: const Color.fromRGBO(218, 165, 32, 1),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.black87,
                              borderRadius: BorderRadius.circular(90),
                            ),
                            padding: const EdgeInsets.all(10),
                            child: const Icon(
                              FontAwesomeIcons.solidMoon,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            AppLocalizations.of(context).translate('dark_mode'),
                            style: const TextStyle(fontSize: 18),
                          ),
                          const Spacer(),
                          FlutterSwitch(
                            height: 30,
                            width: 60,
                            value: darkMode,
                            onToggle: (value) async {
                              BlocProvider.of<SettingCubit>(context)
                                  .changeTheme();
                              setState(() => darkMode = value);
                              final prefs =
                                  await SharedPreferences.getInstance();
                              await prefs.setBool('isDark', darkMode);
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      settingItem(
                        text: AppLocalizations.of(context).translate('history'),
                        action: () {
                          Navigator.of(context).push(createRoute(
                            screen: const HistoryPage(),
                            begin: const Offset(1, 0),
                          ));
                        },
                        icon: Icons.history_rounded,
                        color: const Color.fromRGBO(121, 189, 161, 1),
                      ),
                      
                
                      const SizedBox(height: 40),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.buttonLogin,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          onPressed: () async {
                            await FirebaseAuth.instance.signOut();
                            await GoogleSignIn().signOut();
                            if (!mounted) return;
                            Navigator.pushNamedAndRemoveUntil(
                                context, '/login', (route) => false);
                          },
                          child: Text(
                            AppLocalizations.of(context).translate('logout'),
                            style: AppStyles.p,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showBottomSheet() {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
      ),
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.only(left: 20),
          width: double.infinity,
          height: 170,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () async {
                  changeLanguage(0);
                },
                child: Row(
                  children: [
                    Image.asset("assets/images/vietnam.png", width: 70),
                    const Spacer(),
                    const Text(
                      "Tiếng Việt",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Radio(
                      value: 0,
                      groupValue: language,
                      onChanged: (value) {
                        changeLanguage(0);
                      },
                    )
                  ],
                ),
              ),
              InkWell(
                onTap: () async {
                  changeLanguage(1);
                },
                child: Row(
                  children: [
                    Image.asset("assets/images/english.png", width: 70),
                    const Spacer(),
                    const Text(
                      "English",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Radio(
                      value: 1,
                      groupValue: language,
                      onChanged: (value) {
                        changeLanguage(1);
                      },
                    )
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Future changeLanguage(int lang) async {
    if (lang != language) {
      if (lang == 0) {
        BlocProvider.of<SettingCubit>(context).toVietnamese();
      } else {
        BlocProvider.of<SettingCubit>(context).toEnglish();
      }
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt('language', lang);
      if (!mounted) return;
      setState(() => language = lang);
    }

    if (!mounted) return;
    Navigator.pop(context);
  }

}
