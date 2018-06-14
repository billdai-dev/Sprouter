import 'package:scoped_model/scoped_model.dart';
import 'package:sprouter/data/AppRepository.dart';


class SlackAuthModel extends Model {
  final String _slackClientId = "373821001234.373821382898";
  final String _slackClientSecret = "f0ce30315c4689da519c5281883c0667";

  AppRepository repository;

  SlackAuthModel({AppRepository repository}) :
        this.repository = repository ?? AppRepository.repo;

  String get slackClientId => _slackClientId;

  String get slackClientSecret => _slackClientSecret;

  void saveToken(String token) {

  }
}