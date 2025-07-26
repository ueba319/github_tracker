// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'commit_calendar_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$CommitCalendarState {
  Map<DateTime, int> get commitCounts => throw _privateConstructorUsedError;
  LoadingState get loadingState => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;

  /// Create a copy of CommitCalendarState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CommitCalendarStateCopyWith<CommitCalendarState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CommitCalendarStateCopyWith<$Res> {
  factory $CommitCalendarStateCopyWith(
          CommitCalendarState value, $Res Function(CommitCalendarState) then) =
      _$CommitCalendarStateCopyWithImpl<$Res, CommitCalendarState>;
  @useResult
  $Res call(
      {Map<DateTime, int> commitCounts,
      LoadingState loadingState,
      String? errorMessage});
}

/// @nodoc
class _$CommitCalendarStateCopyWithImpl<$Res, $Val extends CommitCalendarState>
    implements $CommitCalendarStateCopyWith<$Res> {
  _$CommitCalendarStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CommitCalendarState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? commitCounts = null,
    Object? loadingState = null,
    Object? errorMessage = freezed,
  }) {
    return _then(_value.copyWith(
      commitCounts: null == commitCounts
          ? _value.commitCounts
          : commitCounts // ignore: cast_nullable_to_non_nullable
              as Map<DateTime, int>,
      loadingState: null == loadingState
          ? _value.loadingState
          : loadingState // ignore: cast_nullable_to_non_nullable
              as LoadingState,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CommitCalendarStateImplCopyWith<$Res>
    implements $CommitCalendarStateCopyWith<$Res> {
  factory _$$CommitCalendarStateImplCopyWith(_$CommitCalendarStateImpl value,
          $Res Function(_$CommitCalendarStateImpl) then) =
      __$$CommitCalendarStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Map<DateTime, int> commitCounts,
      LoadingState loadingState,
      String? errorMessage});
}

/// @nodoc
class __$$CommitCalendarStateImplCopyWithImpl<$Res>
    extends _$CommitCalendarStateCopyWithImpl<$Res, _$CommitCalendarStateImpl>
    implements _$$CommitCalendarStateImplCopyWith<$Res> {
  __$$CommitCalendarStateImplCopyWithImpl(_$CommitCalendarStateImpl _value,
      $Res Function(_$CommitCalendarStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of CommitCalendarState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? commitCounts = null,
    Object? loadingState = null,
    Object? errorMessage = freezed,
  }) {
    return _then(_$CommitCalendarStateImpl(
      commitCounts: null == commitCounts
          ? _value._commitCounts
          : commitCounts // ignore: cast_nullable_to_non_nullable
              as Map<DateTime, int>,
      loadingState: null == loadingState
          ? _value.loadingState
          : loadingState // ignore: cast_nullable_to_non_nullable
              as LoadingState,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$CommitCalendarStateImpl implements _CommitCalendarState {
  const _$CommitCalendarStateImpl(
      {required final Map<DateTime, int> commitCounts,
      required this.loadingState,
      this.errorMessage})
      : _commitCounts = commitCounts;

  final Map<DateTime, int> _commitCounts;
  @override
  Map<DateTime, int> get commitCounts {
    if (_commitCounts is EqualUnmodifiableMapView) return _commitCounts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_commitCounts);
  }

  @override
  final LoadingState loadingState;
  @override
  final String? errorMessage;

  @override
  String toString() {
    return 'CommitCalendarState(commitCounts: $commitCounts, loadingState: $loadingState, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CommitCalendarStateImpl &&
            const DeepCollectionEquality()
                .equals(other._commitCounts, _commitCounts) &&
            (identical(other.loadingState, loadingState) ||
                other.loadingState == loadingState) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_commitCounts),
      loadingState,
      errorMessage);

  /// Create a copy of CommitCalendarState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CommitCalendarStateImplCopyWith<_$CommitCalendarStateImpl> get copyWith =>
      __$$CommitCalendarStateImplCopyWithImpl<_$CommitCalendarStateImpl>(
          this, _$identity);
}

abstract class _CommitCalendarState implements CommitCalendarState {
  const factory _CommitCalendarState(
      {required final Map<DateTime, int> commitCounts,
      required final LoadingState loadingState,
      final String? errorMessage}) = _$CommitCalendarStateImpl;

  @override
  Map<DateTime, int> get commitCounts;
  @override
  LoadingState get loadingState;
  @override
  String? get errorMessage;

  /// Create a copy of CommitCalendarState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CommitCalendarStateImplCopyWith<_$CommitCalendarStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
