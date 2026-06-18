import 'dart:async';

import 'package:in_app_review/in_app_review.dart';

class GetReviewUserService {
  static getAvaluation() {
    Timer(Duration(minutes: 5), () {
      InAppReview.instance.requestReview();
    });
  }
}
