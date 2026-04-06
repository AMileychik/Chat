# Chat

 ## Overview
 This project is a simple offline-first chat application built with UIKit.
 It displays a list of conversations (Inbox) and allows opening a conversation to view and send messages.

 The application is designed with clean separation of layers:
 - Coordinator-based navigation
 - MVVM-style ViewModels
 - Repository layer for data access
 - Local storage layer for offline persistence

 ## Features Implemented
 - Inbox screen with conversations sorted by `last_updated` (newest first)
 - Chat screen with messages sorted by `last_updated` (oldest first)
 - Offline-first JSON persistence:
   - On first launch, data is loaded from bundled JSON
   - Seed data is saved into the Documents directory
   - All updates are persisted locally
 - Send message:
   - Adds message immediately to UI
   - Persists asynchronously
   - Clears input field after sending
 - Delete message via swipe-to-delete
 - Pull-to-refresh on inbox
 - Basic unit tests for sorting and view model events

 ## Architecture
 ### Presentation Layer
 - `InboxViewController`, `ChatViewController`
 - ViewControllers are lightweight and contain only UI setup + binding logic.

 ### Coordination Layer
 - `InboxCoordinator`, `ChatCoordinator`
 - Responsible for navigation and screen composition.

 ### ViewModel Layer
 - `InboxViewModel`, `ChatViewModel`
 - Handles UI state, business logic, and interaction with repository.

 ### Data Layer
 - `ConversationRepository`
 - Single source of truth for conversations.
 - Updates local cache and persists changes.

 ### Persistence Layer
 - `ConversationsLocalStorage`
 - Loads from Documents if available, otherwise seeds from bundled JSON.
 - Saves all updates back to Documents.

 ## Notes / Improvements With More Time
 If I had more time, I would:
 - Introduce Swift Package Manager for modularization if the app grows
 - Implement Use Cases / Interactors to encapsulate business logic and orchestrate multiple repositories
 - Improve UI styling to match modern chat/inbox apps (avatars, bubbles, spacing, typography)
 - Add search in Inbox
 - Add stronger error handling and retry mechanisms
 - Add more test coverage 

 ## Requirements Coverage
 - ✅ Inbox sorted by last_updated (newest first)
 - ✅ Chat messages sorted by last_updated (oldest first)
 - ✅ Offline-first approach with local persistence
 - ✅ Reply input section with Send button
 - ✅ Send clears text field and appends message with correct date
 - ✅ Displays message date + text
 
