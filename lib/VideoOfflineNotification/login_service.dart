import 'package:shared_preferences/shared_preferences.dart';

import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:zego_uikit_signaling_plugin/zego_uikit_signaling_plugin.dart';
import 'constants.dart';

/// local virtual login
Future<void> login({
  required String userID,
  required String userName,
}) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setString(cacheUserIDKey, userID);

  currentUser.id = userID;
  currentUser.name = 'user_$userID';
}

/// local virtual logout
Future<void> logout() async {
  final prefs = await SharedPreferences.getInstance();
  prefs.remove(cacheUserIDKey);
}

/// on user login
void onUserLogin() {
  /// 4/5. initialized ZegoUIKitPrebuiltCallInvitationService when account is logged in or re-logged in
  ZegoUIKitPrebuiltCallInvitationService().init(
    appID: 1865452545 /*input your AppID*/,
    appSign: "c58d3ae1aa554d7f480dead834cfa8923b5c01461f7c49ec76e52a1f5e14174d",
    userID: currentUser.id,
    userName: currentUser.name,
    notifyWhenAppRunningInBackgroundOrQuit: true,
    showDeclineButton: true,
    isIOSSandboxEnvironment: false,

    androidNotificationConfig: ZegoAndroidNotificationConfig(

      channelID: "ZegoUIKit",

      channelName: "Call Notifications",
      sound: "zego_incoming",
    ),

    plugins: [ZegoUIKitSignalingPlugin()],

  );
}

/// on user logout
void onUserLogout() {
  /// 5/5. de-initialization ZegoUIKitPrebuiltCallInvitationService when account is logged out
  ZegoUIKitPrebuiltCallInvitationService().uninit();
}
