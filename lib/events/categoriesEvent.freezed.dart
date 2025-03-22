// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'categoriesEvent.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

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
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int belongsTo)? fetchLocalCategories,
    TResult? Function(int belongsTo)? fetchLocalMiddleCategories,
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
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FetchLocalCategories value)? fetchLocalCategories,
    TResult? Function(FetchLocalMiddleCategories value)?
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

  /// Create a copy of CategoriesEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CategoriesEventCopyWith<CategoriesEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CategoriesEventCopyWith<$Res> {
  factory $CategoriesEventCopyWith(
          CategoriesEvent value, $Res Function(CategoriesEvent) then) =
      _$CategoriesEventCopyWithImpl<$Res, CategoriesEvent>;
  @useResult
  $Res call({int belongsTo});
}

/// @nodoc
class _$CategoriesEventCopyWithImpl<$Res, $Val extends CategoriesEvent>
    implements $CategoriesEventCopyWith<$Res> {
  _$CategoriesEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CategoriesEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? belongsTo = null,
  }) {
    return _then(_value.copyWith(
      belongsTo: null == belongsTo
          ? _value.belongsTo
          : belongsTo // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FetchLocalCategoriesImplCopyWith<$Res>
    implements $CategoriesEventCopyWith<$Res> {
  factory _$$FetchLocalCategoriesImplCopyWith(_$FetchLocalCategoriesImpl value,
          $Res Function(_$FetchLocalCategoriesImpl) then) =
      __$$FetchLocalCategoriesImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int belongsTo});
}

/// @nodoc
class __$$FetchLocalCategoriesImplCopyWithImpl<$Res>
    extends _$CategoriesEventCopyWithImpl<$Res, _$FetchLocalCategoriesImpl>
    implements _$$FetchLocalCategoriesImplCopyWith<$Res> {
  __$$FetchLocalCategoriesImplCopyWithImpl(_$FetchLocalCategoriesImpl _value,
      $Res Function(_$FetchLocalCategoriesImpl) _then)
      : super(_value, _then);

  /// Create a copy of CategoriesEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? belongsTo = null,
  }) {
    return _then(_$FetchLocalCategoriesImpl(
      null == belongsTo
          ? _value.belongsTo
          : belongsTo // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$FetchLocalCategoriesImpl implements FetchLocalCategories {
  const _$FetchLocalCategoriesImpl(this.belongsTo);

  @override
  final int belongsTo;

  @override
  String toString() {
    return 'CategoriesEvent.fetchLocalCategories(belongsTo: $belongsTo)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FetchLocalCategoriesImpl &&
            (identical(other.belongsTo, belongsTo) ||
                other.belongsTo == belongsTo));
  }

  @override
  int get hashCode => Object.hash(runtimeType, belongsTo);

  /// Create a copy of CategoriesEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FetchLocalCategoriesImplCopyWith<_$FetchLocalCategoriesImpl>
      get copyWith =>
          __$$FetchLocalCategoriesImplCopyWithImpl<_$FetchLocalCategoriesImpl>(
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
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int belongsTo)? fetchLocalCategories,
    TResult? Function(int belongsTo)? fetchLocalMiddleCategories,
  }) {
    return fetchLocalCategories?.call(belongsTo);
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
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FetchLocalCategories value)? fetchLocalCategories,
    TResult? Function(FetchLocalMiddleCategories value)?
        fetchLocalMiddleCategories,
  }) {
    return fetchLocalCategories?.call(this);
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
  const factory FetchLocalCategories(final int belongsTo) =
      _$FetchLocalCategoriesImpl;

  @override
  int get belongsTo;

  /// Create a copy of CategoriesEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FetchLocalCategoriesImplCopyWith<_$FetchLocalCategoriesImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$FetchLocalMiddleCategoriesImplCopyWith<$Res>
    implements $CategoriesEventCopyWith<$Res> {
  factory _$$FetchLocalMiddleCategoriesImplCopyWith(
          _$FetchLocalMiddleCategoriesImpl value,
          $Res Function(_$FetchLocalMiddleCategoriesImpl) then) =
      __$$FetchLocalMiddleCategoriesImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int belongsTo});
}

/// @nodoc
class __$$FetchLocalMiddleCategoriesImplCopyWithImpl<$Res>
    extends _$CategoriesEventCopyWithImpl<$Res,
        _$FetchLocalMiddleCategoriesImpl>
    implements _$$FetchLocalMiddleCategoriesImplCopyWith<$Res> {
  __$$FetchLocalMiddleCategoriesImplCopyWithImpl(
      _$FetchLocalMiddleCategoriesImpl _value,
      $Res Function(_$FetchLocalMiddleCategoriesImpl) _then)
      : super(_value, _then);

  /// Create a copy of CategoriesEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? belongsTo = null,
  }) {
    return _then(_$FetchLocalMiddleCategoriesImpl(
      null == belongsTo
          ? _value.belongsTo
          : belongsTo // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$FetchLocalMiddleCategoriesImpl implements FetchLocalMiddleCategories {
  const _$FetchLocalMiddleCategoriesImpl(this.belongsTo);

  @override
  final int belongsTo;

  @override
  String toString() {
    return 'CategoriesEvent.fetchLocalMiddleCategories(belongsTo: $belongsTo)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FetchLocalMiddleCategoriesImpl &&
            (identical(other.belongsTo, belongsTo) ||
                other.belongsTo == belongsTo));
  }

  @override
  int get hashCode => Object.hash(runtimeType, belongsTo);

  /// Create a copy of CategoriesEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FetchLocalMiddleCategoriesImplCopyWith<_$FetchLocalMiddleCategoriesImpl>
      get copyWith => __$$FetchLocalMiddleCategoriesImplCopyWithImpl<
          _$FetchLocalMiddleCategoriesImpl>(this, _$identity);

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
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int belongsTo)? fetchLocalCategories,
    TResult? Function(int belongsTo)? fetchLocalMiddleCategories,
  }) {
    return fetchLocalMiddleCategories?.call(belongsTo);
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
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FetchLocalCategories value)? fetchLocalCategories,
    TResult? Function(FetchLocalMiddleCategories value)?
        fetchLocalMiddleCategories,
  }) {
    return fetchLocalMiddleCategories?.call(this);
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
  const factory FetchLocalMiddleCategories(final int belongsTo) =
      _$FetchLocalMiddleCategoriesImpl;

  @override
  int get belongsTo;

  /// Create a copy of CategoriesEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FetchLocalMiddleCategoriesImplCopyWith<_$FetchLocalMiddleCategoriesImpl>
      get copyWith => throw _privateConstructorUsedError;
}
