import 'package:hive_flutter/hive_flutter.dart';

final boxConcluidas = Hive.box("concluidas");
final boxHabitos = Hive.box("habitos");
final boxData = Hive.box("data");

void salvaListConcluidas(List listConcluidas) {
  boxConcluidas.add(listConcluidas);
}

void salvaListHabitos(List listHabitos) {
  boxHabitos.add(listHabitos);
}

void salvaData(DateTime data) {
  boxData.add(data);
}

List<String> readConcluidas(int key) {
  return boxConcluidas.getAt(key);
}

List<String> readHabitos(int key) {
  return boxHabitos.getAt(key);
}

DateTime readData(int key) {
  return boxData.getAt(key);
}

bool verificaData(DateTime time) {
  for (int i = 0; i < boxData.length; i++) {
    if (boxData.getAt(i).day == time.day &&
        boxData.getAt(i).month == time.month &&
        boxData.getAt(i).year == time.year) {
      return true;
    }
  }

  return false;
}

void deleteData() async {
  boxHabitos.deleteAll(boxHabitos.keys);
  boxConcluidas.deleteAll(boxConcluidas.keys);
  boxData.deleteAll(boxData.keys);
  //fazer de alguma maneira para a tela ser reconstruida
}
