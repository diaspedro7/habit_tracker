// ignore_for_file: prefer_const_constructors, unused_import, prefer_const_literals_to_create_immutables, avoid_function_literals_in_foreach_calls, await_only_futures, unused_local_variable

import 'dart:async';
import 'dart:developer';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:get/get.dart';
import 'package:habit_tracker/components/historic_widget.dart';
import 'package:habit_tracker/pages/create_habit_page.dart';
import 'package:habit_tracker/pages/habit_page.dart';
import 'package:habit_tracker/pages/history_page.dart';
import 'package:habit_tracker/pages/mypage.dart';
import 'package:habit_tracker/provider/hive.dart';
import 'package:habit_tracker/provider/list_habits.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  var openBoxConcluidas = await Hive.openBox("concluidas");
  var openBoxHabitos = await Hive.openBox("habitos");
  var openBoxData = await Hive.openBox("data");

  Get.put(HabitosController());

  await initializeDateFormatting('pt_BR');
  await initializeService();

  runApp(MyApp());

  final service = FlutterBackgroundService();
  service.on('updateValue').listen((event) {
    final HabitosController habitosController = Get.find<HabitosController>();
    var now = DateTime.now();

    if (event != null) {
      bool isHabitChecked = event["isHabitChecked"];
      if (isHabitChecked == true && verificaData(now) == false) {
        startDailyCheck();
      }
    }
  });
}

Future<void> initializeService() async {
  final service = FlutterBackgroundService();

  await service.configure(
      iosConfiguration: IosConfiguration(),
      androidConfiguration: AndroidConfiguration(
        onStart: onStart,
        isForegroundMode: false,
      ));

  await service.startService();
}

@pragma('vm:entry-point')
void onStart(ServiceInstance service) async {
  if (service is AndroidServiceInstance) {
    service.on('setAsForeground').listen(
      (event) {
        service.setAsForegroundService();
      },
    );

    service.on('setAsBackground').listen((event) {
      service.setAsBackgroundService();
    });
  }

  service.on('stopService').listen((event) {
    service.stopSelf();
  });

  Timer.periodic(const Duration(minutes: 2), (timer) {
    if (DateTime.now().hour == 12) {
      bool clean = true;
      service.invoke("updateValue", {"isHabitChecked": clean});
    }
  });
}

void startDailyCheck() {
  debugPrint("Entrou na funcao");

  // Define um timer que verifica a cada minuto
  //Timer.periodic(Duration(minutes: 1), (Timer t) async {

  final HabitosController habitsController = Get.find<HabitosController>();
  var now = DateTime.now();
  debugPrint("Entrou no periodic");

  // if (now.minute % 2 != 0 &&
  //     !habitsController.listaHistorico
  //         .any((element) => element.data == now)) {
  debugPrint("Entrou no if");
  debugPrint(habitsController.listaHabitos.toString());

  List<String> textoHabitos = [];
  List<String> textoConcluidas = [];

  habitsController.listaHabitos.forEach((element) {
    textoHabitos.add(element.texto);
  });
  habitsController.listaConcluidas.forEach((element) {
    textoConcluidas.add(element.texto);
  });

  salvaData(now);
  salvaListConcluidas(textoConcluidas);
  salvaListHabitos(textoHabitos);

  habitsController.limparListas();

  //debugPrint(habitsController.listaHabitos.toString());
  // }
  //});
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/Inicio': (context) => HabitPage(),
        '/CriarHabito': (context) => CreateHabitPage(),
        '/Historico': (context) => HistoryPage()
      },
      home: MyPage(),
    );
  }
}
