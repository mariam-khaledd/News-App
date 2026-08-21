# 📰 News App

A modern Flutter News Application that allows users to discover and search for news articles through a simple and user-friendly interface.

The application also includes an AI-powered Customer Support feature that helps users with questions related to the News App.

## ✨ Features

- 🏠 Home
  - Browse the latest news articles
  - View news by categories
  - Discover featured articles

- 🔍 Search
  - Search for news articles
  - Find articles based on specific topics

- 🔖 Bookmarks
  - Save interesting articles
  - Access saved articles easily

- 🤖 AI Support
  - Chat with an AI Customer Support Assistant
  - Ask questions about the News App
  - Get AI-generated responses
  - Maintain conversation context using session ID

## 🤖 AI Customer Support

The application integrates an AI-powered Customer Support Agent using n8n and Google Gemini.

### Architecture

Flutter
    ↓
n8n Webhook
    ↓
AI Agent
    ↓
Google Gemini
    ↓
Conversation Memory
    ↓
Respond to Webhook
    ↓
Flutter Chat UI

The AI assistant is designed specifically to support users of the News App and focuses on app-related questions such as searching for news, browsing articles, and using app features.

## 🔗 API Request

The Flutter application communicates with the n8n workflow using HTTP POST requests.

Example request:

{
  "message": "How can I search for news?",
  "session_id": "test_001"
}

Example response:

{
  "reply": "You can search for news using the Search section in the app."
}

## 🧠 Conversation Memory

The AI Support feature uses a `session_id` to identify the user's conversation.

Using the same session ID allows the AI agent to maintain the context of the conversation.

## 🛠️ Technologies

- Flutter
- Dart
- Flutter BLoC / Cubit
- n8n
- Google Gemini
- REST API
- Postman

## 📂 Project Structure

lib/
├── features/
│   ├── home/
│   ├── Search/
│   ├── ai_chat/
│   │   ├── data/
│   │   ├── models/
│   │   └── presentation/
│   │       ├── cubit/
│   │       └── pages/
│   └── ...
│
├── main.dart
└── ...

n8n/
└── news_app_ai_support_workflow.json

## 🚀 Getting Started

### Prerequisites

Make sure you have Flutter installed and configured on your machine.

### Installation

Clone the repository:

git clone <YOUR_GITHUB_REPOSITORY_URL>

Navigate to the project:

cd news_app

Install dependencies:

flutter pub get

Run the application:

flutter run

## ⚙️ n8n Setup

The n8n workflow is included in:

n8n/news_app_ai_support_workflow.json

To use the AI Support feature:

1. Open your n8n instance.
2. Import the workflow JSON file.
3. Configure the required Google Gemini credentials.
4. Activate the workflow.
5. Configure the n8n Webhook URL in the Flutter application.

## 🧪 Testing

The AI Support Webhook was tested using Postman before integrating it with the Flutter application.

Example:

POST /webhook/news-support

Request:

{
  "message": "How can I search for news?",
  "session_id": "test_001"
}

The n8n workflow processes the request and returns an AI-generated response.

## 🔐 Security

API keys, passwords, tokens, and other sensitive credentials should not be committed to the repository.

The n8n workflow contains the workflow configuration, while credentials should be configured securely inside the n8n instance.

## 📱 Application

The application provides a simple news browsing experience with search, bookmarks, and AI-powered customer support.

## 👩‍💻 Developer

Developed using Flutter and Dart.
