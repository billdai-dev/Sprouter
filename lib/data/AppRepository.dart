import 'package:rxdart/rxdart.dart';
import 'package:sprouter/data/Repository.dart';
import 'package:sprouter/data/local/AppLocalRepo.dart';
import 'package:sprouter/data/local/LocalRepo.dart';
import 'package:sprouter/data/remote/AppRemoteRepo.dart';
import 'package:sprouter/data/remote/RemoteRepo.dart';

class AppRepository implements Repository {
  static final AppRepository _repo = AppRepository._internal();

  static AppRepository get repo => _repo;

  RemoteRepo _remoteRepo;
  LocalRepo _localRepo;

  AppRepository._internal() {
    _remoteRepo = AppRemoteRepo.repo;
    _localRepo = AppLocalRepo.repo;
  }

  @override
  Observable<String> getSlackUserData({String token}) {
    Observable<String> tokenObservable =
    token == null ? _localRepo.loadSlackToken() : Observable.just(token);
    return tokenObservable.concatMap((token) {
      return _remoteRepo.getSlackUserData(token);
    }).map((user) {
      return user?.user?.name;
    });
  }
}