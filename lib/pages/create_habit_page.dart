// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_import

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:habit_tracker/components/habit_widget.dart';
import 'package:habit_tracker/provider/list_habits.dart';

class CreateHabitPage extends StatefulWidget {
  const CreateHabitPage({super.key});

  @override
  State<CreateHabitPage> createState() => _CreateHabitPageState();
}

class _CreateHabitPageState extends State<CreateHabitPage> {
  TextEditingController? nome = TextEditingController();
  TextEditingController? qtd = TextEditingController();
  TextEditingController? descricao = TextEditingController();
  bool? isChecked = false;

  int? selectedIconIndex;

  IconData icone = FontAwesomeIcons.dumbbell;

  List<IconData> listIcon = [
    FontAwesomeIcons.book,
    FontAwesomeIcons.pen,
    FontAwesomeIcons.dumbbell,
    FontAwesomeIcons.personRunning,
    FontAwesomeIcons.bicycle,
    FontAwesomeIcons.sackDollar,
    FontAwesomeIcons.video,
    FontAwesomeIcons.laptopCode,
    FontAwesomeIcons.cross,
    FontAwesomeIcons.personPraying,
    FontAwesomeIcons.language,
    FontAwesomeIcons.bottleWater,
    FontAwesomeIcons.cloudSun,
  ];

  @override
  Widget build(BuildContext context) {
    final HabitosController habitosController = Get.find();
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 50),
            Center(
              child: Text("Crie um objetivo",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: Colors.black)),
            ),
            SizedBox(height: 50),
            criarTexto("Insira um nome:"),
            criarTextField(nome),
            SizedBox(height: 50),
            criarTexto("É quantitativo?"),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Transform.scale(
                    scale: 1.8,
                    child: Checkbox(
                        value: isChecked,
                        activeColor: Colors.black,
                        fillColor: MaterialStateProperty.all(Colors.grey[200]),
                        side: BorderSide(color: Colors.white),
                        onChanged: (newBool) {
                          setState(() {
                            isChecked = newBool ?? false;
                          });
                        }),
                  ),
                ),
              ],
            ),
            Visibility(
                visible: isChecked ?? false,
                child: Column(
                  children: [
                    SizedBox(height: 50),
                    criarTexto("Insira a quantidade:"),
                    criarTextField(qtd),
                  ],
                )),
            SizedBox(height: 50),
            criarTexto("Escolha um ícone:"),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                  height: 80,
                  width: double.infinity - 40,
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.white, width: 2.0),
                      borderRadius: BorderRadius.circular(8.0)),
                  child: ListView.builder(
                      itemCount: listIcon.length,
                      padding: EdgeInsets.zero,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                            onTap: () => setState(() {
                                  icone = listIcon[index];
                                  selectedIconIndex = index;
                                }),
                            child: Padding(
                              padding: const EdgeInsets.only(right: 16.0),
                              child: Container(
                                  height: 99,
                                  width: 70,
                                  padding: EdgeInsets.all(5),
                                  color: selectedIconIndex == index
                                      ? Colors.black
                                      : Colors.grey[200],
                                  child: Icon(
                                    listIcon[index],
                                    size: 40,
                                    color: selectedIconIndex == index
                                        ? Colors.white
                                        : Colors.black,
                                  )),
                            ));
                      })),
            ),
            SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    height: 50,
                    width: 150,
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        border: Border.all(color: Colors.white, width: 2.0),
                        borderRadius: BorderRadius.circular(8)),
                    child: Center(
                      child: Text("Cancelar",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 21,
                            color: Colors.black,
                          )),
                    ),
                  ),
                ),
                SizedBox(width: 20),
                GestureDetector(
                  onTap: () {
                    int quantidade = int.tryParse(qtd!.text) ?? 0;

                    habitosController.addListaHabitos(HabitWidget(
                      quantitativo: isChecked ?? false,
                      qtd: quantidade,
                      texto: nome!.text,
                      icone: icone,
                      isChecked: false,
                      controller: TextEditingController(),
                      visibility: false,
                    ));

                    Navigator.pop(context);
                  },
                  child: Container(
                    height: 50,
                    width: 150,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(8)),
                    child: Center(
                      child: Text("Salvar",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 21,
                            color: Colors.white,
                          )),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

Widget criarTexto(String texto) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.only(left: 20, bottom: 10),
        child: Text(
          texto,
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 21, color: Colors.black),
        ),
      ),
    ],
  );
}

Widget criarTextField(controller) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: Container(
      decoration: BoxDecoration(
          color: Colors.grey[200],
          border: Border.all(color: Colors.white, width: 2)),
      child: TextField(
        controller: controller,
        style: TextStyle(fontSize: 18),
        decoration: InputDecoration(
          border: InputBorder.none,
        ),
      ),
    ),
  );
}
