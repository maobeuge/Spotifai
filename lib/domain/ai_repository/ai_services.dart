import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:spotifai/constants/ui_helper.dart';
import 'package:path_provider/path_provider.dart';
import 'package:spotifai/entities/character.dart';

class AiServices {
  Future<ResponseModel> generateVoice(String filePath, String voiceId) async {
    print(voiceId);
    final request =
        MultipartRequest('POST', Uri.parse('$api/process_audio/$voiceId'));
    request.files.add(await MultipartFile.fromPath('file', filePath));

    final response = await request.send();

    final directory = (await getTemporaryDirectory()).path;
    File file = File('$directory/audio.mp3');

    var bytes = await response.stream.toBytes();
    await file.writeAsBytes(bytes);

    if (response.statusCode == 200) {
      return ResponseModel(
        content: {"file": file.path},
        httpCode: response.statusCode,
        reasonPhrase: response.reasonPhrase,
      );
    }

    return ResponseModel(
      content: {},
      httpCode: response.statusCode,
      reasonPhrase: response.reasonPhrase,
    );
  }

  Future<ResponseModel> getVoices() async {
    final response = await get(Uri.parse('$api/get_all_voices'));

    List<Character> characters = [];
    List<dynamic> jsonBody = json.decode(response.body);
    for (final element in jsonBody) {
      characters.add(Character.fromJson(element));
    }

    if (response.statusCode == 200) {
      return ResponseModel(
        content: {'characters': characters},
        httpCode: response.statusCode,
        reasonPhrase: response.reasonPhrase,
      );
    }

    return ResponseModel(
      content: {} as Map<String, dynamic>,
      httpCode: response.statusCode,
      reasonPhrase: response.reasonPhrase,
    );
  }
}
