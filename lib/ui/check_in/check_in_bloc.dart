import 'package:sprouter/data/app_repository.dart';

class CheckInBloc {
  AppRepository repository;

  CheckInBloc({AppRepository repository})
      : this.repository = repository ?? AppRepository.repo {}

  void dispose() {}
}
