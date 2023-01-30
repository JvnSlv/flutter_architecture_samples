import '../enums/current_page_enum.dart';

class NavigationParams {
  final NavigationEnum navigationEnum;
  final Object? extraParametars;

  const NavigationParams({
    this.extraParametars,
    required this.navigationEnum,
  });
}
