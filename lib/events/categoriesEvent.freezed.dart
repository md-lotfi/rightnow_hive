// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'categoriesEvent.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$CategoriesEventTearOff {
  const _$CategoriesEventTearOff();

  FetchLocalCategories fetchLocalCategories(int belongsTo) {
    return FetchLocalCategories(
      belongsTo,
    );
  }

  FetchLocalMiddleCategories fetchLocalMiddleCategories(int belongsTo) {
    return FetchLocalMiddleCategories(
      belongsTo,
    );
  }
}

/// @nodoc
const $CategoriesEvent = _$CategoriesEventTearOff();

/// @nodoc
mixin _$CategoriesEvent {
  int get belongsTo => throw _privateConstructorUsedError;

  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int belongsTo) fetchLocalCategories,
    required TResult Function(int belongsTo) fetchLocalMiddleCategories,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int belongsTo)? fetchLocalCategories,
    TResult Function(int belongsTo)? fetchLocalMiddleCategories,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FetchLocalCategories value) fetchLocalCategories,
    required TResult Function(FetchLocalMiddleCategories value)
        fetchLocalMiddleCategories,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FetchLocalCategories value)? fetchLocalCategories,
    TResult Function(FetchLocalMiddleCategories value)?
        fetchLocalMiddleCategories,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CategoriesEventCopyWith<CategoriesEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CategoriesEventCopyWith<$Res> {
  factory $CategoriesEventCopyWith(
          CategoriesEvent value, $Res Function(CategoriesEvent) then) =
      _$CategoriesEventCopyWithImpl<$Res>;
  $Res call({int belongsTo});
}

