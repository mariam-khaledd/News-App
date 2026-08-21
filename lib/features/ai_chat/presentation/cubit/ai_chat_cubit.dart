import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/ai_chat_service.dart';
import '../../models/chat_message.dart';
import 'ai_chat_state.dart';

class AiChatCubit extends Cubit<AiChatState> {
  AiChatCubit({
    required this.chatService,
  }) : super(const AiChatState());

  final AiChatService chatService;

  final TextEditingController messageController =
  TextEditingController();

  final ScrollController scrollController =
  ScrollController();

  final String sessionId = 'flutter_test_001';

  Future<void> sendMessage() async {
    final message = messageController.text.trim();

    if (message.isEmpty || state.isLoading) {
      return;
    }

    messageController.clear();

    final updatedMessages = [
      ...state.messages,
      ChatMessage(
        message: message,
        isUser: true,
      ),
    ];

    emit(
      state.copyWith(
        messages: updatedMessages,
        isLoading: true,
        errorMessage: null,
      ),
    );

    _scrollToBottom();

    try {
      final reply = await chatService.sendMessage(
        message: message,
        sessionId: sessionId,
      );

      emit(
        state.copyWith(
          messages: [
            ...updatedMessages,
            ChatMessage(
              message: reply,
              isUser: false,
            ),
          ],
          isLoading: false,
        ),
      );

      _scrollToBottom();
    } catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!scrollController.hasClients) {
        return;
      }

      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  Future<void> close() {
    messageController.dispose();
    scrollController.dispose();

    return super.close();
  }
}