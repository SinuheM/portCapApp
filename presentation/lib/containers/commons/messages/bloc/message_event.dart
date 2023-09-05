part of 'message_bloc.dart';

abstract class MessageEvent extends Equatable {
  const MessageEvent();

  @override
  List<Object> get props => [];
}

class ResetMessageEvent extends MessageEvent {
  const ResetMessageEvent();

  @override
  List<Object> get props => [];

  @override
  String toString() => 'ResetMessageEvent';
}

class ShowErrorMessageEvent extends MessageEvent {
  final String message;
  const ShowErrorMessageEvent(this.message);

  @override
  List<Object> get props => [message];

  @override
  String toString() => 'ShowErrorMessageEvent { message: $message }';
}

class ShowSuccessMessageEvent extends MessageEvent {
  final String message;
  const ShowSuccessMessageEvent(this.message);

  @override
  List<Object> get props => [message];

  @override
  String toString() => 'ShowSuccessMessageEvent { message: $message }';
}

class ShowWarningMessageEvent extends MessageEvent {
  final String message;
  const ShowWarningMessageEvent(this.message);

  @override
  List<Object> get props => [message];

  @override
  String toString() => 'ShowWarningMessageEvent { message: $message }';
}
