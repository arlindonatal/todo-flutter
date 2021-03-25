import 'package:flutter_modular/flutter_modular.dart';
import 'pages/todo_page.dart';
import 'controllers/todo_controller.dart';

class TodoModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => TodoController()),
      ];

  @override
  List<Router> get routers => [
        Router(Modular.initialRoute, child: (_, args) => TodoPage()),
      ];

  static Inject get to => Inject<TodoModule>.of();
}
