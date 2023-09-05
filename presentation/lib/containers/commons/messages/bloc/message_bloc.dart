import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'message_event.dart';
part 'message_state.dart';

class MessageBloc extends Bloc<MessageEvent, MessageState> {
  MessageBloc() : super(MessageInitial()) {
    on<ShowErrorMessageEvent>((event, emit) async {
      emit(MessageError(event.message));
      await Future.delayed(const Duration(seconds: 1));
      add(const ResetMessageEvent());
    });
    on<ShowSuccessMessageEvent>((event, emit) async {
      emit(MessageSuccess(event.message));
      await Future.delayed(const Duration(seconds: 1));
      add(const ResetMessageEvent());
    });
    on<ShowWarningMessageEvent>((event, emit) async {
      emit(MessageWarning(event.message));
      await Future.delayed(const Duration(seconds: 1));
      add(const ResetMessageEvent());
    });
    on<ResetMessageEvent>((event, emit) async {
      emit(MessageInitial());
    });
  }
}
