// ignore_for_file: unused_import

import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:habit_tracker/pages/habit_page.dart';
import 'package:habit_tracker/pages/history_page.dart';

class MyPage extends StatefulWidget {
  const MyPage({super.key});

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  int _opcaoSelecionada = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.grey[300],
          elevation: 10,
          currentIndex: _opcaoSelecionada,
          onTap: (opcao) => setState(() => _opcaoSelecionada = opcao),
          fixedColor: Colors.black,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicío'),
            BottomNavigationBarItem(
                icon: Icon(Icons.history), label: 'Histórico'),
          ],
        ),
        body: IndexedStack(
          index: _opcaoSelecionada,
          children: <Widget>[
            const HabitPage(),
            HistoryPage(),
          ],
        ));
  }
}
