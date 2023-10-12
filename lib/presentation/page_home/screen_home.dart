import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:passwordgenerator/application/bloc/home_bloc/home_bloc.dart';
import 'package:passwordgenerator/domain/model/password_model.dart';
import 'package:passwordgenerator/presentation/page_savedpassword/screen_saved_password.dart';

class ScreenHome extends StatelessWidget {
  const ScreenHome({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController fieldController = TextEditingController();

    List<String> complexityList = ['Easy', 'Medium', 'Hard'];

    List<Color> colorsOfBox = [Colors.green, Colors.orange, Colors.red];
    ValueNotifier complexityNotifier = ValueNotifier(0);
    ValueNotifier lengthNotifier = ValueNotifier(8);

    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: size.height * 0.15,
        title: const Text('Password Generator'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ScreenSavedPassword(),
                  ));
            },
            icon: const Icon(Icons.save),
            tooltip: 'Saved passwords',
          )
        ],
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
                    return SizedBox(
                      height: 60,
                      child: CupertinoTextField(
                        placeholder: "Copy your password",
                        readOnly: true,
                        controller: fieldController,
                        suffix: Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                BlocProvider.of<HomeBloc>(context).add(
                                    AddPasswordToDataBase(PassWordModel(
                                        password: fieldController.text,
                                        complexity: complexityList[
                                            complexityNotifier.value])));
                              },
                              icon: const Icon(Icons.save),
                              tooltip: 'Save password',
                            ),
                            CopyButton(
                                index: complexityNotifier.value,
                                fieldController: fieldController,
                                colourList: colorsOfBox),
                          ],
                        ),
                        cursorColor: Colors.amber,
                        style:
                            const TextStyle(color: Colors.amber, fontSize: 23),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                height: size.height * .08,
              ),
              const Text(
                'Complexity',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              ValueListenableBuilder(
                valueListenable: complexityNotifier,
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
                          selected: complexityNotifier.value == index,
                          onSelected: (bool selected) {
                            complexityNotifier.value =
                                (selected ? index : index);
                          },
                        );
                      },
                    ).toList(),
                  );
                },
              ),
              SizedBox(
                height: size.height * .03,
              ),
              const Text(
                'Length',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SliderWidget(
                colourNotifier: complexityNotifier,
                lengthNotifier: lengthNotifier,
                colourList: colorsOfBox,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: ValueListenableBuilder(
                    valueListenable: complexityNotifier,
                    builder: (context, value, child) {
                      return TextButton.icon(
                        onPressed: () {
                          BlocProvider.of<HomeBloc>(context).add(
                              GetPasswordEvent(
                                  complexityList[complexityNotifier.value],
                                  lengthNotifier.value));
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
                                colorsOfBox[complexityNotifier.value])),
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
        BlocProvider.of<HomeBloc>(context)
            .add(CopyPassword(fieldController.text));
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

class SliderWidget extends StatelessWidget {
  const SliderWidget(
      {super.key,
      required this.lengthNotifier,
      required this.colourList,
      required this.colourNotifier});
  final ValueNotifier lengthNotifier;
  final List<Color> colourList;
  final ValueNotifier colourNotifier;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 10.0),
      child: ValueListenableBuilder(
          valueListenable: lengthNotifier,
          builder: (context, value, child) {
            return ValueListenableBuilder(
                valueListenable: colourNotifier,
                builder: (context, value, child) {
                  return Row(
                    children: [
                      Expanded(
                        child: Slider(
                          inactiveColor: Colors.white30,
                          thumbColor: colourList[colourNotifier.value],
                          activeColor: colourList[colourNotifier.value],
                          value: lengthNotifier.value + .0,
                          onChanged: (value) {
                            lengthNotifier.value = value.toInt();
                          },
                          min: 8,
                          max: 20,
                          divisions: 12,
                        ),
                      ),
                      Container(
                        width: 30,
                        height: 25,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            gradient: const LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Colors.white60,
                                  Colors.white60,
                                  Colors.white54,
                                  Colors.white38,
                                ],
                                stops: [
                                  0.1,
                                  0.15,
                                  0.2,
                                  0.5
                                ])),
                        child: Center(
                          child: Text(
                            '${lengthNotifier.value}',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.black),
                          ),
                        ),
                      ),
                    ],
                  );
                });
          }),
    );
  }
}
