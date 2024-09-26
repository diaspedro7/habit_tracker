// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_import, avoid_function_literals_in_foreach_calls, no_wildcard_variable_uses

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:habit_tracker/provider/list_habits.dart';
import 'package:habit_tracker/main.dart';

class HabitPage extends StatefulWidget {
  const HabitPage({super.key});

  @override
  State<HabitPage> createState() => _HabitPageState();
}

class _HabitPageState extends State<HabitPage> {
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HabitosController>(
        init: HabitosController(),
        builder: (_) {
          return Scaffold(
            backgroundColor: Colors.black,
            body: SingleChildScrollView(
              controller: scrollController,
              child: Center(
                child: Stack(
                  children: [
                    Column(
                      children: [
                        SizedBox(height: 220),
                        Container(
                            width: double.infinity,
                            height: (_.listaHabitos.length +
                                                _.listaConcluidas.length) *
                                            100 +
                                        142 >
                                    670
                                ? (_.listaHabitos.length +
                                            _.listaConcluidas.length) *
                                        100 +
                                    170
                                : 700,
                            decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(28),
                                    topRight: Radius.circular(28))))
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //Texto GRANDE
                        SizedBox(height: 90),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                            "${24 - DateTime.now().hour}h\n restantes.",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 60,
                                height: 1.0),
                          ),
                        ),
                        SizedBox(height: 30),
                        //Texto quantidade tarefas

                        Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${_.listaHabitos.length + _.listaConcluidas.length} tarefas para hoje",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              //Texto com quantidade ja feita
                              Row(
                                children: [
                                  Icon(
                                    Icons.circle, //Esse icon aqui
                                    color: (_.listaConcluidas.isNotEmpty)
                                        ? const Color.fromARGB(255, 0, 255, 8)
                                        : Colors.grey.shade800,
                                    size: 16,
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    "${_.listaConcluidas.length} tarefas concluídas",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              //Botao adicionar nova tarefa
                              InkWell(
                                onTap: () {
                                  //Navigator.pushNamed(context, '/CriarHabito');
                                  startDailyCheck();
                                },
                                child: Center(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Container(
                                      width: 300,
                                      height: 45,
                                      padding: EdgeInsets.all(8),
                                      decoration:
                                          BoxDecoration(color: Colors.black),
                                      child: Center(
                                        child: Text(
                                          "Adicionar nova tarefa",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              ListView.builder(
                                shrinkWrap:
                                    true, //permite a listview se encaixar na column
                                physics:
                                    NeverScrollableScrollPhysics(), //faz com que a lista nao se mexa
                                padding: EdgeInsets.zero,
                                itemCount: _.listaHabitos.length,
                                itemBuilder: (context, index) {
                                  return _.listaHabitos[index];
                                },
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                "Tarefas concluídas:",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24,
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              ListView.builder(
                                shrinkWrap:
                                    true, //permite a listview se encaixar na column
                                physics:
                                    NeverScrollableScrollPhysics(), //faz com que a lista nao se mexa
                                padding: EdgeInsets.zero,
                                itemCount: _.listaConcluidas.length,
                                itemBuilder: (context, index) {
                                  return _.listaConcluidas[index];
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
} //Meu código
