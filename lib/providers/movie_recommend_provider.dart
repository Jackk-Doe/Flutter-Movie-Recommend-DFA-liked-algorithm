import 'package:flutter/material.dart';

import '../models/models.dart';


/// This provider is to keep record of user's interested Movie genre
class MovieRecommendProvider extends ChangeNotifier {

  /// [_interested] <GenreID, count> : records user's interested genre
  Map<int, int> _interested = {};

  Map<int, int> get interestedGenre => _interested;

  void recordInterestGenre(MovieGenre interestGenre) {
    int currentCount = _interested.putIfAbsent(interestGenre.id, () => 0);
    _interested[interestGenre.id] = currentCount + 1;
  }
}
