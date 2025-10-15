import 'package:learning_app/pages/sign_up/provider/register_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'register_notifier.g.dart';

@riverpod
class RegisterNotifier extends _$RegisterNotifier{
@override
RegisterState build(){
 return RegisterState();
}

void onUserNameChange(String value){
  state = state.coyWith(userName: value);
}
void onUserEmailChange(String value){
  state = state.coyWith(email: value);
}
void onUserPasswordChange(String value){
  state= state.coyWith(password: value);
}
void onUserRePasswordChange(String value){
  state= state.coyWith(rePassword: value);
}
}