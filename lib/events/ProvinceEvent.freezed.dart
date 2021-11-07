// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'ProvinceEvent.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$ProvinceEventTearOff {
  const _$ProvinceEventTearOff();

  ServerLoadProvinces serverLoadProvinces() {
    return const ServerLoadProvinces();
  }

  LoadProvinces loadProvinces() {
    return const LoadProvinces();
  }

  LoadTowns loadTowns(String provinceId) {
    return LoadTowns(
      provinceId,
    );
  }

  Distract distract() {
    return const Distract();
  }
}

/// @nodoc
const $ProvinceEvent = _$ProvinceEventTearOff();

/// @nodoc
mixin _$ProvinceEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() serverLoadProvinces,
    required TResult Function() loadProvinces,
    required TResult Function(String provinceId) loadTowns,
    required TResult Function() distract,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? serverLoadProvinces,
    TResult Function()? loadProvinces,
    TResult Function(String provinceId)? loadTowns,
    TResult Function()? distract,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ServerLoadProvinces value) serverLoadProvinces,
    required TResult Function(LoadProvinces value) loadProvinces,
    required TResult Function(LoadTowns value) loadTowns,
    required TResult Function(Distract value) distract,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ServerLoadProvinces value)? serverLoadProvinces,
    TResult Function(LoadProvinces value)? loadProvinces,
    TResult Function(LoadTowns value)? loadTowns,
    TResult Function(Distract value)? distract,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProvinceEventCopyWith<$Res> {
  factory $ProvinceEventCopyWith(
          ProvinceEvent value, $Res Function(ProvinceEvent) then) =
      _$ProvinceEventCopyWithImpl<$Res>;
}

/// @nodoc
class _$ProvinceEventCopyWithImpl<$Res>
    implements $ProvinceEventCopyWith<$Res> {
  _$ProvinceEventCopyWithImpl(this._value, this._then);

  final ProvinceEvent _value;
  // ignore: unused_field
  final $Res Function(ProvinceEvent) _then;
}

/// @nodoc
abstract class $ServerLoadProvincesCopyWith<$Res> {
  factory $ServerLoadProvincesCopyWith(
          ServerLoadProvinces value, $Res Function(ServerLoadProvinces) then) =
      _$ServerLoadProvincesCopyWithImpl<$Res>;
}

/// @nodoc
class _$ServerLoadProvincesCopyWithImpl<$Res>
    extends _$ProvinceEventCopyWithImpl<$Res>
    implements $ServerLoadProvincesCopyWith<$Res> {
  _$ServerLoadProvincesCopyWithImpl(
      ServerLoadProvinces _value, $Res Function(ServerLoadProvinces) _then)
      : super(_value, (v) => _then(v as ServerLoadProvinces));

  @override
  ServerLoadProvinces get _value => super._value as ServerLoadProvinces;
}

/// @nodoc

class _$ServerLoadProvinces
    with DiagnosticableTreeMixin
    implements ServerLoadProvinces {
  const _$ServerLoadProvinces();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ProvinceEvent.serverLoadProvinces()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ProvinceEvent.serverLoadProvinces'));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is ServerLoadProvinces);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() serverLoadProvinces,
    required TResult Function() loadProvinces,
    required TResult Function(String provinceId) loadTowns,
    required TResult Function() distract,
  }) {
    return serverLoadProvinces();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? serverLoadProvinces,
    TResult Function()? loadProvinces,
    TResult Function(String provinceId)? loadTowns,
    TResult Function()? distract,
    required TResult orElse(),
  }) {
    if (serverLoadProvinces != null) {
      return serverLoadProvinces();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ServerLoadProvinces value) serverLoadProvinces,
    required TResult Function(LoadProvinces value) loadProvinces,
    required TResult Function(LoadTowns value) loadTowns,
    required TResult Function(Distract value) distract,
  }) {
    return serverLoadProvinces(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ServerLoadProvinces value)? serverLoadProvinces,
    TResult Function(LoadProvinces value)? loadProvinces,
    TResult Function(LoadTowns value)? loadTowns,
    TResult Function(Distract value)? distract,
    required TResult orElse(),
  }) {
    if (serverLoadProvinces != null) {
      return serverLoadProvinces(this);
    }
    return orElse();
  }
}

abstract class ServerLoadProvinces implements ProvinceEvent {
  const factory ServerLoadProvinces() = _$ServerLoadProvinces;
}

/// @nodoc
abstract class $LoadProvincesCopyWith<$Res> {
  factory $LoadProvincesCopyWith(
          LoadProvinces value, $Res Function(LoadProvinces) then) =
      _$LoadProvincesCopyWithImpl<$Res>;
}

/// @nodoc
class _$LoadProvincesCopyWithImpl<$Res>
    extends _$ProvinceEventCopyWithImpl<$Res>
    implements $LoadProvincesCopyWith<$Res> {
  _$LoadProvincesCopyWithImpl(
      LoadProvinces _value, $Res Function(LoadProvinces) _then)
      : super(_value, (v) => _then(v as LoadProvinces));

  @override
  LoadProvinces get _value => super._value as LoadProvinces;
}

/// @nodoc

