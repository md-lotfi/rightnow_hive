// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'HashEvent.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$HashEventTearOff {
  const _$HashEventTearOff();

  GetCategoriesHash getCategoriesHash() {
    return const GetCategoriesHash();
  }

  LoadCategories loadCategories(String currentHash) {
    return LoadCategories(
      currentHash,
    );
  }

  RestoreCategories restoreCategories() {
    return const RestoreCategories();
  }

  Distract distract() {
    return const Distract();
  }
}

/// @nodoc
const $HashEvent = _$HashEventTearOff();

/// @nodoc
mixin _$HashEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() getCategoriesHash,
    required TResult Function(String currentHash) loadCategories,
    required TResult Function() restoreCategories,
    required TResult Function() distract,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? getCategoriesHash,
    TResult Function(String currentHash)? loadCategories,
    TResult Function()? restoreCategories,
    TResult Function()? distract,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(GetCategoriesHash value) getCategoriesHash,
    required TResult Function(LoadCategories value) loadCategories,
    required TResult Function(RestoreCategories value) restoreCategories,
    required TResult Function(Distract value) distract,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(GetCategoriesHash value)? getCategoriesHash,
    TResult Function(LoadCategories value)? loadCategories,
    TResult Function(RestoreCategories value)? restoreCategories,
    TResult Function(Distract value)? distract,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HashEventCopyWith<$Res> {
  factory $HashEventCopyWith(HashEvent value, $Res Function(HashEvent) then) =
      _$HashEventCopyWithImpl<$Res>;
}

/// @nodoc
class _$HashEventCopyWithImpl<$Res> implements $HashEventCopyWith<$Res> {
  _$HashEventCopyWithImpl(this._value, this._then);

  final HashEvent _value;
  // ignore: unused_field
  final $Res Function(HashEvent) _then;
}

/// @nodoc
abstract class $GetCategoriesHashCopyWith<$Res> {
  factory $GetCategoriesHashCopyWith(
          GetCategoriesHash value, $Res Function(GetCategoriesHash) then) =
      _$GetCategoriesHashCopyWithImpl<$Res>;
}

/// @nodoc
class _$GetCategoriesHashCopyWithImpl<$Res>
    extends _$HashEventCopyWithImpl<$Res>
    implements $GetCategoriesHashCopyWith<$Res> {
  _$GetCategoriesHashCopyWithImpl(
      GetCategoriesHash _value, $Res Function(GetCategoriesHash) _then)
      : super(_value, (v) => _then(v as GetCategoriesHash));

  @override
  GetCategoriesHash get _value => super._value as GetCategoriesHash;
}

/// @nodoc

class _$GetCategoriesHash
    with DiagnosticableTreeMixin
    implements GetCategoriesHash {
  const _$GetCategoriesHash();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'HashEvent.getCategoriesHash()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties..add(DiagnosticsProperty('type', 'HashEvent.getCategoriesHash'));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is GetCategoriesHash);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() getCategoriesHash,
    required TResult Function(String currentHash) loadCategories,
    required TResult Function() restoreCategories,
    required TResult Function() distract,
  }) {
    return getCategoriesHash();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? getCategoriesHash,
    TResult Function(String currentHash)? loadCategories,
    TResult Function()? restoreCategories,
    TResult Function()? distract,
    required TResult orElse(),
  }) {
    if (getCategoriesHash != null) {
      return getCategoriesHash();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(GetCategoriesHash value) getCategoriesHash,
    required TResult Function(LoadCategories value) loadCategories,
    required TResult Function(RestoreCategories value) restoreCategories,
    required TResult Function(Distract value) distract,
  }) {
    return getCategoriesHash(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(GetCategoriesHash value)? getCategoriesHash,
    TResult Function(LoadCategories value)? loadCategories,
    TResult Function(RestoreCategories value)? restoreCategories,
    TResult Function(Distract value)? distract,
    required TResult orElse(),
  }) {
    if (getCategoriesHash != null) {
      return getCategoriesHash(this);
    }
    return orElse();
  }
}

abstract class GetCategoriesHash implements HashEvent {
  const factory GetCategoriesHash() = _$GetCategoriesHash;
}

/// @nodoc
abstract class $LoadCategoriesCopyWith<$Res> {
  factory $LoadCategoriesCopyWith(
          LoadCategories value, $Res Function(LoadCategories) then) =
      _$LoadCategoriesCopyWithImpl<$Res>;
  $Res call({String currentHash});
}

