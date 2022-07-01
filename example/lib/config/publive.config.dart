/// PubLive Config
String get appId {
  // Allow pass an `appId` as an environment variable with name `TEST_APP_ID` by using --dart-define
  return const String.fromEnvironment('TEST_APP_ID',
      defaultValue: '4445e74bef524112a64c4b1730bec033');
}

String get appKey {
  return const String.fromEnvironment('TEST_APP_KEY',
      defaultValue: '1102220607107224#key-customers');
}

String get token {
  // Allow pass a `token` as an environment variable with name `TEST_TOKEN` by using --dart-define
  return const String.fromEnvironment('TEST_TOKEN',
      defaultValue: '0064445e74bef524112a64c4b1730bec033IABjOMTfYfjpnXDWvNMU/d5MWfPEWlGkeAmxpkFcQtccTRUyWI8AAAAAEACiqr7MbPS/YgEAAQBt9L9i');
}

/// Your channel ID
String get channelId {
  // Allow pass a `channelId` as an environment variable with name `TEST_CHANNEL_ID` by using --dart-define
  return const String.fromEnvironment(
    'TEST_CHANNEL_ID',
    defaultValue: 'publive_test_001',
  );
}

/// Your int user ID
const int uid = 1;
