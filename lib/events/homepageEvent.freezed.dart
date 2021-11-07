// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'homepageEvent.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$HomePageEventTearOff {
  const _$HomePageEventTearOff();

  LoadHomePageButtons loadHomePageButtons() {
    return const LoadHomePageButtons();
  }
}

/// @nodoc
const $HomePageEvent = _$HomePageEventTearOff();

/// @nodoc
mixin _$HomePageEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadHomePageButtons,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadHomePageButtons,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadHomePageButtons value) loadHomePageButtons,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadHomePageButtons value)? loadHomePageButtons,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HomePageEventCopyWith<$Res> {
  factory $HomePageEventCopyWith(
          HomePageEvent value, $Res Function(HomePageEvent) then) =
      _$HomePageEventCopyWithImpl<$Res>;
}

/// @nodoc
class _$HomePageEventCopyWithImpl<$Res>
    implements $HomePageEventCopyWith<$Res> {
  _$HomePageEventCopyWithImpl(this._value, this._then);

  final HomePageEvent _value;
  // ignore: unused_field
  final $Res Function(HomePageEvent) _then;
}

/// @nodoc
abstract class $LoadHomePageButtonsCopyWith<$Res> {
  factory $LoadHomePageButtonsCopyWith(
          LoadHomePageButtons value, $Res Function(LoadHomePageButtons) then) =
      _$LoadHomePageButtonsCopyWithImpl<$Res>;
}

/// @nodoc
class _$LoadHomePageButtonsCopyWithImpl<$Res>
    extends _$HomePageEventCopyWithImpl<$Res>
    implements $LoadHomePageButtonsCopyWith<$Res> {
  _$LoadHomePageButtonsCopyWithImpl(
      LoadHomePageButtons _value, $Res Function(LoadHomePageButtons) _then)
      : super(_value, (v) => _then(v as LoadHomePageButtons));

  @override
  LoadHomePageButtons get _value => super._value as LoadHomePageButtons;
}

/// @nodoc

class _$LoadHomePageButtons implements LoadHomePageButtons {
  const _$LoadHomePageButtons();

  @override
  String toString() {
    return 'HomePageEvent.loadHomePageButtons()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is LoadHomePageButtons);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadHomePageButtons,
  }) {
    return loadHomePageButtons();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadHomePageButtons,
    required TResult orElse(),
  }) {
    if (loadHomePageButtons != null) {
      return loadHomePageButtons();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadHomePageButtons value) loadHomePageButtons,
  }) {
    return loadHomePageButtons(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadHomePageButtons value)? loadHomePageButtons,
    required TResult orElse(),
  }) {
    if (loadHomePageButtons != null) {
      return loadHomePageButtons(this);
    }
    return orElse();
  }
}

abstract class LoadHomePageButtons implements HomePageEvent {
  const factory LoadHomePageButtons() = _$LoadHomePageButtons;
}
