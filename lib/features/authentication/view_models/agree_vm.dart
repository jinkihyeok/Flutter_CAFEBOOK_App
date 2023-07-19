import 'package:caffe_app/features/authentication/models/agree_model.dart';
import 'package:flutter/material.dart';

class AgreeViewModel extends ChangeNotifier {
  List<Agree> agrees = [
    Agree(
      title: '만 14세 이상입니다. *',
      isAgree: false,
    ),
    Agree(
      title: '이용 약관에 동의합니다. *',
      isAgree: false,
    ),
    Agree(
      title: '개인정보 수집 및 이용에 동의합니다. *',
      isAgree: false,
    ),
    Agree(
      title: '개인정보 수집 및 이용에 동의합니다.(선택)',
      isAgree: false,
    ),
    Agree(
      title: '마케팅 정보 수신에 동의합니다.(선택)',
      isAgree: false,
    ),
  ];

  bool get isAllAgree {
    return agrees.every((agree) => agree.isAgree);
  }

  bool get isEssentialAgree {
    return agrees
        .where((agree) => agree.title.contains('*'))
        .every((agree) => agree.isAgree);
  }

  void toggleAgree(int index) {
    agrees[index].isAgree = !agrees[index].isAgree;
    notifyListeners();
  }

  void toggleAllAgree() {
    final newValue = !isAllAgree;
    for (final agree in agrees) {
      agree.isAgree = newValue;
    }
    notifyListeners();
  }
}
