import '../../models/chat_message.dart';

class AiChatState {
  final List<ChatMessage> messages;
  final bool isLoading;
  final String? errorMessage;

  const AiChatState({
    this.messages = const [],
    this.isLoading = false,
    this.errorMessage,
  });

  AiChatState copyWith({
    List<ChatMessage>? messages,
    bool? isLoading,
    String? errorMessage,
  }) {
    return AiChatState(
      messages: messages ?? this.messages,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }
}