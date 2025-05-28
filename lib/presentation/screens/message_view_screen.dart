import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lab1/cubit/cubits/qr_code_scan_cubits/message_cubit.dart';
import 'package:lab1/cubit/states/qr_code_scan_states/message_state.dart';

class MessageViewScreen extends StatelessWidget {
  const MessageViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => MessageCubit()..connectAndRead(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Last message from ESP32')),
        body: BlocBuilder<MessageCubit, MessageState>(
          builder: (context, state) {
            if (state is MessageLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is MessageLoaded) {
              return Center(
                child: Text(
                  state.message,
                  style: const TextStyle(fontSize: 20),
                  textAlign: TextAlign.center,
                ),
              );
            } else if (state is MessageError) {
              return Center(
                child: Text(
                  state.error,
                  style: const TextStyle(fontSize: 18, color: Colors.red),
                  textAlign: TextAlign.center,
                ),
              );
            } else {
              return const Center(child: Text('Waiting for data...'));
            }
          },
        ),
      ),
    );
  }
}
