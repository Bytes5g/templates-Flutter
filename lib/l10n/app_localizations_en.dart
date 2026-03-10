/// التوطين الإنجليزي
library;

import 'app_localizations.dart';

/// توطين اللغة الإنجليزية
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn() : super('en');

  @override String get appName => 'Flutter Template';
  @override String get loading => 'Loading...';
  @override String get retry => 'Retry';
  @override String get cancel => 'Cancel';
  @override String get confirm => 'Confirm';
  @override String get save => 'Save';
  @override String get edit => 'Edit';
  @override String get delete => 'Delete';
  @override String get search => 'Search';
  @override String get filter => 'Filter';
  @override String get back => 'Back';
  @override String get next => 'Next';
  @override String get previous => 'Previous';
  @override String get done => 'Done';
  @override String get yes => 'Yes';
  @override String get no => 'No';
  @override String get close => 'Close';
  @override String get share => 'Share';
  @override String get home => 'Home';
  @override String get categories => 'Categories';
  @override String get profile => 'Profile';
  @override String get settings => 'Settings';
  @override String get notifications => 'Notifications';
  @override String get login => 'Sign In';
  @override String get register => 'Create Account';
  @override String get logout => 'Sign Out';
  @override String get email => 'Email';
  @override String get password => 'Password';
  @override String get forgotPassword => 'Forgot Password?';
  @override String get loginButton => 'Sign In';
  @override String get errorTitle => 'An Error Occurred';
  @override String get errorGeneral => 'An unexpected error occurred. Please try again.';
  @override String get errorNetwork => 'Unable to connect to the server. Check your internet connection.';
  @override String get errorOffline => 'No internet connection.';
  @override String get errorNotFound => 'The requested content was not found.';
  @override String get errorServer => 'Server error. Please try again later.';
  @override String get errorUnauthorized => 'Session expired. Please sign in again.';
  @override String get offlineBannerMessage => 'You are offline. Showing cached data.';
  @override String offlineQueueMessage(int count) =>
      count == 1
          ? '1 operation will be sent when connection is restored.'
          : '$count operations will be sent when connection is restored.';
  @override String get emptyTitle => 'No Content';
  @override String get emptyDescription => 'No content found. Check back later.';
  @override String emptySearchDescription(String query) =>
      'No results found for "$query".';
  @override String get page404Title => 'Page Not Found';
  @override String get page404Description => 'The link you entered does not exist or has been changed.';
  @override String get goHome => 'Go to Home';
  @override String get searchHint => 'Search here...';
  @override String searchResultsFor(String query) => 'Search results for: $query';
  @override String get seeAll => 'See All';
  @override String get viewDetails => 'View Details';
  @override String get readMore => 'Read More';
  @override String get showLess => 'Show Less';
  @override String get language => 'Language';
  @override String get languageArabic => 'العربية';
  @override String get languageEnglish => 'English';
  @override String get theme => 'Theme';
  @override String get themeLight => 'Light';
  @override String get themeDark => 'Dark';
  @override String get themeSystem => 'System';
  @override String validationRequired(String field) => '$field is required';
  @override String get validationEmail => 'Invalid email format';
  @override String get validationPasswordLength => 'Password must be at least 8 characters';
  @override String get validationPasswordUppercase => 'Password must contain at least one uppercase letter';
  @override String get validationPasswordNumber => 'Password must contain at least one number';
}
