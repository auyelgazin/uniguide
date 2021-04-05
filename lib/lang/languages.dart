import 'package:get/get.dart';

class Languages extends Translations{

  @override
  Map<String, Map<String, String>> get keys => {
    'en_US': {
      'choose': 'Choose',
      'welcome': 'Welcome!',
      'welcome_info': 'This application is a social network of the Suleyman Demirel University, to speed up the problem solving process!'
    },
    'kz_KZ': {
      'choose': 'Таңдаңыз',
      'welcome': 'Қош келдіңіз!',
      'welcome_info': 'Бұл қосымша - мәселе шешу процессін жеделдетуге арналған Сүлеймен Демирел Университетінің әлеуметтік желісі!'
    },
    'ru_RU': {
      'choose': 'Выберите язык',
      'welcome': 'Добро пожаловать!',
      'welcome_info': 'Данное приложение является социальной сетью университета им.Сулеймана Демиреля, для ускорения процесса решения проблем!'
    }
  };
  
}