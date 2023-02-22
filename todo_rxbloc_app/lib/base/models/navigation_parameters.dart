import '../enums/current_page_enum.dart';

class NavigationParams {
  final NavigationEnum navigationEnum;
  final Object? extraParams;

  const NavigationParams({
    this.extraParams,
    required this.navigationEnum,
  });
}
