import 'package:get/get.dart';
import 'utils/langs/ar.dart';
import 'utils/langs/en.dart';
import 'utils/langs/fr.dart';

class Translation extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en': en,
        'ar': ar,
        'fr': fr,
      };
}
