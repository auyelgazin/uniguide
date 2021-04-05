import 'package:get/get.dart';

class Languages extends Translations{

  @override
  Map<String, Map<String, String>> get keys => {
    'en_US': {
      'choose': 'Which language do you want to choose?',
      'welcome': 'Welcome to Uniguide!',
      'welcome_info': 'This application is a social network of the Suleyman Demirel University, to speed up the problem solving process!',
      'login': 'Log In',
      'no_acc': 'Don\'t have an account yet?',
      'signup': 'Sign Up',
    },
    'ru_RU': {
      'choose': 'Какой язык вы хотите выбрать?',
      'welcome': 'Добро пожаловать в UniGuide!',
      'welcome_info': 'Данное приложение является социальной сетью университета им.Сулеймана Демиреля, для ускорения процесса решения проблем!',
      'login': 'Войти',
      'no_acc': 'У вас еще нет аккаунта?',
      'signup': 'Зарегистрироваться',
    },
    'kz_KZ': {
      'choose': 'Қай тілді таңдағыңыз келеді?',
      'welcome': 'UniGuide-қа қош келдіңіз!',
      'welcome_info': 'Бұл қосымша - мәселе шешу процессін жеделдетуге арналған Сүлеймен Демирел Университетінің әлеуметтік желісі!',
      'login': 'Кіру',
      'no_acc': 'Аккаунтыңыз жоқ па?',
      'signup': 'Тіркелу',
    }
    
  };
  
}