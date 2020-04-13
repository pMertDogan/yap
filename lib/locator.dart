import 'package:get_it/get_it.dart';
import 'package:todo/viewModels/subjectVM.dart';

final getIt = GetIt.instance;

void setupLocator() {
  getIt.registerSingleton<SubjectVM>(SubjectVM());
}
