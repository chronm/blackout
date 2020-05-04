import 'package:Blackout/models/modification.dart';

abstract class Storageable<S, T> {
  T toCompanion();
  List<Modification> getModifications(S from);
}