class _$LoadProvinces with DiagnosticableTreeMixin implements LoadProvinces {
  const _$LoadProvinces();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ProvinceEvent.loadProvinces()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties..add(DiagnosticsProperty('type', 'ProvinceEvent.loadProvinces'));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is LoadProvinces);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() serverLoadProvinces,
    required TResult Function() loadProvinces,
    required TResult Function(String provinceId) loadTowns,
    required TResult Function() distract,
  }) {
    return loadProvinces();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? serverLoadProvinces,
    TResult Function()? loadProvinces,
    TResult Function(String provinceId)? loadTowns,
    TResult Function()? distract,
    required TResult orElse(),
  }) {
    if (loadProvinces != null) {
      return loadProvinces();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ServerLoadProvinces value) serverLoadProvinces,
    required TResult Function(LoadProvinces value) loadProvinces,
    required TResult Function(LoadTowns value) loadTowns,
    required TResult Function(Distract value) distract,
  }) {
    return loadProvinces(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ServerLoadProvinces value)? serverLoadProvinces,
    TResult Function(LoadProvinces value)? loadProvinces,
    TResult Function(LoadTowns value)? loadTowns,
    TResult Function(Distract value)? distract,
    required TResult orElse(),
  }) {
    if (loadProvinces != null) {
      return loadProvinces(this);
    }
    return orElse();
  }
}

abstract class LoadProvinces implements ProvinceEvent {
  const factory LoadProvinces() = _$LoadProvinces;
}

/// @nodoc
abstract class $LoadTownsCopyWith<$Res> {
  factory $LoadTownsCopyWith(LoadTowns value, $Res Function(LoadTowns) then) =
      _$LoadTownsCopyWithImpl<$Res>;
  $Res call({String provinceId});
}

/// @nodoc
class _$LoadTownsCopyWithImpl<$Res> extends _$ProvinceEventCopyWithImpl<$Res>
    implements $LoadTownsCopyWith<$Res> {
  _$LoadTownsCopyWithImpl(LoadTowns _value, $Res Function(LoadTowns) _then)
      : super(_value, (v) => _then(v as LoadTowns));

  @override
  LoadTowns get _value => super._value as LoadTowns;

  @override
  $Res call({
    Object? provinceId = freezed,
  }) {
    return _then(LoadTowns(
      provinceId == freezed
          ? _value.provinceId
          : provinceId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$LoadTowns with DiagnosticableTreeMixin implements LoadTowns {
  const _$LoadTowns(this.provinceId);

  @override
  final String provinceId;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ProvinceEvent.loadTowns(provinceId: $provinceId)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ProvinceEvent.loadTowns'))
      ..add(DiagnosticsProperty('provinceId', provinceId));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is LoadTowns &&
            (identical(other.provinceId, provinceId) ||
                const DeepCollectionEquality()
                    .equals(other.provinceId, provinceId)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(provinceId);

  @JsonKey(ignore: true)
  @override
  $LoadTownsCopyWith<LoadTowns> get copyWith =>
      _$LoadTownsCopyWithImpl<LoadTowns>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() serverLoadProvinces,
    required TResult Function() loadProvinces,
    required TResult Function(String provinceId) loadTowns,
    required TResult Function() distract,
  }) {
    return loadTowns(provinceId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? serverLoadProvinces,
    TResult Function()? loadProvinces,
    TResult Function(String provinceId)? loadTowns,
    TResult Function()? distract,
    required TResult orElse(),
  }) {
    if (loadTowns != null) {
      return loadTowns(provinceId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ServerLoadProvinces value) serverLoadProvinces,
    required TResult Function(LoadProvinces value) loadProvinces,
    required TResult Function(LoadTowns value) loadTowns,
    required TResult Function(Distract value) distract,
  }) {
    return loadTowns(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ServerLoadProvinces value)? serverLoadProvinces,
    TResult Function(LoadProvinces value)? loadProvinces,
    TResult Function(LoadTowns value)? loadTowns,
    TResult Function(Distract value)? distract,
    required TResult orElse(),
  }) {
    if (loadTowns != null) {
      return loadTowns(this);
    }
    return orElse();
  }
}

abstract class LoadTowns implements ProvinceEvent {
  const factory LoadTowns(String provinceId) = _$LoadTowns;

  String get provinceId => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $LoadTownsCopyWith<LoadTowns> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DistractCopyWith<$Res> {
  factory $DistractCopyWith(Distract value, $Res Function(Distract) then) =
      _$DistractCopyWithImpl<$Res>;
}

/// @nodoc
class _$DistractCopyWithImpl<$Res> extends _$ProvinceEventCopyWithImpl<$Res>
    implements $DistractCopyWith<$Res> {
  _$DistractCopyWithImpl(Distract _value, $Res Function(Distract) _then)
      : super(_value, (v) => _then(v as Distract));

  @override
  Distract get _value => super._value as Distract;
}

/// @nodoc

class _$Distract with DiagnosticableTreeMixin implements Distract {
  const _$Distract();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ProvinceEvent.distract()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties..add(DiagnosticsProperty('type', 'ProvinceEvent.distract'));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is Distract);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() serverLoadProvinces,
    required TResult Function() loadProvinces,
    required TResult Function(String provinceId) loadTowns,
    required TResult Function() distract,
  }) {
    return distract();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? serverLoadProvinces,
    TResult Function()? loadProvinces,
    TResult Function(String provinceId)? loadTowns,
    TResult Function()? distract,
    required TResult orElse(),
  }) {
    if (distract != null) {
      return distract();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ServerLoadProvinces value) serverLoadProvinces,
    required TResult Function(LoadProvinces value) loadProvinces,
    required TResult Function(LoadTowns value) loadTowns,
    required TResult Function(Distract value) distract,
  }) {
    return distract(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ServerLoadProvinces value)? serverLoadProvinces,
    TResult Function(LoadProvinces value)? loadProvinces,
    TResult Function(LoadTowns value)? loadTowns,
    TResult Function(Distract value)? distract,
    required TResult orElse(),
  }) {
    if (distract != null) {
      return distract(this);
    }
    return orElse();
  }
}

abstract class Distract implements ProvinceEvent {
  const factory Distract() = _$Distract;
}
