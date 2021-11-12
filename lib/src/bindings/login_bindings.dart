import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:irllink/src/data/repositories/twitch_repository_impl.dart';
import 'package:irllink/src/domain/usecases/twitch_usecase.dart';
import 'package:irllink/src/presentation/controllers/login_view_controller.dart';
import 'package:irllink/src/presentation/events/login_events.dart';

class LoginBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginViewController>(
      () => LoginViewController(
        loginEvents: LoginEvents(
          twitchUseCase: TwitchUseCase(
            twitchRepository: TwitchRepositoryImpl(),
          ),
        ),
      ),
    );
    Get.find<LoginViewController>();
  }
}
