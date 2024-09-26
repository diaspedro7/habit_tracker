// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_import, must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habit_tracker/components/historic_widget.dart';
import 'package:habit_tracker/provider/hive.dart';
import 'package:habit_tracker/provider/list_habits.dart';
import 'package:provider/provider.dart';

class HistoryPage extends StatelessWidget {
  HistoryPage({super.key});

  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(
            Icons.delete,
            color: Colors.white,
          ),
          onPressed: () => deleteData(),
        ),
        title: Center(
          child: Text(
            "Histórico",
            style: TextStyle(
                color: Colors.white, fontSize: 50, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          controller: scrollController,
          child: Column(
            children: [
              SizedBox(height: 30),
              ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                  reverse: true,
                  itemCount: boxHabitos.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: HistoricWidget(
                        data: readData(index),
                        listaHabitos: readHabitos(index),
                        listaConcluidas: readConcluidas(index),
                      ),
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }
}
