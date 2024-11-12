abstract class Env {
  static const String imgHippoUrl =
      String.fromEnvironment('IMG_HIPPO_API_URL', defaultValue: '');

  static const String imgHippoApiKey =
      String.fromEnvironment('IMG_HIPPO_API_KEY', defaultValue: '');
}
