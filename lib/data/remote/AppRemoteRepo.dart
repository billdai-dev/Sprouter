import 'package:sprouter/data/remote/RemoteRepo.dart';

class AppRemoteRepo implements RemoteRepo{
  static final AppRemoteRepo _repo = new AppRemoteRepo.internal();

  static AppRemoteRepo get repo => _repo;

  String _slackToken;

  AppRemoteRepo.internal(){

  }
}