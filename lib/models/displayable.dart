class DisplayableState {
  bool expiredOrNotification;
  bool tooFewAvailable;

  DisplayableState(this.expiredOrNotification, this.tooFewAvailable);
}

abstract class Displayable {
  String get title;
  double get amount;
  bool get expiredOrNotification;
  bool get tooFewAvailable;

  DisplayableState get state => DisplayableState(expiredOrNotification, tooFewAvailable);
}
