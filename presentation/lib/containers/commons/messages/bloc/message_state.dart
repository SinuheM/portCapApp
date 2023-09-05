part of 'message_bloc.dart';

abstract class MessageState extends Equatable {
  const MessageState();

  @override
  List<Object> get props => [];
}

class MessageInitial extends MessageState {}

class MessageError extends MessageState {
  final String message;

  const MessageError(this.message);
  @override
  List<Object> get props => [message];
}

class MessageSuccess extends MessageState {
  final String message;

  const MessageSuccess(this.message);
  @override
  List<Object> get props => [message];
}

class MessageWarning extends MessageState {
  final String message;

  const MessageWarning(this.message);
  @override
  List<Object> get props => [message];
}
