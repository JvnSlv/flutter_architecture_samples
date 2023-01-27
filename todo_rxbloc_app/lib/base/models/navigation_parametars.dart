import '../enums/current_page_enum.dart';

class NavigationParametars {
  final NavigationEnum navigationEnum;
  final Object? extraParametars;

  const NavigationParametars({
    this.extraParametars,
    required this.navigationEnum,
  });
}
