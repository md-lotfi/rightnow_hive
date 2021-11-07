// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'FormsEvent.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$FormsEventTearOff {
  const _$FormsEventTearOff();

  LoadLocalForms loadLocalForms() {
    return const LoadLocalForms();
  }
}

/// @nodoc
const $FormsEvent = _$FormsEventTearOff();

/// @nodoc
mixin _$FormsEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadLocalForms,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadLocalForms,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadLocalForms value) loadLocalForms,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadLocalForms value)? loadLocalForms,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FormsEventCopyWith<$Res> {
  factory $FormsEventCopyWith(
          FormsEvent value, $Res Function(FormsEvent) then) =
      _$FormsEventCopyWithImpl<$Res>;
}

/// @nodoc
class _$FormsEventCopyWithImpl<$Res> implements $FormsEventCopyWith<$Res> {
  _$FormsEventCopyWithImpl(this._value, this._then);

  final FormsEvent _value;
  // ignore: unused_field
  final $Res Function(FormsEvent) _then;
}

/// @nodoc
abstract class $LoadLocalFormsCopyWith<$Res> {
  factory $LoadLocalFormsCopyWith(
          LoadLocalForms value, $Res Function(LoadLocalForms) then) =
      _$LoadLocalFormsCopyWithImpl<$Res>;
}

/// @nodoc
class _$LoadLocalFormsCopyWithImpl<$Res> extends _$FormsEventCopyWithImpl<$Res>
    implements $LoadLocalFormsCopyWith<$Res> {
  _$LoadLocalFormsCopyWithImpl(
      LoadLocalForms _value, $Res Function(LoadLocalForms) _then)
      : super(_value, (v) => _then(v as LoadLocalForms));

  @override
  LoadLocalForms get _value => super._value as LoadLocalForms;
}

/// @nodoc

class _$LoadLocalForms with DiagnosticableTreeMixin implements LoadLocalForms {
  const _$LoadLocalForms();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'FormsEvent.loadLocalForms()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties..add(DiagnosticsProperty('type', 'FormsEvent.loadLocalForms'));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is LoadLocalForms);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadLocalForms,
  }) {
    return loadLocalForms();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadLocalForms,
    required TResult orElse(),
  }) {
    if (loadLocalForms != null) {
      return loadLocalForms();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadLocalForms value) loadLocalForms,
  }) {
    return loadLocalForms(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadLocalForms value)? loadLocalForms,
    required TResult orElse(),
  }) {
    if (loadLocalForms != null) {
      return loadLocalForms(this);
    }
    return orElse();
  }
}

abstract class LoadLocalForms implements FormsEvent {
  const factory LoadLocalForms() = _$LoadLocalForms;
}
