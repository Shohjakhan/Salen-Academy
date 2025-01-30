import 'package:get_it/get_it.dart';
import 'src/services/api_client/http/http_service.dart';
import 'src/data/resources/local/isar_db/isar_db.dart';
import 'src/data/resources/local/local_storage.dart';
import 'src/data/resources/remote/api_client.dart';

final sl = GetIt.instance;

Future<void> getItInit() async {
  final ApiClient baseClient = ApiClient(
    apiService: HttpService(),
    //TODO: ENV file
    baseUrl: "https://salenacademy.com/api",
  );
  sl.registerLazySingleton(() => baseClient);
  sl.registerSingleton<LocalStorage>(IsarDB());
}
