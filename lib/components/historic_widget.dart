// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, must_be_immutable, unnecessary_import

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class HistoricWidget extends StatefulWidget {
  final DateTime data;

  final List<String> listaHabitos;
  final List<String> listaConcluidas;
  HistoricWidget(
      {super.key,
      required this.data,
      required this.listaHabitos,
      required this.listaConcluidas});

  @override
  State<HistoricWidget> createState() => _HistoricWidgetState();
}

class _HistoricWidgetState extends State<HistoricWidget> {
  bool visible = false;
  bool checkboxDesligada = false;
  bool checkboxLigada = true;

  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPressStart: (LongPressStartDetails details) {
        setState(() {
          visible = true;
        });
      },
      onTap: () {
        if (visible == true) {
          setState(() {
            visible = false;
          });
        }
      },
      child: Column(
        children: [
          Container(
            height: 80,
            width: double.infinity,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                    bottomLeft: !visible ? Radius.circular(8) : Radius.zero,
                    bottomRight: !visible ? Radius.circular(8) : Radius.zero),
                border: Border(
                  top: BorderSide(color: Colors.white, width: 2),
                  left: BorderSide(color: Colors.white, width: 2),
                  right: BorderSide(color: Colors.white, width: 2),
                  bottom: !visible
                      ? BorderSide(color: Colors.white, width: 2)
                      : BorderSide.none,
                )),
            child: Center(
              child: Text(
                '${DateFormat('d', 'pt_BR').format(widget.data)} de ${DateFormat('MMM', 'pt_BR').format(widget.data)} de ${DateFormat('yyyy', 'pt_BR').format(widget.data)}',
                style: TextStyle(
                    color: Colors.grey[900],
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Visibility(
            visible: visible,
            child: Container(
              height: 115,
              width: double.infinity,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(8),
                      bottomRight: Radius.circular(8),
                      topLeft: Radius.zero,
                      topRight: Radius.zero),
                  border: Border(
                    left: BorderSide(color: Colors.white, width: 2),
                    right: BorderSide(color: Colors.white, width: 2),
                    bottom: BorderSide(color: Colors.white, width: 2),
                  )),
              child: SingleChildScrollView(
                controller: scrollController,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Tarefas não concluídas",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold)),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.zero,
                      itemCount: widget.listaHabitos.length,
                      itemBuilder: (context, index) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Transform.scale(
                              scale: 0.5,
                              child: Checkbox(
                                  value: checkboxDesligada,
                                  shape: CircleBorder(),
                                  fillColor: MaterialStateProperty.all(
                                      Colors.grey[600]),
                                  onChanged: (bool? newBool) {}),
                            ),
                            Text(
                              widget.listaHabitos[index],
                              style: TextStyle(fontSize: 12),
                            ),
                          ],
                        );
                      },
                    ),
                    Text("Tarefas concluídas",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold)),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.zero,
                      itemCount: widget.listaConcluidas.length,
                      itemBuilder: (context, index) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Transform.scale(
                              scale: 0.5,
                              child: Checkbox(
                                  value: checkboxLigada,
                                  shape: CircleBorder(),
                                  activeColor:
                                      const Color.fromARGB(255, 0, 255, 8),
                                  onChanged: (bool? newBool) {}),
                            ),
                            Text(
                              widget.listaConcluidas[index],
                              style: TextStyle(fontSize: 12),
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
