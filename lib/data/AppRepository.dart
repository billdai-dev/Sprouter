import 'package:sprouter/data/local/AppLocalRepo.dart';
import 'package:sprouter/data/local/LocalRepo.dart';
import 'package:sprouter/data/remote/AppRemoteRepo.dart';
import 'package:sprouter/data/remote/RemoteRepo.dart';

class AppRepository {
  static final AppRepository _repo = new AppRepository._internal();

  static AppRepository get repo => _repo;

  RemoteRepo _remoteRepo;
  LocalRepo _localRepo;

  AppRepository._internal() {
    _remoteRepo = AppRemoteRepo.repo;
    _localRepo = AppLocalRepo.repo;
  }

  void saveSlackToken(String token) {
    _remoteRepo.setSlackToken(token);
  }
}