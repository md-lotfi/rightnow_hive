// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'QuestionsEvent.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$QuestionsEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int fieldSetId) loadQuestions,
    required TResult Function() distract,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int fieldSetId)? loadQuestions,
    TResult? Function()? distract,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int fieldSetId)? loadQuestions,
    TResult Function()? distract,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadQuestions value) loadQuestions,
    required TResult Function(Distract value) distract,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadQuestions value)? loadQuestions,
    TResult? Function(Distract value)? distract,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadQuestions value)? loadQuestions,
    TResult Function(Distract value)? distract,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QuestionsEventCopyWith<$Res> {
  factory $QuestionsEventCopyWith(
          QuestionsEvent value, $Res Function(QuestionsEvent) then) =
      _$QuestionsEventCopyWithImpl<$Res, QuestionsEvent>;
}

/// @nodoc
class _$QuestionsEventCopyWithImpl<$Res, $Val extends QuestionsEvent>
    implements $QuestionsEventCopyWith<$Res> {
  _$QuestionsEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$LoadQuestionsImplCopyWith<$Res> {
  factory _$$LoadQuestionsImplCopyWith(
          _$LoadQuestionsImpl value, $Res Function(_$LoadQuestionsImpl) then) =
      __$$LoadQuestionsImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int fieldSetId});
}

/// @nodoc
class __$$LoadQuestionsImplCopyWithImpl<$Res>
    extends _$QuestionsEventCopyWithImpl<$Res, _$LoadQuestionsImpl>
    implements _$$LoadQuestionsImplCopyWith<$Res> {
  __$$LoadQuestionsImplCopyWithImpl(
      _$LoadQuestionsImpl _value, $Res Function(_$LoadQuestionsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fieldSetId = null,
  }) {
    return _then(_$LoadQuestionsImpl(
      null == fieldSetId
          ? _value.fieldSetId
          : fieldSetId // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$LoadQuestionsImpl
    with DiagnosticableTreeMixin
    implements LoadQuestions {
  const _$LoadQuestionsImpl(this.fieldSetId);

  @override
  final int fieldSetId;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'QuestionsEvent.loadQuestions(fieldSetId: $fieldSetId)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'QuestionsEvent.loadQuestions'))
      ..add(DiagnosticsProperty('fieldSetId', fieldSetId));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadQuestionsImpl &&
            (identical(other.fieldSetId, fieldSetId) ||
                other.fieldSetId == fieldSetId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, fieldSetId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadQuestionsImplCopyWith<_$LoadQuestionsImpl> get copyWith =>
      __$$LoadQuestionsImplCopyWithImpl<_$LoadQuestionsImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int fieldSetId) loadQuestions,
    required TResult Function() distract,
  }) {
    return loadQuestions(fieldSetId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int fieldSetId)? loadQuestions,
    TResult? Function()? distract,
  }) {
    return loadQuestions?.call(fieldSetId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int fieldSetId)? loadQuestions,
    TResult Function()? distract,
    required TResult orElse(),
  }) {
    if (loadQuestions != null) {
      return loadQuestions(fieldSetId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadQuestions value) loadQuestions,
    required TResult Function(Distract value) distract,
  }) {
    return loadQuestions(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadQuestions value)? loadQuestions,
    TResult? Function(Distract value)? distract,
  }) {
    return loadQuestions?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadQuestions value)? loadQuestions,
    TResult Function(Distract value)? distract,
    required TResult orElse(),
  }) {
    if (loadQuestions != null) {
      return loadQuestions(this);
    }
    return orElse();
  }
}

abstract class LoadQuestions implements QuestionsEvent {
  const factory LoadQuestions(final int fieldSetId) = _$LoadQuestionsImpl;

  int get fieldSetId;
  @JsonKey(ignore: true)
  _$$LoadQuestionsImplCopyWith<_$LoadQuestionsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DistractImplCopyWith<$Res> {
  factory _$$DistractImplCopyWith(
          _$DistractImpl value, $Res Function(_$DistractImpl) then) =
      __$$DistractImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$DistractImplCopyWithImpl<$Res>
    extends _$QuestionsEventCopyWithImpl<$Res, _$DistractImpl>
    implements _$$DistractImplCopyWith<$Res> {
  __$$DistractImplCopyWithImpl(
      _$DistractImpl _value, $Res Function(_$DistractImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$DistractImpl with DiagnosticableTreeMixin implements Distract {
  const _$DistractImpl();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'QuestionsEvent.distract()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('type', 'QuestionsEvent.distract'));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$DistractImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int fieldSetId) loadQuestions,
    required TResult Function() distract,
  }) {
    return distract();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int fieldSetId)? loadQuestions,
    TResult? Function()? distract,
  }) {
    return distract?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int fieldSetId)? loadQuestions,
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
    required TResult Function(LoadQuestions value) loadQuestions,
    required TResult Function(Distract value) distract,
  }) {
    return distract(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadQuestions value)? loadQuestions,
    TResult? Function(Distract value)? distract,
  }) {
    return distract?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadQuestions value)? loadQuestions,
    TResult Function(Distract value)? distract,
    required TResult orElse(),
  }) {
    if (distract != null) {
      return distract(this);
    }
    return orElse();
  }
}

abstract class Distract implements QuestionsEvent {
  const factory Distract() = _$DistractImpl;
}
