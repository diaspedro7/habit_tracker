// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:habit_tracker/components/habit_widget.dart';
import 'package:habit_tracker/components/historic_widget.dart';
import 'package:get/get.dart';

class HabitosController extends GetxController {
  RxList listaHabitos = <HabitWidget>[
    HabitWidget(
      quantitativo: false,
      qtd: 10,
      texto: "Assistir os vídeos The imbalance Method.",
      icone: FontAwesomeIcons.dumbbell,
      isChecked: false,
      // controllerText: null,
      controller: TextEditingController(), visibility: false,
    ),
    HabitWidget(
      quantitativo: false,
      qtd: 0,
      texto: "Fazer cardio",
      icone: FontAwesomeIcons.dumbbell,
      isChecked: false,
      //controllerText: null,
      controller: TextEditingController(), visibility: false,
    ),
    HabitWidget(
      quantitativo: false,
      qtd: 0,
      texto: "Estudar flutter",
      icone: FontAwesomeIcons.laptopCode,
      isChecked: false,
      //  controllerText: null,
      controller: TextEditingController(), visibility: false,
    ),
    HabitWidget(
      quantitativo: true,
      qtd: 10,
      texto: "Ler 10 páginas de 48 Leis do Poder",
      icone: FontAwesomeIcons.book,
      isChecked: false,
      //   controllerText: null,
      controller: TextEditingController(), visibility: false,
    ),
    HabitWidget(
      quantitativo: true,
      qtd: 10,
      texto: "Oi",
      icone: FontAwesomeIcons.book,
      isChecked: false,
      //  controllerText: null,
      controller: TextEditingController(),
      visibility: false,
    ),
  ].obs;

  RxList listaConcluidas = <HabitWidget>[].obs;

  RxList listaHistorico = <HistoricWidget>[
    // HistoricWidget(
    //   data: DateTime.now(),
    //   listaHabitos: ["Estudar flutter", "Fazer cardio"],
    //   listaConcluidas: ["50 flexões"],
    // ),
  ].obs;

  void addListaHabitos(HabitWidget habito) {
    listaHabitos.add(habito);
    update();
  }

  void removeListaHabitos(String texto) {
    listaHabitos.removeWhere((element) => element.texto == texto);
    update();
  }

  void addListaConcluidas(String texto) {
    HabitWidget habito =
        listaHabitos.firstWhere((element) => element.texto == texto);
    listaConcluidas.add(habito);
    update();
  }

  void voltaListaHabitos(String texto) {
    HabitWidget habito =
        listaConcluidas.firstWhere((element) => element.texto == texto);
    listaHabitos.add(habito);
    update();
  }

  void removeListaConcluidas(String texto) {
    listaConcluidas.removeWhere((element) => element.texto == texto);
    update();
  }

  void limparListas() {
    debugPrint("Listas limpas");
    listaHabitos.clear();
    listaConcluidas.clear();
    update();
  }
}
