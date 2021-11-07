// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'HistoryEvent.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$HistoryEventTearOff {
  const _$HistoryEventTearOff();

  LoadHistory loadHistory() {
    return const LoadHistory();
  }
}

/// @nodoc
const $HistoryEvent = _$HistoryEventTearOff();

/// @nodoc
mixin _$HistoryEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadHistory,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadHistory,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadHistory value) loadHistory,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadHistory value)? loadHistory,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HistoryEventCopyWith<$Res> {
  factory $HistoryEventCopyWith(
          HistoryEvent value, $Res Function(HistoryEvent) then) =
      _$HistoryEventCopyWithImpl<$Res>;
}

/// @nodoc
class _$HistoryEventCopyWithImpl<$Res> implements $HistoryEventCopyWith<$Res> {
  _$HistoryEventCopyWithImpl(this._value, this._then);

  final HistoryEvent _value;
  // ignore: unused_field
  final $Res Function(HistoryEvent) _then;
}

/// @nodoc
abstract class $LoadHistoryCopyWith<$Res> {
  factory $LoadHistoryCopyWith(
          LoadHistory value, $Res Function(LoadHistory) then) =
      _$LoadHistoryCopyWithImpl<$Res>;
}

/// @nodoc
class _$LoadHistoryCopyWithImpl<$Res> extends _$HistoryEventCopyWithImpl<$Res>
    implements $LoadHistoryCopyWith<$Res> {
  _$LoadHistoryCopyWithImpl(
      LoadHistory _value, $Res Function(LoadHistory) _then)
      : super(_value, (v) => _then(v as LoadHistory));

  @override
  LoadHistory get _value => super._value as LoadHistory;
}

/// @nodoc

class _$LoadHistory with DiagnosticableTreeMixin implements LoadHistory {
  const _$LoadHistory();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'HistoryEvent.loadHistory()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties..add(DiagnosticsProperty('type', 'HistoryEvent.loadHistory'));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is LoadHistory);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadHistory,
  }) {
    return loadHistory();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadHistory,
    required TResult orElse(),
  }) {
    if (loadHistory != null) {
      return loadHistory();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadHistory value) loadHistory,
  }) {
    return loadHistory(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadHistory value)? loadHistory,
    required TResult orElse(),
  }) {
    if (loadHistory != null) {
      return loadHistory(this);
    }
    return orElse();
  }
}

abstract class LoadHistory implements HistoryEvent {
  const factory LoadHistory() = _$LoadHistory;
}
