import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:passwordgenerator/application/bloc/saved_password_bloc/saved_password_bloc.dart';

class ScreenSavedPassword extends StatelessWidget {
  const ScreenSavedPassword({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      BlocProvider.of<SavedPasswordBloc>(context).add(GetAllPassword());
    });
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Saved passwords"),
        centerTitle: true,
      ),
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: BlocBuilder<SavedPasswordBloc, SavedPasswordState>(
            builder: (context, state) {
          return state.passwordList.isNotEmpty
              ? ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  itemCount: state.passwordList.length,
                  itemBuilder: (context, index) => ListTile(
                    leading: const CircleAvatar(
                      backgroundImage: AssetImage('asset/key.png'),
                    ),
                    title: Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Text(
                        state.passwordList[index].password!,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Text(
                        state.passwordList[index].complexity!,
                        style: TextStyle(
                            color:
                                state.passwordList[index].complexity == 'Easy'
                                    ? Colors.green
                                    : state.passwordList[index].complexity ==
                                            'Medium'
                                        ? Colors.amber
                                        : Colors.red),
                      ),
                    ),
                    trailing: IconButton(
                        onPressed: () {
                          BlocProvider.of<SavedPasswordBloc>(context).add(
                              RemoveFromDataBase(
                                  id: state.passwordList[index].password!));
                        },
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        )),
                  ),
                  separatorBuilder: (context, index) => const Spacer(),
                )
              : const Center(
                  child: Text(
                    "No saved password",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                );
        }),
      ),
    );
  }
}
