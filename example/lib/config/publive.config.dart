/// Get your own App ID at https://dashboard.agora.io/
String get appId {
  // Allow pass an `appId` as an environment variable with name `TEST_APP_ID` by using --dart-define
  return 'a52004d7aabd4c9f84ef7e73677ded28';
  // return const String.fromEnvironment('ab1ebae85fde41789442aeef60889e77',
  //     defaultValue: '<YOUR_APP_ID>');
}

String get appKey {
  return '1102220607107224#key-customers';
}

/// Please refer to https://docs.agora.io/en/Agora%20Platform/token
String get token {
  // Allow pass a `token` as an environment variable with name `TEST_TOKEN` by using --dart-define
  // return const String.fromEnvironment('006ab1ebae85fde41789442aeef60889e77IABuA1y0sop6mSLwsbf6hAbAbbEmejxDNN4LD9UAfAwu/wPWkk8D1pJPIgCAV/SKN1x+YgQAAQDHGH1iAgDHGH1iAwDHGH1iBADHGH1i',
  //     defaultValue: '<YOUR_TOKEN>');
  return '006a52004d7aabd4c9f84ef7e73677ded28IAAGmFibYgsrKiAk7+ECXnUkEaLOqOPeni+qM5fd90XNgqwY3JIAAAAAEADCmyrTeRu9YgEAAQB5G71i';
}

/// Your channel ID
String get channelId {
  // Allow pass a `channelId` as an environment variable with name `TEST_CHANNEL_ID` by using --dart-define
  // return const String.fromEnvironment(
  //   '123456789321',
  //   defaultValue: '<YOUR_CHANNEL_ID>',
  // );
  return 'zhweb_1319';
}

/// Your int user ID
const int uid = 342;

/// Your user ID for the screen sharing
const int screenSharingUid = 10;

/// Your string user ID
const String stringUid = '0';
