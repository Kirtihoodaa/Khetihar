class AppEnv {
  // Reads base URL from --dart-define=API_BASE_URL, falls back to default.
  static const baseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'https://khetihar.jobizoindia.com/api',
  );
}
