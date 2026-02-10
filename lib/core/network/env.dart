class Env {
  static const String apiBaseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'https://dragonball-api.com/api',
  );

  static const String webViewUrl = String.fromEnvironment(
    'WEBVIEW_URL',
    defaultValue: 'http://192.168.1.3:4200',
  );
}