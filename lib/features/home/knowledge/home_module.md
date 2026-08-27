# Home Module Knowledge

## Overview
The Home module is the main hub for the rider, managing their availability status (Online/Offline), tracking location, and displaying available gigs in the immediate vicinity.

## Endpoints Consumed
- `update_availability`: Called when the rider flips the Online/Offline toggle. Updates optimistically in the UI; reverts on failure.
- `update_location`: Pings the backend with current GPS coordinates. Triggered on app resume (via `WidgetsBindingObserver`) and when going online.
- `get_nearby_tasks`: Polled/pulled to fetch available gigs in the area. (Note: Primary gig source is FCM push notifications, with this as a fallback/sync mechanism).

## State Management (Riverpod)
- `IsOnlineController`: Notifier managing the boolean online state.
- `GigsController`: AsyncNotifier watching `IsOnlineController`. Automatically clears the list if offline, and fetches from `get_nearby_tasks` if online.

## UI Details
- **Home - Online**: Uses the `#F9FAFB` surface background. Displays the Gig list using `GigCard` components.
- **Home - Offline**: Uses a greyed-out visual state to denote inactivity, preventing interaction with gig lists.
- **GigCard**: A high-contrast component displaying critical gig data (price, distance, type tags). Uses `rounded-lg` (8px) borders with a 1px solid border (#E5E7EB) to provide a physical, rugged feel per the design system.
- **Empty State**: Displays a clear "0 nearby gigs" message when online but no data is returned.
