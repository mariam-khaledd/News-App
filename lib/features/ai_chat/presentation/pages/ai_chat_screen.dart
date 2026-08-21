import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/ai_chat_service.dart';
import '../cubit/ai_chat_cubit.dart';
import '../cubit/ai_chat_state.dart';

class AiChatScreen extends StatelessWidget {
  const AiChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AiChatCubit(
        chatService: AiChatService(),
      ),
      child: const _AiChatView(),
    );
  }
}

class _AiChatView extends StatelessWidget {
  const _AiChatView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AI Support'),
      ),
      body: BlocConsumer<AiChatCubit, AiChatState>(
        listener: (context, state) {
          if (state.errorMessage != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage!),
              ),
            );
          }
        },
        builder: (context, state) {
          final cubit = context.read<AiChatCubit>();

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  controller: cubit.scrollController,
                  padding: const EdgeInsets.all(16),
                  itemCount: state.messages.length,
                  itemBuilder: (context, index) {
                    final message = state.messages[index];

                    return Align(
                      alignment: message.isUser
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: Container(
                        margin: const EdgeInsets.only(
                          bottom: 12,
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          color: message.isUser
                              ? const Color(0xff001F3F)
                              : Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Text(
                          message.message,
                          style: TextStyle(
                            color: message.isUser
                                ? Colors.white
                                : Colors.black87,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              if (state.isLoading)
                const Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: Text('AI is typing...'),
                ),

              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: cubit.messageController,
                          textInputAction: TextInputAction.send,
                          onSubmitted: (_) {
                            cubit.sendMessage();
                          },
                          decoration: InputDecoration(
                            hintText: 'Ask us anything...',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      IconButton(
                        onPressed: state.isLoading
                            ? null
                            : cubit.sendMessage,
                        icon: const Icon(Icons.send),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}