// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'FieldsetsEvent.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$FieldsetsEventTearOff {
  const _$FieldsetsEventTearOff();

  LoadLocalFieldSets loadLocalFieldSets(int formId) {
    return LoadLocalFieldSets(
      formId,
    );
  }
}

/// @nodoc
const $FieldsetsEvent = _$FieldsetsEventTearOff();

/// @nodoc
mixin _$FieldsetsEvent {
  int get formId => throw _privateConstructorUsedError;

  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int formId) loadLocalFieldSets,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int formId)? loadLocalFieldSets,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadLocalFieldSets value) loadLocalFieldSets,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadLocalFieldSets value)? loadLocalFieldSets,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $FieldsetsEventCopyWith<FieldsetsEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FieldsetsEventCopyWith<$Res> {
  factory $FieldsetsEventCopyWith(
          FieldsetsEvent value, $Res Function(FieldsetsEvent) then) =
      _$FieldsetsEventCopyWithImpl<$Res>;
  $Res call({int formId});
}

/// @nodoc
class _$FieldsetsEventCopyWithImpl<$Res>
    implements $FieldsetsEventCopyWith<$Res> {
  _$FieldsetsEventCopyWithImpl(this._value, this._then);

  final FieldsetsEvent _value;
  // ignore: unused_field
  final $Res Function(FieldsetsEvent) _then;

  @override
  $Res call({
    Object? formId = freezed,
  }) {
    return _then(_value.copyWith(
      formId: formId == freezed
          ? _value.formId
          : formId // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
abstract class $LoadLocalFieldSetsCopyWith<$Res>
    implements $FieldsetsEventCopyWith<$Res> {
  factory $LoadLocalFieldSetsCopyWith(
          LoadLocalFieldSets value, $Res Function(LoadLocalFieldSets) then) =
      _$LoadLocalFieldSetsCopyWithImpl<$Res>;
  @override
  $Res call({int formId});
}

/// @nodoc
class _$LoadLocalFieldSetsCopyWithImpl<$Res>
    extends _$FieldsetsEventCopyWithImpl<$Res>
    implements $LoadLocalFieldSetsCopyWith<$Res> {
  _$LoadLocalFieldSetsCopyWithImpl(
      LoadLocalFieldSets _value, $Res Function(LoadLocalFieldSets) _then)
      : super(_value, (v) => _then(v as LoadLocalFieldSets));

  @override
  LoadLocalFieldSets get _value => super._value as LoadLocalFieldSets;

  @override
  $Res call({
    Object? formId = freezed,
  }) {
    return _then(LoadLocalFieldSets(
      formId == freezed
          ? _value.formId
          : formId // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$LoadLocalFieldSets
    with DiagnosticableTreeMixin
    implements LoadLocalFieldSets {
  const _$LoadLocalFieldSets(this.formId);

  @override
  final int formId;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'FieldsetsEvent.loadLocalFieldSets(formId: $formId)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'FieldsetsEvent.loadLocalFieldSets'))
      ..add(DiagnosticsProperty('formId', formId));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is LoadLocalFieldSets &&
            (identical(other.formId, formId) ||
                const DeepCollectionEquality().equals(other.formId, formId)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(formId);

  @JsonKey(ignore: true)
  @override
  $LoadLocalFieldSetsCopyWith<LoadLocalFieldSets> get copyWith =>
      _$LoadLocalFieldSetsCopyWithImpl<LoadLocalFieldSets>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int formId) loadLocalFieldSets,
  }) {
    return loadLocalFieldSets(formId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int formId)? loadLocalFieldSets,
    required TResult orElse(),
  }) {
    if (loadLocalFieldSets != null) {
      return loadLocalFieldSets(formId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadLocalFieldSets value) loadLocalFieldSets,
  }) {
    return loadLocalFieldSets(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadLocalFieldSets value)? loadLocalFieldSets,
    required TResult orElse(),
  }) {
    if (loadLocalFieldSets != null) {
      return loadLocalFieldSets(this);
    }
    return orElse();
  }
}

abstract class LoadLocalFieldSets implements FieldsetsEvent {
  const factory LoadLocalFieldSets(int formId) = _$LoadLocalFieldSets;

  @override
  int get formId => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  $LoadLocalFieldSetsCopyWith<LoadLocalFieldSets> get copyWith =>
      throw _privateConstructorUsedError;
}
