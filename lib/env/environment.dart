class Environment {
  static const baseUrl = String.fromEnvironment('BASE_URL');
  static const isDev = bool.fromEnvironment('IS_DEV');

  static final Map<String, dynamic> values = {
    'BASE_URL': baseUrl,
    'IS_DEV': isDev,
  };
}
