part of '../message_cubit.dart';

abstract class MessageState extends Equatable {
  const MessageState();

  @override
  List<Object> get props => [];
}

class MessageInitial extends MessageState {}

class MessageLoading extends MessageState {}

class MessageLoaded extends MessageState {
  final String message;
  const MessageLoaded(this.message);

  @override
  List<Object> get props => [message];
}

class MessageError extends MessageState {
  final String error;
  const MessageError(this.error);

  @override
  List<Object> get props => [error];
}
