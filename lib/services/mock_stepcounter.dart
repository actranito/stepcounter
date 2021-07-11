import 'dart:async';

import 'package:localstore/localstore.dart';
import 'package:stepcounter/models/stepcounter_data.dart';

class MockStepCounter {
  final db = Localstore.instance;
  int dailyStepCount = 0;
  // Set today to be the value of 12am of the current day
  DateTime today = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );

  DateTime tomorrow = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day + 1,
  );

  /// This methods is used to fecth the daily steps info persisted in the local
  /// memory. If the date of the stored value is from a prior day, the
  /// stepcount is reset.
  void fetchCountFromLocalStorage() async {
    // Fetch the data from local storage
    final data = await db.collection('stepcountInfo').doc('info').get();

    // Parse the timestamp stored with the steps data
    try {
      DateTime storageDate = DateTime.parse((data ?? const {})['date'] ?? "");

      // If the value in store was saved before the beggining of the current day
      // we want to reset the counter
      if (storageDate.isBefore(this.today)) {
        this.dailyStepCount = 0;
      } else {
        // Parse the dailyStepCount in local storage and set it to the dailyStepCount
        //in this class
        this.dailyStepCount = (data ?? const {})['dailyStepCount'] ?? 0;
      }
    } catch (e) {
      // If there is something wrong with any of the parsings, reset the counter
      this.dailyStepCount = 0;
    }
  }

  Stream<StepcounterData> getDelayedRandomValue() async* {
    while (true) {
      // If we are in a new day, reset the counter
      if (DateTime.now().isAfter(this.tomorrow)) {
        this.dailyStepCount = 0;
        this.today = DateTime(
          DateTime.now().year,
          DateTime.now().month,
          DateTime.now().day,
        );
        this.tomorrow = DateTime(
          DateTime.now().year,
          DateTime.now().month,
          DateTime.now().day + 1,
        );
      }

      // Assuming one step every 0.75 secs
      await Future.delayed(Duration(milliseconds: 750));
      // Assuming we burn 100 calories after 2000 steps
      yield StepcounterData(
        steps: this.dailyStepCount++,
        calories: (this.dailyStepCount / 20).floor(),
      );

      // if dailyStepCount is divisible by 10 update the value on
      // local storage
      if (this.dailyStepCount % 10 == 0) {
        db.collection('stepcountInfo').doc('info').set({
          'dailyStepCount': this.dailyStepCount,
          'date': DateTime.now().toIso8601String(),
        });
      }
    }
  }
}
