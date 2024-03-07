// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ReclamationsEvent.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ReclamationsEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() myReclamations,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? myReclamations,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? myReclamations,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(MyReclamations value) myReclamations,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(MyReclamations value)? myReclamations,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(MyReclamations value)? myReclamations,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReclamationsEventCopyWith<$Res> {
  factory $ReclamationsEventCopyWith(
          ReclamationsEvent value, $Res Function(ReclamationsEvent) then) =
      _$ReclamationsEventCopyWithImpl<$Res, ReclamationsEvent>;
}

/// @nodoc
class _$ReclamationsEventCopyWithImpl<$Res, $Val extends ReclamationsEvent>
    implements $ReclamationsEventCopyWith<$Res> {
  _$ReclamationsEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$MyReclamationsImplCopyWith<$Res> {
  factory _$$MyReclamationsImplCopyWith(_$MyReclamationsImpl value,
          $Res Function(_$MyReclamationsImpl) then) =
      __$$MyReclamationsImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$MyReclamationsImplCopyWithImpl<$Res>
    extends _$ReclamationsEventCopyWithImpl<$Res, _$MyReclamationsImpl>
    implements _$$MyReclamationsImplCopyWith<$Res> {
  __$$MyReclamationsImplCopyWithImpl(
      _$MyReclamationsImpl _value, $Res Function(_$MyReclamationsImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$MyReclamationsImpl
    with DiagnosticableTreeMixin
    implements MyReclamations {
  const _$MyReclamationsImpl();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ReclamationsEvent.myReclamations()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
        .add(DiagnosticsProperty('type', 'ReclamationsEvent.myReclamations'));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$MyReclamationsImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() myReclamations,
  }) {
    return myReclamations();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? myReclamations,
  }) {
    return myReclamations?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? myReclamations,
    required TResult orElse(),
  }) {
    if (myReclamations != null) {
      return myReclamations();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(MyReclamations value) myReclamations,
  }) {
    return myReclamations(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(MyReclamations value)? myReclamations,
  }) {
    return myReclamations?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(MyReclamations value)? myReclamations,
    required TResult orElse(),
  }) {
    if (myReclamations != null) {
      return myReclamations(this);
    }
    return orElse();
  }
}

abstract class MyReclamations implements ReclamationsEvent {
  const factory MyReclamations() = _$MyReclamationsImpl;
}
