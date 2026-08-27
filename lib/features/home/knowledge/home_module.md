# Home Module Knowledge

## Overview
The Home module is the main hub for the rider, managing availability status (Online/Offline), location pinging, and displaying nearby gigs in the area. The toggle is always optimistic — UI updates immediately, backend sync is fire-and-forget.

## Files
- `home_controller.dart` — Riverpod `Notifier` for online state + `AsyncNotifier` for gigs
- `home_screen.dart` — Main screen with toggle hero, gig list, and bottom navigation
- `gig_model.dart` — `Gig` data model
- `gig_card.dart` — Tappable gig list item component

## Endpoints Consumed
| Endpoint | When Called | Status |
|---|---|---|
| `POST /update_availability` | When rider flips Online/Offline toggle | ⚠️ **Not yet wired** |
| `POST /update_location` | On toggle-on and on app resume from background | ⚠️ **Not yet wired** |
| `GET /get_nearby_tasks` | On go-online and pull-to-refresh | ⚠️ **Not yet wired** |

## Required Before Going Live
- [ ] **Real GPS coordinates**: Replace `lat: 0.0, lng: 0.0` placeholders in `updateLocation()` inside `home_controller.dart` with values from `geolocator` package (`Geolocator.getCurrentPosition()`)
- [ ] **Add `geolocator` dependency** to `pubspec.yaml` and request `ACCESS_FINE_LOCATION` in `AndroidManifest.xml`
- [ ] **FCM push listener**: Wire up `FirebaseMessaging.onMessage` in `home_screen.dart` to call `ref.invalidate(gigsProvider)` so new gigs delivered via FCM show up immediately without user pulling to refresh
- [ ] **Pull-to-refresh**: Wrap the gig list `Column` in a `RefreshIndicator` that calls `ref.invalidate(gigsProvider)`
- [ ] **Backend base URL**: Update in `lib/core/api/api_client.dart`

## Gig Data Flow
```
FCM Push (primary) ──► invalidate gigsProvider ──► re-fetch /get_nearby_tasks
Pull-to-refresh    ──► invalidate gigsProvider ──► re-fetch /get_nearby_tasks
Go Online          ──► gigsProvider.build()    ──► fetch /get_nearby_tasks
Go Offline         ──► gigsProvider.build()    ──► returns []
```

## State Management
- `isOnlineProvider` — `NotifierProvider<IsOnlineController, bool>`, default `false`
- `gigsProvider` — `AsyncNotifierProvider<GigsController, List<Gig>>`, watches `isOnlineProvider`
- Toggle is always optimistic: `state = value` fires before the API call, and **never reverts on error**

## UI States
| State | Behaviour |
|---|---|
| Offline | Grey background (`#E1E1EF`), toggle shows off, gig list hidden |
| Online — loading | Green card, `CircularProgressIndicator` in gig list area |
| Online — empty | Green card, "0 nearby gigs" empty state with inbox icon |
| Online — with gigs | Green card, scrollable `GigCard` list |

## Bottom Navigation Tabs
| Index | Tab | Wired |
|---|---|---|
| 0 | Tasks | ✅ Active tab |
| 1 | Chat | ⚠️ Placeholder — wire to `/chat/:taskId` |
| 2 | Earnings | ⚠️ Placeholder — wire to earnings screen |
| 3 | Profile | ⚠️ Placeholder — wire to profile screen |
