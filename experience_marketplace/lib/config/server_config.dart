/// Server configuration for the Experience Marketplace app
class ServerConfig {
  // Server URLs
  static const String onlineServerUrl =
      'https://serverpod-api-1013500213689.us-central1.run.app/';
  static const String localhostUrl = 'http://localhost:8080/';

  // Environment flags
  static const bool _useLocalhost =
      bool.fromEnvironment('USE_LOCALHOST', defaultValue: false);
  static const bool isMockMode =
      bool.fromEnvironment('USE_MOCK_DATA', defaultValue: false);
  static const String _customServerUrl =
      String.fromEnvironment('SERVER_URL', defaultValue: '');

  /// Gets the server URL based on configuration priority:
  /// 1. Custom SERVER_URL environment variable
  /// 2. USE_LOCALHOST flag
  /// 3. Default to online server
  static String get serverUrl {
    if (isMockMode) {
      // In mock mode, no server should be used
      return 'mock://local';
    }
    if (_customServerUrl.isNotEmpty) {
      return _customServerUrl;
    }

    if (_useLocalhost) {
      return localhostUrl;
    }

    // Default to online server
    return onlineServerUrl;
  }

  /// Returns true if using localhost
  static bool get isLocalhost => _useLocalhost;

  /// Returns true if using custom server URL
  static bool get hasCustomUrl => _customServerUrl.isNotEmpty;

  /// Returns the environment configuration as a readable string
  static String get configInfo =>
      'Server: $serverUrl | Localhost: $isLocalhost | Mock: $isMockMode | Custom: ${hasCustomUrl ? '"$_customServerUrl"' : 'false'}';

  /// Prints configuration info to console
  static void logConfig() {
    print('🌐 Experience Marketplace Server Config:');
    print('   - URL: $serverUrl');
    print('   - Using localhost: $isLocalhost');
    print('   - Mock mode: $isMockMode');
    print('   - Custom URL: ${hasCustomUrl ? _customServerUrl : 'none'}');
    final envLabel = isMockMode
        ? 'Mock'
        : (isLocalhost
            ? 'Development'
            : (hasCustomUrl ? 'Custom' : 'Production'));
    print('   - Environment: $envLabel');
  }
}
