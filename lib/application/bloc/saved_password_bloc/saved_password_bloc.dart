import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:passwordgenerator/domain/model/password_model.dart';

part 'saved_password_event.dart';
part 'saved_password_state.dart';

class SavedPasswordBloc extends Bloc<SavedPasswordEvent, SavedPasswordState> {
  SavedPasswordBloc() : super(SavedPasswordInitial(passwordList: [])) {
    on<GetAllPassword>((event, emit) {
      final instanceOfDatabase = PasswordBox.getInstance();
      List<PassWordModel> passwordList = [...instanceOfDatabase.values];
      emit(SavedPasswordInitial(passwordList: passwordList.reversed.toList()));
    });
    on<RemoveFromDataBase>((event, emit) async {
      final instanceOfDatabase = PasswordBox.getInstance();
      List<PassWordModel> passwordList = [...instanceOfDatabase.values];
      int index =
          passwordList.indexWhere((element) => element.password == event.id);
      instanceOfDatabase.deleteAt(index);
      add(GetAllPassword());
    });
  }
}
