# Task Module Knowledge

## Overview
Handles the core rider lifecycle once a gig is tapped from the Home screen or deep-linked via FCM. Covers task acceptance (with race condition handling), real-time chat via Supabase Realtime, and completion/cancellation actions via bottom sheets.

## Files
- `task_detail/providers/task_detail_provider.dart` — `FutureProvider` for task data + `StateNotifier` for accept flow
- `task_detail/view/task_detail_screen.dart` — Full task detail with Accept button
- `task_detail/view/matched_confirmation_screen.dart` — Success state after winning the accept race
- `task_detail/view/race_lost_screen.dart` — Neutral state when another rider accepted first
- `chat/providers/chat_provider.dart` — Supabase Realtime subscription scoped to `task_id`
- `chat/view/chat_screen.dart` — Real-time messaging view
- `task_action/providers/task_action_provider.dart` — Complete and cancel API calls
- `task_action/view/complete_task_sheet.dart` — Confirmation bottom sheet for completion
- `task_action/view/cancel_task_sheet.dart` — Confirmation bottom sheet for cancellation

## Endpoints Consumed
| Endpoint | When Called | Status |
|---|---|---|
| `GET /get_task_details?task_id=` | On `TaskDetailScreen` open | ⚠️ **Not yet wired** |
| `POST /accept_task` | When rider taps Accept button | ⚠️ **Not yet wired** |
| `POST /complete_task` | From `CompleteTaskSheet` confirmation only | ⚠️ **Not yet wired** |
| `POST /cancel_task` | From `CancelTaskSheet` confirmation only | ⚠️ **Not yet wired** |
| **Supabase Realtime** `tasks` channel | `ChatScreen` open — subscribes to `task_id` filter | ⚠️ **Not yet wired** |

## Required Before Going Live
- [ ] **Backend base URL**: Update in `lib/core/api/api_client.dart`
- [ ] **Supabase credentials**: Call `Supabase.initialize(url: '...', anonKey: '...')` in `main.dart`
- [ ] **Accept task response contract**: Confirm exact field name from backend that signals `matched` vs `race_lost` — currently reading `response.data['status']`
- [ ] **Chat message schema**: Confirm Supabase Realtime payload fields (e.g. `sender_id`, `content`, `created_at`) match what `chat_provider.dart` expects
- [ ] **FCM deep-link to task**: When a rider receives an FCM push for a new gig, route directly to `/task/:id` using `firebase_messaging` `onMessageOpenedApp` handler in `main.dart`
- [ ] **Cancel reason**: Decide if backend requires a cancellation reason string — add a text field to `cancel_task_sheet.dart` if needed

## Accept Flow Logic
```
Tap Accept
  │
  ├─ Disable button immediately (prevent double-tap)
  ├─ POST /accept_task { task_id }
  │
  ├─ response.data['status'] == 'matched'  ──► context.go('/matched')
  ├─ response.data['status'] == 'race_lost' ──► context.go('/race_lost')
  └─ Error ──► Show inline error, re-enable button
```

## Chat Architecture
- Uses **Supabase Realtime** — no polling, no WebSocket setup needed manually
- Subscription is scoped to a single `task_id` to prevent cross-task message leakage
- Subscription is cancelled in `dispose()` to prevent memory leaks

## Complete / Cancel Rules
> ⚠️ **Never call `complete_task` or `cancel_task` directly from a single tap.**
> Both actions MUST go through their respective confirmation bottom sheets first.
> This is a hard UX requirement to prevent accidental submissions.

## UI Loading & Error States
| Screen | Loading | Error |
|---|---|---|
| Task Detail | `CircularProgressIndicator` (surface-dim) | Inline text + retry button |
| Accept button | Button shows spinner, disabled | Re-enabled with snackbar error |
| Chat | Message list shows previous messages | Reconnect banner |
| Action Sheets | Button shows spinner, disabled | Snackbar error, sheet stays open |
