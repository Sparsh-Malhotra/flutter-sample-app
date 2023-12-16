import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pathshala/core/models/generic_response.dart';
import 'package:pathshala/pages/home/models/session_model.dart';
import 'package:pathshala/services/api/auth_service.dart';
import 'package:pathshala/utils/functions.dart';

class HomeController extends GetxController {
  Rx<DateTime> selectedDate = DateTime.now().obs;
  Rx<List<SessionModel>> sessions = Rx<List<SessionModel>>([]);
  final AuthService _authService = AuthService();
  RxBool isLogoutLoading = false.obs;

  Future<void> logoutHandler() async {
    try {
      if (GetStorage().hasData('refresh_token')) {
        isLogoutLoading.value = true;
        String refreshToken = GetStorage().read('refresh_token');
        final GenericApiResponse logoutResponse =
            await _authService.logout(refreshToken);

        if (logoutResponse.status == 'success') {
          GetStorage().remove('access_token');
          GetStorage().remove('refresh_token');
          GetStorage().remove('user_details');
          Get.offNamed('/login');
        } else {
          final errorMessage = logoutResponse.error.message;
          showErrorMessage(errorMessage);
        }
      } else {
        GetStorage().remove('user_details');
        Get.offNamed('/login');
      }
    } on Exception catch (e) {
      showErrorMessage(e.toString());
    } finally {
      isLogoutLoading.value = false;
    }
  }
}