/// @nodoc
class _$CategoriesEventCopyWithImpl<$Res>
    implements $CategoriesEventCopyWith<$Res> {
  _$CategoriesEventCopyWithImpl(this._value, this._then);

  final CategoriesEvent _value;
  // ignore: unused_field
  final $Res Function(CategoriesEvent) _then;

  @override
  $Res call({
    Object? belongsTo = freezed,
  }) {
    return _then(_value.copyWith(
      belongsTo: belongsTo == freezed
          ? _value.belongsTo
          : belongsTo // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
abstract class $FetchLocalCategoriesCopyWith<$Res>
    implements $CategoriesEventCopyWith<$Res> {
  factory $FetchLocalCategoriesCopyWith(FetchLocalCategories value,
          $Res Function(FetchLocalCategories) then) =
      _$FetchLocalCategoriesCopyWithImpl<$Res>;
  @override
  $Res call({int belongsTo});
}

/// @nodoc
class _$FetchLocalCategoriesCopyWithImpl<$Res>
    extends _$CategoriesEventCopyWithImpl<$Res>
    implements $FetchLocalCategoriesCopyWith<$Res> {
  _$FetchLocalCategoriesCopyWithImpl(
      FetchLocalCategories _value, $Res Function(FetchLocalCategories) _then)
      : super(_value, (v) => _then(v as FetchLocalCategories));

  @override
  FetchLocalCategories get _value => super._value as FetchLocalCategories;

  @override
  $Res call({
    Object? belongsTo = freezed,
  }) {
    return _then(FetchLocalCategories(
      belongsTo == freezed
          ? _value.belongsTo
          : belongsTo // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$FetchLocalCategories implements FetchLocalCategories {
  const _$FetchLocalCategories(this.belongsTo);

  @override
  final int belongsTo;

  @override
  String toString() {
    return 'CategoriesEvent.fetchLocalCategories(belongsTo: $belongsTo)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is FetchLocalCategories &&
            (identical(other.belongsTo, belongsTo) ||
                const DeepCollectionEquality()
                    .equals(other.belongsTo, belongsTo)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(belongsTo);

  @JsonKey(ignore: true)
  @override
  $FetchLocalCategoriesCopyWith<FetchLocalCategories> get copyWith =>
      _$FetchLocalCategoriesCopyWithImpl<FetchLocalCategories>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int belongsTo) fetchLocalCategories,
    required TResult Function(int belongsTo) fetchLocalMiddleCategories,
  }) {
    return fetchLocalCategories(belongsTo);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int belongsTo)? fetchLocalCategories,
    TResult Function(int belongsTo)? fetchLocalMiddleCategories,
    required TResult orElse(),
  }) {
    if (fetchLocalCategories != null) {
      return fetchLocalCategories(belongsTo);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FetchLocalCategories value) fetchLocalCategories,
    required TResult Function(FetchLocalMiddleCategories value)
        fetchLocalMiddleCategories,
  }) {
    return fetchLocalCategories(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FetchLocalCategories value)? fetchLocalCategories,
    TResult Function(FetchLocalMiddleCategories value)?
        fetchLocalMiddleCategories,
    required TResult orElse(),
  }) {
    if (fetchLocalCategories != null) {
      return fetchLocalCategories(this);
    }
    return orElse();
  }
}

abstract class FetchLocalCategories implements CategoriesEvent {
  const factory FetchLocalCategories(int belongsTo) = _$FetchLocalCategories;

  @override
  int get belongsTo => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  $FetchLocalCategoriesCopyWith<FetchLocalCategories> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FetchLocalMiddleCategoriesCopyWith<$Res>
    implements $CategoriesEventCopyWith<$Res> {
  factory $FetchLocalMiddleCategoriesCopyWith(FetchLocalMiddleCategories value,
          $Res Function(FetchLocalMiddleCategories) then) =
      _$FetchLocalMiddleCategoriesCopyWithImpl<$Res>;
  @override
  $Res call({int belongsTo});
}

/// @nodoc
class _$FetchLocalMiddleCategoriesCopyWithImpl<$Res>
    extends _$CategoriesEventCopyWithImpl<$Res>
    implements $FetchLocalMiddleCategoriesCopyWith<$Res> {
  _$FetchLocalMiddleCategoriesCopyWithImpl(FetchLocalMiddleCategories _value,
      $Res Function(FetchLocalMiddleCategories) _then)
      : super(_value, (v) => _then(v as FetchLocalMiddleCategories));

  @override
  FetchLocalMiddleCategories get _value =>
      super._value as FetchLocalMiddleCategories;

  @override
  $Res call({
    Object? belongsTo = freezed,
  }) {
    return _then(FetchLocalMiddleCategories(
      belongsTo == freezed
          ? _value.belongsTo
          : belongsTo // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$FetchLocalMiddleCategories implements FetchLocalMiddleCategories {
  const _$FetchLocalMiddleCategories(this.belongsTo);

  @override
  final int belongsTo;

  @override
  String toString() {
    return 'CategoriesEvent.fetchLocalMiddleCategories(belongsTo: $belongsTo)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is FetchLocalMiddleCategories &&
            (identical(other.belongsTo, belongsTo) ||
                const DeepCollectionEquality()
                    .equals(other.belongsTo, belongsTo)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(belongsTo);

  @JsonKey(ignore: true)
  @override
  $FetchLocalMiddleCategoriesCopyWith<FetchLocalMiddleCategories>
      get copyWith =>
          _$FetchLocalMiddleCategoriesCopyWithImpl<FetchLocalMiddleCategories>(
              this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int belongsTo) fetchLocalCategories,
    required TResult Function(int belongsTo) fetchLocalMiddleCategories,
  }) {
    return fetchLocalMiddleCategories(belongsTo);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int belongsTo)? fetchLocalCategories,
    TResult Function(int belongsTo)? fetchLocalMiddleCategories,
    required TResult orElse(),
  }) {
    if (fetchLocalMiddleCategories != null) {
      return fetchLocalMiddleCategories(belongsTo);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FetchLocalCategories value) fetchLocalCategories,
    required TResult Function(FetchLocalMiddleCategories value)
        fetchLocalMiddleCategories,
  }) {
    return fetchLocalMiddleCategories(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FetchLocalCategories value)? fetchLocalCategories,
    TResult Function(FetchLocalMiddleCategories value)?
        fetchLocalMiddleCategories,
    required TResult orElse(),
  }) {
    if (fetchLocalMiddleCategories != null) {
      return fetchLocalMiddleCategories(this);
    }
    return orElse();
  }
}

abstract class FetchLocalMiddleCategories implements CategoriesEvent {
  const factory FetchLocalMiddleCategories(int belongsTo) =
      _$FetchLocalMiddleCategories;

  @override
  int get belongsTo => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  $FetchLocalMiddleCategoriesCopyWith<FetchLocalMiddleCategories>
      get copyWith => throw _privateConstructorUsedError;
}
