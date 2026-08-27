# Auth Module Knowledge

## Overview
This module handles rider authentication, consisting of a Splash screen for session restoration, a Phone Entry screen, and an OTP Verification screen. It strictly follows the "RiderGo" design system (Electric Blue primary actions, Inter font, bottom-anchored CTA buttons).

## Endpoints Consumed
- `refresh_session`: Called on Splash screen. If successful, router goes to `/home`. If 401, goes to `/phone`.
- `verify_and_create_session`: Called after Firebase SDK validates the OTP. Exchanges Firebase ID token for a backend JWT.
- `register_device_token`: Called immediately after a successful session creation, registering the local FCM token for push notifications (gigs).

## State Management (Riverpod)
- `AuthProvider`: A StateNotifier or AsyncNotifier that manages the login flow.
- Uses `ApiClient` (from `lib/core/api/api_client.dart`) to ensure all requests include the JWT (handled by Dio interceptors) and intercepts 401s for silent retries globally.
- Persists tokens via `flutter_secure_storage`.

## UI Details
- **Splash Screen**: Uses the brand electric blue background with a centered logo.
- **Phone Entry**: Includes a simulated keypad/numeric input. Error states use `#ba1a1a` colored text.
- **OTP Verify**: Six distinct input boxes. Error states use `#ba1a1a`.
- **Navigation**: Controlled by GoRouter in the parent context based on Riverpod state.
