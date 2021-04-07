import 'package:get/get.dart';

class Languages extends Translations{

  @override
  Map<String, Map<String, String>> get keys => {
    'en_US': {
      // Onboarding
      'choose': 'Which language do you want to choose?',
      'welcome': 'Welcome to Uniguide!',
      'welcome_info': 'This application is a social network of the Suleyman Demirel University, to speed up the problem solving process!',
      'login': 'Log In',
      'have_acc?': 'Already have an account?',
      'signup': 'Sign Up',

      // Authorize
      'login_info': 'Log in with your SDU email',
      'email_address': 'Email address',
      'password': 'Password',
      'forgot_pass?': 'Forgot password?',
      'no_acc?': 'Don\'t have an account?',
      'signup_info': 'Create your own account',
      'full_name': 'Full name',

    },
    'ru_RU': {
      'choose': 'Какой язык вы хотите выбрать?',
      'welcome': 'Добро пожаловать в UniGuide!',
      'welcome_info': 'Данное приложение является социальной сетью университета им.Сулеймана Демиреля, для ускорения процесса решения проблем!',
      'login': 'Войти',
      'have_acc?': 'У вас уже есть аккаунт?',
      'signup': 'Зарегистрироваться',
    },
    'kz_KZ': {
      'choose': 'Қай тілді таңдағыңыз келеді?',
      'welcome': 'UniGuide-қа қош келдіңіз!',
      'welcome_info': 'Бұл қосымша - мәселе шешу процессін жеделдетуге арналған Сүлеймен Демирел Университетінің әлеуметтік желісі!',
      'login': 'Кіру',
      'have_acc?': 'Аккаунтыңыз бар ма?',
      'signup': 'Тіркелу',
    }
    
  };
  
}