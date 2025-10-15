// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'author_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$authorControllerHash() => r'8e833b874e5ed5b411a886d2807a4952ffd112e8';

/// See also [AuthorController].
@ProviderFor(AuthorController)
final authorControllerProvider = AutoDisposeAsyncNotifierProvider<
  AuthorController,
  List<CourseItem>?
>.internal(
  AuthorController.new,
  name: r'authorControllerProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$authorControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$AuthorController = AutoDisposeAsyncNotifier<List<CourseItem>?>;
String _$courseAuthorControllerHash() =>
    r'4fca40c7b7a1908a01bf5f12e48b39cf332d9a94';

/// See also [CourseAuthorController].
@ProviderFor(CourseAuthorController)
final courseAuthorControllerProvider = AutoDisposeAsyncNotifierProvider<
  CourseAuthorController,
  AuthorItem?
>.internal(
  CourseAuthorController.new,
  name: r'courseAuthorControllerProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$courseAuthorControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$CourseAuthorController = AutoDisposeAsyncNotifier<AuthorItem?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
