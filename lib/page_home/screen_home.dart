import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:passwordgenerator/bloc/home_bloc/home_bloc.dart';

class ScreenHome extends StatelessWidget {
  const ScreenHome({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController fieldController = TextEditingController();
    List<String> complexityList = ['Easy', 'Medium', 'Hard'];

    List<Color> colorsOfBox = [Colors.green, Colors.orange, Colors.red];
    ValueNotifier choiceChipColorValue = ValueNotifier(0);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: size.height * 0.15,
        title: const Text('Password Generator'),
      ),
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: size.height * .08,
              ),
              const Padding(
                padding: EdgeInsets.only(top: 20),
                child: Text(
                  'Generate your password',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                ),
              ),
              SizedBox(
                height: size.height * .08,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: BlocConsumer<HomeBloc, HomeState>(
                  listener: (context, state) {
                    fieldController.text = state.password;
                    Fluttertoast.showToast(
                      msg: "Password generated",
                    );
                  },
                  builder: (context, state) {
                    return CupertinoTextField(
                      placeholder: "Copy your password",
                      readOnly: true,
                      controller: fieldController,
                      suffix: CopyButton(
                          index: choiceChipColorValue.value,
                          fieldController: fieldController,
                          colourList: colorsOfBox),
                      cursorColor: Colors.amber,
                      style: const TextStyle(color: Colors.amber),
                    );
                  },
                ),
              ),
              SizedBox(
                height: size.height * .08,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      const Text(
                        'Complexity',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      ValueListenableBuilder(
                        valueListenable: choiceChipColorValue,
                        builder: (context, value, child) {
                          return Wrap(
                            spacing: 5.0,
                            children: List<Widget>.generate(
                              complexityList.length,
                              (int index) {
                                return ChoiceChip(
                                  disabledColor: Colors.black,
                                  selectedColor: colorsOfBox[index],
                                  label: Text(
                                    complexityList[index],
                                    style: colorsOfBox[index] == Colors.black
                                        ? const TextStyle(color: Colors.black)
                                        : const TextStyle(color: Colors.black),
                                  ),
                                  selected: choiceChipColorValue.value == index,
                                  onSelected: (bool selected) {
                                    choiceChipColorValue.value =
                                        (selected ? index : index);
                                  },
                                );
                              },
                            ).toList(),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: ValueListenableBuilder(
                    valueListenable: choiceChipColorValue,
                    builder: (context, value, child) {
                      return TextButton.icon(
                        onPressed: () {
                          BlocProvider.of<HomeBloc>(context).add(
                              GetPasswordEvent(
                                  complexityList[choiceChipColorValue.value],
                                  8));
                        },
                        icon: const Icon(
                          Icons.recycling,
                          color: Colors.black,
                        ),
                        label: const Text(
                          'Generate password',
                          style: TextStyle(color: Colors.black),
                        ),
                        style: ButtonStyle(
                            elevation: MaterialStateProperty.all(5),
                            backgroundColor: MaterialStateProperty.all(
                                colorsOfBox[choiceChipColorValue.value])),
                      );
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CopyButton extends StatelessWidget {
  const CopyButton({
    super.key,
    required this.fieldController,
    required this.colourList,
    required this.index,
  });
  final TextEditingController fieldController;
  final List<Color> colourList;
  final int index;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.copy),
      tooltip: 'Copy',
      onPressed: () {
        Clipboard.setData(ClipboardData(text: fieldController.text));
        SnackBar snackBar = SnackBar(
            backgroundColor: colourList[index],
            content: const Text(
              "✓ Password copied",
            ));
        ScaffoldMessenger.of(context)
          ..removeCurrentSnackBar()
          ..showSnackBar(snackBar);
      },
    );
  }
}
