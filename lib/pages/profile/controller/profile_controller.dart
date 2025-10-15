import 'package:learning_app/commons/models/entities.dart';
import 'package:learning_app/global.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'profile_controller.g.dart';

@riverpod
class ProfileController extends _$ProfileController {
  @override
  UserProfile build() => Global.storageService.getUserProfile();
}
