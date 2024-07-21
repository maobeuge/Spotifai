import 'package:spotifai/constants/ui_helper.dart';
import 'package:spotifai/domain/ai_repository/ai_services.dart';

class AiRepository {
  AiServices aiServices = AiServices();

  Future<ResponseModel> generateVoice(String filePath, String voiceId) async {
    return await aiServices.generateVoice(filePath, voiceId);
  }

  Future<ResponseModel> getVoices() async {
    return await aiServices.getVoices();
  }
}
