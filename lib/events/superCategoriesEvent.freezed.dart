// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'superCategoriesEvent.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$SuperCategoriesEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() fetchLocalSuperCategories,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? fetchLocalSuperCategories,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? fetchLocalSuperCategories,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FetchLocalSuperCategories value)
        fetchLocalSuperCategories,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FetchLocalSuperCategories value)?
        fetchLocalSuperCategories,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FetchLocalSuperCategories value)?
        fetchLocalSuperCategories,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SuperCategoriesEventCopyWith<$Res> {
  factory $SuperCategoriesEventCopyWith(SuperCategoriesEvent value,
          $Res Function(SuperCategoriesEvent) then) =
      _$SuperCategoriesEventCopyWithImpl<$Res, SuperCategoriesEvent>;
}

/// @nodoc
class _$SuperCategoriesEventCopyWithImpl<$Res,
        $Val extends SuperCategoriesEvent>
    implements $SuperCategoriesEventCopyWith<$Res> {
  _$SuperCategoriesEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$FetchLocalSuperCategoriesImplCopyWith<$Res> {
  factory _$$FetchLocalSuperCategoriesImplCopyWith(
          _$FetchLocalSuperCategoriesImpl value,
          $Res Function(_$FetchLocalSuperCategoriesImpl) then) =
      __$$FetchLocalSuperCategoriesImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$FetchLocalSuperCategoriesImplCopyWithImpl<$Res>
    extends _$SuperCategoriesEventCopyWithImpl<$Res,
        _$FetchLocalSuperCategoriesImpl>
    implements _$$FetchLocalSuperCategoriesImplCopyWith<$Res> {
  __$$FetchLocalSuperCategoriesImplCopyWithImpl(
      _$FetchLocalSuperCategoriesImpl _value,
      $Res Function(_$FetchLocalSuperCategoriesImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$FetchLocalSuperCategoriesImpl implements FetchLocalSuperCategories {
  const _$FetchLocalSuperCategoriesImpl();

  @override
  String toString() {
    return 'SuperCategoriesEvent.fetchLocalSuperCategories()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FetchLocalSuperCategoriesImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() fetchLocalSuperCategories,
  }) {
    return fetchLocalSuperCategories();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? fetchLocalSuperCategories,
  }) {
    return fetchLocalSuperCategories?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? fetchLocalSuperCategories,
    required TResult orElse(),
  }) {
    if (fetchLocalSuperCategories != null) {
      return fetchLocalSuperCategories();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FetchLocalSuperCategories value)
        fetchLocalSuperCategories,
  }) {
    return fetchLocalSuperCategories(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FetchLocalSuperCategories value)?
        fetchLocalSuperCategories,
  }) {
    return fetchLocalSuperCategories?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FetchLocalSuperCategories value)?
        fetchLocalSuperCategories,
    required TResult orElse(),
  }) {
    if (fetchLocalSuperCategories != null) {
      return fetchLocalSuperCategories(this);
    }
    return orElse();
  }
}

abstract class FetchLocalSuperCategories implements SuperCategoriesEvent {
  const factory FetchLocalSuperCategories() = _$FetchLocalSuperCategoriesImpl;
}
