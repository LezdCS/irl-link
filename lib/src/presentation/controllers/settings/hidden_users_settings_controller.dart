import 'package:get/get.dart';
import 'package:irllink/src/domain/entities/settings/hidden_user.dart';
import 'package:irllink/src/domain/usecases/settings/get_hidden_users_usecase.dart';
import 'package:irllink/src/domain/usecases/settings/remove_hidden_user_usecase.dart';

class HiddenUsersSettingsController extends GetxController {
  final GetHiddenUsersUseCase getHiddenUsersUseCase;
  final RemoveHiddenUserUseCase removeHiddenUserUseCase;

  HiddenUsersSettingsController({
    required this.getHiddenUsersUseCase,
    required this.removeHiddenUserUseCase,
  });

  RxList<HiddenUser> hiddenUsers = <HiddenUser>[].obs;

  @override
  void onInit() {
    super.onInit();
    getHiddenUsers();
  }

  Future<void> getHiddenUsers() async {
    final result = await getHiddenUsersUseCase();
    result.fold(
      (l) => l.message,
      (r) => hiddenUsers.value = r,
    );
  }

  void removeHiddenUser(HiddenUser user) {
    removeHiddenUserUseCase(params: user);
    getHiddenUsers();
  }
}
