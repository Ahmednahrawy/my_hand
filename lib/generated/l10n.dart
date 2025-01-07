// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Welcome to `
  String get welcome {
    return Intl.message(
      'Welcome to ',
      name: 'welcome',
      desc: '',
      args: [],
    );
  }

  /// `Felzaty Admin Dashboard`
  String get appName {
    return Intl.message(
      'Felzaty Admin Dashboard',
      name: 'appName',
      desc: '',
      args: [],
    );
  }

  /// ` 👋👋`
  String get greating {
    return Intl.message(
      ' 👋👋',
      name: 'greating',
      desc: '',
      args: [],
    );
  }

  /// `A New management Experience`
  String get deliveryExperience {
    return Intl.message(
      'A New management Experience',
      name: 'deliveryExperience',
      desc: '',
      args: [],
    );
  }

  /// `Login or signup and discover Felzaty advantages.`
  String get loginPrompt {
    return Intl.message(
      'Login or signup and discover Felzaty advantages.',
      name: 'loginPrompt',
      desc: '',
      args: [],
    );
  }

  /// `Sign In`
  String get signIn {
    return Intl.message(
      'Sign In',
      name: 'signIn',
      desc: '',
      args: [],
    );
  }

  /// `Don't have an account?`
  String get noAccount {
    return Intl.message(
      'Don\'t have an account?',
      name: 'noAccount',
      desc: '',
      args: [],
    );
  }

  /// `Sign Upppp`
  String get signUp {
    return Intl.message(
      'Sign Upppp',
      name: 'signUp',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get language {
    return Intl.message(
      'English',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// `Welcome Back to Falazaty.!`
  String get welcomeBack {
    return Intl.message(
      'Welcome Back to Falazaty.!',
      name: 'welcomeBack',
      desc: '',
      args: [],
    );
  }

  /// `Sign In to Your Account`
  String get signInToAccount {
    return Intl.message(
      'Sign In to Your Account',
      name: 'signInToAccount',
      desc: '',
      args: [],
    );
  }

  /// `Mobile`
  String get mobile {
    return Intl.message(
      'Mobile',
      name: 'mobile',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Remember me`
  String get rememberMe {
    return Intl.message(
      'Remember me',
      name: 'rememberMe',
      desc: '',
      args: [],
    );
  }

  /// `Forgot Password?`
  String get forgotPassword {
    return Intl.message(
      'Forgot Password?',
      name: 'forgotPassword',
      desc: '',
      args: [],
    );
  }

  /// `Saudi Arabia`
  String get saudi {
    return Intl.message(
      'Saudi Arabia',
      name: 'saudi',
      desc: '',
      args: [],
    );
  }

  /// `Egypt`
  String get egypt {
    return Intl.message(
      'Egypt',
      name: 'egypt',
      desc: '',
      args: [],
    );
  }

  /// `Create Your Account`
  String get appTitle {
    return Intl.message(
      'Create Your Account',
      name: 'appTitle',
      desc: '',
      args: [],
    );
  }

  /// `Full Name`
  String get fullName {
    return Intl.message(
      'Full Name',
      name: 'fullName',
      desc: '',
      args: [],
    );
  }

  /// `Email Address`
  String get email {
    return Intl.message(
      'Email Address',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Password`
  String get confirmPassword {
    return Intl.message(
      'Confirm Password',
      name: 'confirmPassword',
      desc: '',
      args: [],
    );
  }

  /// `By creating an account, you agree to our`
  String get termsAndConditions {
    return Intl.message(
      'By creating an account, you agree to our',
      name: 'termsAndConditions',
      desc: '',
      args: [],
    );
  }

  /// `Terms and Conditions`
  String get terms {
    return Intl.message(
      'Terms and Conditions',
      name: 'terms',
      desc: '',
      args: [],
    );
  }

  /// `and`
  String get and {
    return Intl.message(
      'and',
      name: 'and',
      desc: '',
      args: [],
    );
  }

  /// `Privacy Policy`
  String get privacy {
    return Intl.message(
      'Privacy Policy',
      name: 'privacy',
      desc: '',
      args: [],
    );
  }

  /// `you must accept terms and Conditions`
  String get termsMust {
    return Intl.message(
      'you must accept terms and Conditions',
      name: 'termsMust',
      desc: '',
      args: [],
    );
  }

  /// `Register`
  String get registerButton {
    return Intl.message(
      'Register',
      name: 'registerButton',
      desc: '',
      args: [],
    );
  }

  /// `Already have an account?`
  String get alreadyHaveAccount {
    return Intl.message(
      'Already have an account?',
      name: 'alreadyHaveAccount',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your full name`
  String get pleaseName {
    return Intl.message(
      'Please enter your full name',
      name: 'pleaseName',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your email address`
  String get pleaseEmail {
    return Intl.message(
      'Please enter your email address',
      name: 'pleaseEmail',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid email address`
  String get pleaseEmailCorrect {
    return Intl.message(
      'Please enter a valid email address',
      name: 'pleaseEmailCorrect',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your mobile number`
  String get pleasePhone {
    return Intl.message(
      'Please enter your mobile number',
      name: 'pleasePhone',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid mobile number`
  String get pleaseCorrectPhone {
    return Intl.message(
      'Please enter a valid mobile number',
      name: 'pleaseCorrectPhone',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your password`
  String get pleasePassword {
    return Intl.message(
      'Please enter your password',
      name: 'pleasePassword',
      desc: '',
      args: [],
    );
  }

  /// `Please confirm your password`
  String get pleaseConfirmPassword {
    return Intl.message(
      'Please confirm your password',
      name: 'pleaseConfirmPassword',
      desc: '',
      args: [],
    );
  }

  /// `Passwords do not match`
  String get pleasePasswordNotMatch {
    return Intl.message(
      'Passwords do not match',
      name: 'pleasePasswordNotMatch',
      desc: '',
      args: [],
    );
  }

  /// `Sign up successful`
  String get signUpSuccess {
    return Intl.message(
      'Sign up successful',
      name: 'signUpSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Sign up failed.  Please try again.`
  String get signUpFailure {
    return Intl.message(
      'Sign up failed.  Please try again.',
      name: 'signUpFailure',
      desc: '',
      args: [],
    );
  }

  /// `An error occurred.  Please try again.`
  String get genericError {
    return Intl.message(
      'An error occurred.  Please try again.',
      name: 'genericError',
      desc: '',
      args: [],
    );
  }

  /// `Login successful`
  String get loginSuccess {
    return Intl.message(
      'Login successful',
      name: 'loginSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Login failed.  Please try again.`
  String get loginFailure {
    return Intl.message(
      'Login failed.  Please try again.',
      name: 'loginFailure',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
