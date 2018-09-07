import 'package:sprouter/data/app_repository.dart';

class OrderDrinkBloc {
  AppRepository repository;

  OrderDrinkBloc({AppRepository repository})
      : this.repository = repository ?? AppRepository.repo {}

  void dispose() {}
}
