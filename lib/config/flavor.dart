final flavor = Flavor.fromEnvironment;

enum Flavor {
  dev,
  prod;

  static Flavor get fromEnvironment {
    const flavor = String.fromEnvironment('FLAVOR');
    return Flavor.values.byName(flavor);
  }

  bool get isDev => name == 'dev';
  bool get isProd => name == 'prod';
}
