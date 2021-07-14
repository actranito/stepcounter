/// This model will be used to store the data received from
/// the stepcounter device
class StepcounterData {
  late int steps;
  late int calories;

  StepcounterData({
    required this.steps,
    required this.calories,
  });
}
