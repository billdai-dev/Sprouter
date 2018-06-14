import 'package:scoped_model/scoped_model.dart';
import 'package:sprouter/data/AppRepository.dart';

class MainModel extends Model {
  AppRepository repository;

  MainModel({AppRepository repository})
      :this.repository = repository ?? AppRepository.repo;

}

