// import 'package:flutter/material.dart';
// import 'package:zego_cloud/Video%20Call/login.dart';
//
// // For Vedio Call
// import 'package:zego_cloud/Video%20Call/home.dart';
// import 'package:zego_cloud/Video%20Call/login.dart';
//
// void main() {
//   runApp(MaterialApp(
//     debugShowCheckedModeBanner: false,
//     routes: {
//       "login": (context) => MyLogin(),
//       "home": (context) => MyHome(),
//     },
//     initialRoute: "login",
//   ));
// }


// //For Vedio Call with Notification

// Flutter imports:
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';


// Package imports:
import 'package:my_zego_cloud/VideoOfflineNotification/constants.dart';
import 'package:my_zego_cloud/VideoOfflineNotification/login_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

import 'package:firebase_messaging/firebase_messaging.dart';

void main() async {


  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  final prefs = await SharedPreferences.getInstance();
  final cacheUserID = prefs.get(cacheUserIDKey) as String? ?? '';
  if (cacheUserID.isNotEmpty) {
    currentUser.id = cacheUserID;
    currentUser.name = 'user_$cacheUserID';
  }

  /// 1/5: define a navigator key
  final navigatorKey = GlobalKey<NavigatorState>();

  /// 2/5: set navigator key to ZegoUIKitPrebuiltCallInvitationService
  ZegoUIKitPrebuiltCallInvitationService().setNavigatorKey(navigatorKey);

  ZegoUIKit().initLog().then((value) {
    runApp(MyApp(navigatorKey: navigatorKey));
  });
}

class MyApp extends StatefulWidget {
  final GlobalKey<NavigatorState> navigatorKey;

  const MyApp({
    required this.navigatorKey,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();

    if (currentUser.id.isNotEmpty) {
      onUserLogin();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: routes,
      /// 3/5: register the navigator key to MaterialApp
      navigatorKey: widget.navigatorKey,
      initialRoute:
      currentUser.id.isEmpty ? PageRouteNames.login : PageRouteNames.home,
      color: Colors.red,
      theme: ThemeData(scaffoldBackgroundColor: const Color(0xFFEFEFEF)),
    );
  }
}
