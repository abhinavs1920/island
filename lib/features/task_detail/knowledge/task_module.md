# Task Module Knowledge

## Overview
Handles the core rider lifecycle once a gig is tapped from the Home screen or deep-linked via FCM. It covers task acceptance, race conditions (if another rider accepts first), real-time chat, and completion/cancellation actions via bottom sheets.

## Endpoints Consumed
- `get_task_details`: Fetches full gig metadata. Includes basic loading indicators (CircularProgressIndicator in surface-dim) and retry buttons on failure.
- `accept_task`: Used to attempt claiming a gig. The UI immediately disables the button to prevent double submission.
    - If response implies success, routes to `/matched`.
    - If response implies already taken, routes to `/race_lost`.
- `cancel_task`: Called from the Cancel confirmation bottom sheet.
- `complete_task`: Called from the Complete confirmation bottom sheet.

## State Management (Riverpod)
- `TaskDetailProvider`: Handles task data fetching and the accept flow.
- `ChatProvider`: Subscribes to Supabase Realtime scoped to `task_id`. Emits real-time messages (no polling).
- `TaskActionProvider`: Manages state for the Cancel and Complete bottom sheets.

## UI Details
- **Task Detail**: Displays rich gig data. Adheres strictly to the physical, rugged design language with clear 1px borders and high contrast.
- **Race Lost**: A neutral state (not styled as an error). Explains the gig was claimed by someone else.
- **Matched Confirmation**: Success state confirming the rider owns the gig.
- **Chat**: Real-time messaging view.
- **Action Sheets**: Cancel and Complete are non-blocking until invoked, then presented as bottom sheets to force explicit confirmation before calling the destructive endpoints.
