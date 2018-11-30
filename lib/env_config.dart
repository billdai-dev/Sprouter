enum Flavor { DEVELOPMENT, RELEASE }

class EnvConfig {
  static Flavor appFlavor = Flavor.DEVELOPMENT;

  static String get jibbleUserId {
    switch (appFlavor) {
      case Flavor.RELEASE:
        return "U49CJ7N4E";
      case Flavor.DEVELOPMENT:
      default:
        return "UB0APDPFT";
    }
  }

  static String get lunchChannelId {
    switch (appFlavor) {
      case Flavor.RELEASE:
        return "C1BH2VB7F";
      case Flavor.DEVELOPMENT:
      default:
        return "CAZQ503L2";
    }
  }

  static String get slackClientId {
    switch (appFlavor) {
      case Flavor.RELEASE:
        return "4712870764.493196857943";
      case Flavor.DEVELOPMENT:
      default:
        return "373821001234.373821382898";
    }
  }

  static String get slackClientSecret {
    switch (appFlavor) {
      case Flavor.RELEASE:
        return "092291195e9831ef98588df2f1a0eddb";
      case Flavor.DEVELOPMENT:
      default:
        return "f0ce30315c4689da519c5281883c0667";
    }
  }
}
