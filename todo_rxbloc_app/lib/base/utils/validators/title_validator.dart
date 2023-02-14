import 'package:flutter_rx_bloc/rx_form.dart';

String validateTitle(String title) {
  if (title.isEmpty) {
    throw RxFieldException(
      fieldValue: title,
      error: 'You have to have title.',
    );
  }
  return title;
}
