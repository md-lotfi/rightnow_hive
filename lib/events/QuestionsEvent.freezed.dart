// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'QuestionsEvent.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$QuestionsEventTearOff {
  const _$QuestionsEventTearOff();

  LoadQuestions loadQuestions(int fieldSetId) {
    return LoadQuestions(
      fieldSetId,
    );
  }

  Distract distract() {
    return const Distract();
  }
}

/// @nodoc
const $QuestionsEvent = _$QuestionsEventTearOff();

/// @nodoc
mixin _$QuestionsEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int fieldSetId) loadQuestions,
    required TResult Function() distract,
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
      _$QuestionsEventCopyWithImpl<$Res>;
}

/// @nodoc
class _$QuestionsEventCopyWithImpl<$Res>
    implements $QuestionsEventCopyWith<$Res> {
  _$QuestionsEventCopyWithImpl(this._value, this._then);

  final QuestionsEvent _value;
  // ignore: unused_field
  final $Res Function(QuestionsEvent) _then;
}

/// @nodoc
abstract class $LoadQuestionsCopyWith<$Res> {
  factory $LoadQuestionsCopyWith(
          LoadQuestions value, $Res Function(LoadQuestions) then) =
      _$LoadQuestionsCopyWithImpl<$Res>;
  $Res call({int fieldSetId});
}

/// @nodoc
class _$LoadQuestionsCopyWithImpl<$Res>
    extends _$QuestionsEventCopyWithImpl<$Res>
    implements $LoadQuestionsCopyWith<$Res> {
  _$LoadQuestionsCopyWithImpl(
      LoadQuestions _value, $Res Function(LoadQuestions) _then)
      : super(_value, (v) => _then(v as LoadQuestions));

  @override
  LoadQuestions get _value => super._value as LoadQuestions;

  @override
  $Res call({
    Object? fieldSetId = freezed,
  }) {
    return _then(LoadQuestions(
      fieldSetId == freezed
          ? _value.fieldSetId
          : fieldSetId // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$LoadQuestions with DiagnosticableTreeMixin implements LoadQuestions {
  const _$LoadQuestions(this.fieldSetId);

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
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is LoadQuestions &&
            (identical(other.fieldSetId, fieldSetId) ||
                const DeepCollectionEquality()
                    .equals(other.fieldSetId, fieldSetId)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(fieldSetId);

  @JsonKey(ignore: true)
  @override
  $LoadQuestionsCopyWith<LoadQuestions> get copyWith =>
      _$LoadQuestionsCopyWithImpl<LoadQuestions>(this, _$identity);

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
  const factory LoadQuestions(int fieldSetId) = _$LoadQuestions;

  int get fieldSetId => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $LoadQuestionsCopyWith<LoadQuestions> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DistractCopyWith<$Res> {
  factory $DistractCopyWith(Distract value, $Res Function(Distract) then) =
      _$DistractCopyWithImpl<$Res>;
}

/// @nodoc
class _$DistractCopyWithImpl<$Res> extends _$QuestionsEventCopyWithImpl<$Res>
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
    return 'QuestionsEvent.distract()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties..add(DiagnosticsProperty('type', 'QuestionsEvent.distract'));
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
    required TResult Function(int fieldSetId) loadQuestions,
    required TResult Function() distract,
  }) {
    return distract();
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
  const factory Distract() = _$Distract;
}
