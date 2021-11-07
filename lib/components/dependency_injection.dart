import 'package:rightnow/components/db_service.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';

class DependencyInjection {
  Injector initialise(Injector injector) {
    //injector.map<SocketMessagesCounter>((i) => SocketMessagesCounter(), isSingleton: true);
    injector.map<DbService>((i) => DbService(), isSingleton: true);
    return injector;
  }
}
