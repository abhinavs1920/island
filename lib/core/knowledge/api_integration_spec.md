# Frontend API Integration Spec (AI-Readable)

You are an AI coding assistant building a mobile frontend (User App and Rider App) for a gig-economy platform. The backend is already fully implemented as a Python/FastAPI modular monolith.

This document serves as your absolute source of truth for the backend's API contracts, business flows, and expected edge cases. **Do not invent endpoints or fields that are not listed here.**

---

## 1. Authentication Flow & Endpoints

**Architecture:** The client handles OTP verification via Firebase Auth. The backend does *not* interact with Firebase directly other than verifying the generated ID token.

### Login / Signup
- **Endpoint:** `POST /auth/verify`
- **Auth:** None
- **Request Body:**
  ```json
  {
    "firebase_id_token": "string (acquired from Firebase SDK)",
    "role": "user" | "rider",
    "name": "string (collected on the OTP screen)",
    "device_name": "string (e.g. iPhone 14)",
    "fcm_token": "string (Firebase Cloud Messaging push token)",
    "platform": "ios" | "android",
    "os_version": "16.4",
    "app_version": "1.0.0"
  }
  ```
- **Response (200 OK):**
  ```json
  {
    "access_token": "jwt_string",
    "refresh_token": "opaque_string",
    "user": { "id": "uuid", "phone": "string", "name": "string" } // or "rider"
  }
  ```
- **Edge Cases & Handling:** 
  - `401 Unauthorized`: Firebase token is invalid or expired. Prompt user to request a new OTP.
  - The `access_token` is valid for 2 hours. The `refresh_token` is valid for 30 days.

### Token Refresh
- **Endpoint:** `POST /auth/refresh`
- **Request Body:** `{ "refresh_token": "string" }`
- **Response:** `{ "access_token": "string" }`
- **Edge Cases:** `401 Unauthorized` if refresh token is invalid/revoked. Client must forcefully log the user out and show the login screen.

---

## 2. Rider App Specific Endpoints

*All endpoints below require `Authorization: Bearer <access_token>`.*

### Location & Availability
- **Update Location:** `PUT /auth/rider/location`
  - **Body:** `{ "lat": float, "lng": float }`
  - **Behavior:** Call this on app foreground and periodically when the app is open.
- **Update Availability:** `PUT /auth/rider/availability`
  - **Body:** `{ "is_available": boolean }`
  - **Behavior:** Toggle used on the Home screen to start/stop receiving gigs.
- **Get Profile:** `GET /auth/rider/me`
  - **Response:** `{ "id": "...", "name": "...", "phone": "...", "is_available": true, "earnings": 0.0 }`
  - **Constraint:** Earnings are hardcoded to `0.0` for v1.

### Gig Discovery
- **Endpoint:** `GET /tasks/available?lat={lat}&lng={lng}&radius_km=10.0&limit=50`
- **Response:** Array of Task objects with status `posted`.
- **Constraint:** Use this to populate the Home "Feed" screen.

### Accepting / Rejecting a Gig
- **Accept Task:** `POST /tasks/{task_id}/accept`
  - **Empty Body**
  - **Response (200 OK):** `{ "status": "success", "task_id": "uuid" }`
  - **Edge Case (409 Conflict):** `{"status": "race_lost", "message": "..."}`. Another rider accepted it first, or the poster cancelled it. The client MUST catch 409 and show a "Too slow / Task no longer available" UI, rather than a generic error.
  - **Edge Case (Idempotency):** If the network drops and the client retries, but the rider already successfully won the task on the first attempt, the backend will return a `200 OK`.
- **Reject Task:** `POST /tasks/{task_id}/reject`
  - **Empty Body**
  - **Behavior:** Explicitly removes the task from the rider's feed tracking.

---

## 3. User App Specific Endpoints (Task Creation)

*All endpoints below require `Authorization: Bearer <access_token>`.*

### Creating a Task (Chatbot Flow)
1. **Init Task:** `POST /tasks` (Empty Body) -> Returns Task object (status: `draft`).
2. **Chat with AI:** `POST /tasks/{task_id}/chat`
   - **Body:** `{ "message": "I need a plumber at 123 Main st" }`
   - **Response:** `{ "task": TaskObject, "next_question": "What is your budget?" | null }`
   - **Behavior:** The backend uses an LLM to extract 5 constraints (task_type, location_detail, urgency, budget_range, task_details). 
   - **Constraint:** The client just blindly displays `next_question` as a chat message from the system. If `next_question` is `null`, the backend has successfully extracted all 5 constraints and automatically transitioned the task to `posted` (broadcasting it to riders). The client should then route the user to the "Waiting for Rider" screen.

### Task History
- **Endpoint:** `GET /tasks`
- **Response:** Array of Task objects belonging to the user, newest first.

---

## 4. Shared Endpoints (Both Apps)

### Get Single Task
- **Endpoint:** `GET /tasks/{task_id}`
- **Response:** Task object.

### Live Chat (Post-Match)
Once a task is `rider_matched` or `in_progress`, the chatbot is disabled, and the same chat endpoint is used for live human-to-human chat.
- **Send Message:** `POST /tasks/{task_id}/chat`
  - **Body:** `{ "message": "I am 5 minutes away" }`
- **Get History:** `GET /tasks/{task_id}/chat`
  - **Response:** `[ { "id": "...", "sender_type": "user"|"rider"|"system", "content": "...", "created_at": "..." } ]`

### Task Lifecycle Actions
- **Cancel Task:** `POST /tasks/{task_id}/cancel`
  - **Body:** `{ "reason": "string" }`
- **Complete Task:** `POST /tasks/{task_id}/complete`
  - **Body:** `{ "rating": 5, "rating_note": "Great job" }` (Both optional, 1-5 integer).

---

## 5. Notification & Realtime Strategy

The backend does *not* use WebSockets for v1. It relies entirely on Firebase Cloud Messaging (FCM) Data payloads for realtime updates.

**Expected Push Notification Events (Data Payloads):**
When the app receives a push notification, the client should inspect the `event` key in the data payload and refresh the UI accordingly.

1. `task_posted`: (Received by Riders). A new gig is available nearby.
2. `rider_matched`: (Received by User). A rider accepted your task. Refresh task status.
3. `chat_message`: (Received by User & Rider). A new chat message arrived. Refresh chat history.
4. `task_cancelled`: (Received by User & Rider). The other party cancelled the task.
5. `task_completed`: (Received by User & Rider). The task was marked complete.

**Handling Foreground Notifications:**
If the app is in the foreground and receives an FCM data payload, it should **silently refresh** the relevant data (e.g., re-fetch the task or chat history) without showing a system notification banner.

---

## 6. Global Headers & Error Handling
- **Headers:** Send `Authorization: Bearer <access_token>` on all requests except `/auth/verify` and `/auth/refresh`.
- **401 Unauthorized:** Always catch 401s globally. Attempt a silent token refresh using `/auth/refresh`. If the refresh fails, force logout.
- **422 Unprocessable Entity:** Standard FastAPI validation error. Check the JSON body payload structure.
