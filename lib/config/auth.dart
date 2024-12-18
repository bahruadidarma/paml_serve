import 'package:paml_serve/app/models/user.dart';

final Map<String, dynamic> authConfig = {
  'guards': {
    'default': {
      'provider': User(),
    },
  },
  'secret': '7pcF1bc5D5tFTtqkGlN29nothe4KtGuJOGJyrKnGP48',
};