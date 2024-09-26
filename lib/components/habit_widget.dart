// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, use_super_parameters, prefer_const_constructors_in_immutables, library_private_types_in_public_api, unnecessary_string_interpolations, prefer_final_fields, unnecessary_import, no_wildcard_variable_uses

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:habit_tracker/provider/list_habits.dart';

// ignore: must_be_immutable
class HabitWidget extends StatefulWidget {
  /*Lembrete: 
  Ao ocorrer uma mudança no tamanho da ListView, o Flutter reconstroi TODA a lista.
  E eu passei os 3 ultimos como parametros para ao serem reconstruidos nas mudanças de troca de isChecked, eles
  terem seus valores corretos ja que o provider estaria injetando esses valores neles por meio dos parametros.
  Pois se nao fosse assim ao serem reconstruidos o Flutter "reciclaria" o valor do widget de cima dentro da ListView.
*/
  final bool quantitativo;
  final int qtd;
  final String texto;
  final IconData icone;
  bool isChecked;
  TextEditingController controller; //Recebe um controlador novinho sempre
  bool visibility;

  HabitWidget({
    Key? key,
    required this.quantitativo,
    required this.qtd,
    required this.texto,
    required this.icone,
    required this.isChecked,
    required this.controller,
    required this.visibility,
  }) : super(key: key);

  @override
  _HabitWidgetState createState() => _HabitWidgetState();
}

class _HabitWidgetState extends State<HabitWidget> {
  // bool visibility = false;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HabitosController>(
        init: HabitosController(),
        builder: (_) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 10, right: 20),
            child: AnimatedOpacity(
              duration: Duration(milliseconds: 500),
              opacity: (widget.isChecked == true) ? 0.5 : 1.0,
              child: AnimatedScale(
                duration: Duration(milliseconds: 100),
                scale: (widget.isChecked == true) ? 0.95 : 1.0,
                child: Column(
                  children: [
                    GestureDetector(
                      onLongPressStart: (LongPressStartDetails details) {
                        setState(() {
                          widget.visibility = true;
                        });
                      },
                      onTap: () {
                        if (widget.visibility == true) {
                          setState(() {
                            widget.visibility = false;
                          });
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(8),
                                topRight: Radius.circular(8),
                                bottomLeft: !widget.visibility
                                    ? Radius.circular(8)
                                    : Radius.zero,
                                bottomRight: !widget.visibility
                                    ? Radius.circular(8)
                                    : Radius.zero),
                            border: Border(
                              top: BorderSide(color: Colors.white, width: 2),
                              left: BorderSide(color: Colors.white, width: 2),
                              right: BorderSide(color: Colors.white, width: 2),
                              bottom: !widget.visibility
                                  ? BorderSide(color: Colors.white, width: 2)
                                  : BorderSide.none,
                            )),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 60,
                                  padding: EdgeInsets.all(5),
                                  decoration:
                                      BoxDecoration(color: Colors.grey[300]),
                                  alignment: Alignment.centerLeft,
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Icon(
                                      widget.icone,
                                      size: 40,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 15),
                                SizedBox(
                                  width: 200,
                                  child: Text(
                                    "${widget.texto}",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                            (widget.quantitativo == true)
                                ? Row(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 5),
                                        child: Container(
                                          height: 40,
                                          width: 50,
                                          decoration: BoxDecoration(
                                              color: Colors.grey[200],
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              border: Border.all(
                                                  color: Color.fromRGBO(
                                                      72, 68, 78, 1),
                                                  width: 3)),
                                          child: Center(
                                            child: TextField(
                                              controller: widget.controller,
                                              cursorColor: Colors.black,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 18,
                                              ),
                                              textAlign: TextAlign.center,
                                              keyboardType:
                                                  TextInputType.number,
                                              inputFormatters: <TextInputFormatter>[
                                                FilteringTextInputFormatter
                                                    .allow(RegExp(r'[0-9]')),
                                                FilteringTextInputFormatter
                                                    .digitsOnly,
                                                LengthLimitingTextInputFormatter(
                                                    3),
                                              ],
                                              decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  hintText: "0",
                                                  contentPadding:
                                                      EdgeInsets.symmetric(
                                                          vertical: 8)),
                                              onSubmitted: (text) {
                                                if (text.isNotEmpty) {
                                                  if (int.tryParse(text)! >=
                                                      widget.qtd) {
                                                    setState(() {
                                                      widget.isChecked = true;
                                                    });

                                                    _.addListaConcluidas(
                                                        widget.texto);
                                                    _.removeListaHabitos(
                                                        widget.texto);
                                                  } else if (widget.isChecked ==
                                                          true &&
                                                      int.tryParse(text)! <
                                                          widget.qtd) {
                                                    setState(() {
                                                      widget.isChecked = false;
                                                    });
                                                    _.voltaListaHabitos(
                                                        widget.texto);
                                                    _.removeListaConcluidas(
                                                        widget.texto);
                                                  }
                                                }
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                : Transform.scale(
                                    scale: 1.5,
                                    child: Checkbox(
                                      //FAZER COM QUE O CHECKBOX POSSUA UM TERCEIRO ESTADO
                                      value: widget.isChecked,
                                      activeColor: Colors.green,
                                      shape: CircleBorder(),
                                      onChanged: (newBool) async {
                                        setState(() {
                                          widget.isChecked = !widget.isChecked;
                                          // habitos.toggleIsChecked(
                                          //     widget.texto); // Atualiza o estado
                                        });

                                        await Future.delayed(
                                            Duration(milliseconds: 250));
                                        if (newBool == true) {
                                          _.addListaConcluidas(widget.texto);

                                          _.removeListaHabitos(widget.texto);
                                        } else if (newBool == false) {
                                          _.voltaListaHabitos(widget.texto);
                                          _.removeListaConcluidas(widget.texto);
                                        }
                                      },
                                    ),
                                  )
                          ],
                        ),
                      ),
                    ),
                    Visibility(
                      visible: widget.visibility,
                      child: Container(
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
                        child: Row(
                          children: [
                            InkWell(
                              onTap: () {
                                if (_.listaHabitos.any((element) =>
                                    element.texto == widget.texto)) {
                                  _.removeListaHabitos(widget.texto);
                                } else if (_.listaConcluidas.any((element) =>
                                    element.texto == widget.texto)) {
                                  _.removeListaConcluidas(widget.texto);
                                }
                              },
                              child: Container(
                                child: Icon(
                                  Icons.delete_outline_outlined,
                                  size: 40,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                            VerticalDivider(
                              //Arrumar esse divider aqui.
                              thickness: 20,
                              width: 20,
                              color: Colors.black,
                            ),
                            Expanded(
                              child: Text(
                                "${widget.texto}",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 18),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
