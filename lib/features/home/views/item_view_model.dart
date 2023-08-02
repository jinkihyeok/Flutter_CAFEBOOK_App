import 'package:caffe_app/data/cafe_repository.dart';
import 'package:flutter/cupertino.dart';

import '../../../data/cafe_model.dart';

class ItemViewModel extends ChangeNotifier {
  final CafeRepository _repository;

  ItemViewModel({required CafeRepository repository})
      : _repository = repository;

  final String _imageUrl =
      "https://search.pstatic.net/common/?src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20230318_39%2F1679104703292HUfgW_JPEG%2FKakaoTalk_20230317_132200432_20.jpg";

  String get imageUrl => _imageUrl;

  List<Cafe> get cafes => _repository.cafes;
}