/// @nodoc
class _$LoadCategoriesCopyWithImpl<$Res> extends _$HashEventCopyWithImpl<$Res>
    implements $LoadCategoriesCopyWith<$Res> {
  _$LoadCategoriesCopyWithImpl(
      LoadCategories _value, $Res Function(LoadCategories) _then)
      : super(_value, (v) => _then(v as LoadCategories));

  @override
  LoadCategories get _value => super._value as LoadCategories;

  @override
  $Res call({
    Object? currentHash = freezed,
  }) {
    return _then(LoadCategories(
      currentHash == freezed
          ? _value.currentHash
          : currentHash // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$LoadCategories with DiagnosticableTreeMixin implements LoadCategories {
  const _$LoadCategories(this.currentHash);

  @override
  final String currentHash;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'HashEvent.loadCategories(currentHash: $currentHash)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'HashEvent.loadCategories'))
      ..add(DiagnosticsProperty('currentHash', currentHash));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is LoadCategories &&
            (identical(other.currentHash, currentHash) ||
                const DeepCollectionEquality()
                    .equals(other.currentHash, currentHash)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(currentHash);

  @JsonKey(ignore: true)
  @override
  $LoadCategoriesCopyWith<LoadCategories> get copyWith =>
      _$LoadCategoriesCopyWithImpl<LoadCategories>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() getCategoriesHash,
    required TResult Function(String currentHash) loadCategories,
    required TResult Function() restoreCategories,
    required TResult Function() distract,
  }) {
    return loadCategories(currentHash);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? getCategoriesHash,
    TResult Function(String currentHash)? loadCategories,
    TResult Function()? restoreCategories,
    TResult Function()? distract,
    required TResult orElse(),
  }) {
    if (loadCategories != null) {
      return loadCategories(currentHash);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(GetCategoriesHash value) getCategoriesHash,
    required TResult Function(LoadCategories value) loadCategories,
    required TResult Function(RestoreCategories value) restoreCategories,
    required TResult Function(Distract value) distract,
  }) {
    return loadCategories(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(GetCategoriesHash value)? getCategoriesHash,
    TResult Function(LoadCategories value)? loadCategories,
    TResult Function(RestoreCategories value)? restoreCategories,
    TResult Function(Distract value)? distract,
    required TResult orElse(),
  }) {
    if (loadCategories != null) {
      return loadCategories(this);
    }
    return orElse();
  }
}

abstract class LoadCategories implements HashEvent {
  const factory LoadCategories(String currentHash) = _$LoadCategories;

  String get currentHash => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $LoadCategoriesCopyWith<LoadCategories> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RestoreCategoriesCopyWith<$Res> {
  factory $RestoreCategoriesCopyWith(
          RestoreCategories value, $Res Function(RestoreCategories) then) =
      _$RestoreCategoriesCopyWithImpl<$Res>;
}

/// @nodoc
class _$RestoreCategoriesCopyWithImpl<$Res>
    extends _$HashEventCopyWithImpl<$Res>
    implements $RestoreCategoriesCopyWith<$Res> {
  _$RestoreCategoriesCopyWithImpl(
      RestoreCategories _value, $Res Function(RestoreCategories) _then)
      : super(_value, (v) => _then(v as RestoreCategories));

  @override
  RestoreCategories get _value => super._value as RestoreCategories;
}

/// @nodoc

class _$RestoreCategories
    with DiagnosticableTreeMixin
    implements RestoreCategories {
  const _$RestoreCategories();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'HashEvent.restoreCategories()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties..add(DiagnosticsProperty('type', 'HashEvent.restoreCategories'));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is RestoreCategories);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() getCategoriesHash,
    required TResult Function(String currentHash) loadCategories,
    required TResult Function() restoreCategories,
    required TResult Function() distract,
  }) {
    return restoreCategories();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? getCategoriesHash,
    TResult Function(String currentHash)? loadCategories,
    TResult Function()? restoreCategories,
    TResult Function()? distract,
    required TResult orElse(),
  }) {
    if (restoreCategories != null) {
      return restoreCategories();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(GetCategoriesHash value) getCategoriesHash,
    required TResult Function(LoadCategories value) loadCategories,
    required TResult Function(RestoreCategories value) restoreCategories,
    required TResult Function(Distract value) distract,
  }) {
    return restoreCategories(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(GetCategoriesHash value)? getCategoriesHash,
    TResult Function(LoadCategories value)? loadCategories,
    TResult Function(RestoreCategories value)? restoreCategories,
    TResult Function(Distract value)? distract,
    required TResult orElse(),
  }) {
    if (restoreCategories != null) {
      return restoreCategories(this);
    }
    return orElse();
  }
}

abstract class RestoreCategories implements HashEvent {
  const factory RestoreCategories() = _$RestoreCategories;
}

/// @nodoc
abstract class $DistractCopyWith<$Res> {
  factory $DistractCopyWith(Distract value, $Res Function(Distract) then) =
      _$DistractCopyWithImpl<$Res>;
}

/// @nodoc
class _$DistractCopyWithImpl<$Res> extends _$HashEventCopyWithImpl<$Res>
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
    return 'HashEvent.distract()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties..add(DiagnosticsProperty('type', 'HashEvent.distract'));
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
    required TResult Function() getCategoriesHash,
    required TResult Function(String currentHash) loadCategories,
    required TResult Function() restoreCategories,
    required TResult Function() distract,
  }) {
    return distract();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? getCategoriesHash,
    TResult Function(String currentHash)? loadCategories,
    TResult Function()? restoreCategories,
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
    required TResult Function(GetCategoriesHash value) getCategoriesHash,
    required TResult Function(LoadCategories value) loadCategories,
    required TResult Function(RestoreCategories value) restoreCategories,
    required TResult Function(Distract value) distract,
  }) {
    return distract(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(GetCategoriesHash value)? getCategoriesHash,
    TResult Function(LoadCategories value)? loadCategories,
    TResult Function(RestoreCategories value)? restoreCategories,
    TResult Function(Distract value)? distract,
    required TResult orElse(),
  }) {
    if (distract != null) {
      return distract(this);
    }
    return orElse();
  }
}

abstract class Distract implements HashEvent {
  const factory Distract() = _$Distract;
}
