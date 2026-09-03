import '../../features/chat/view/chat_screen.dart';
import '../../features/activegig/view/gig_navigation_screen.dart';

import '../../features/support/view/help_and_support_screen.dart';
import '../../features/taskdetail/view/task_detail_loading_screen.dart';
import '../../features/registration/view/document_upload_screen.dart';
import '../../features/earnings/view/daily_weekly_targets_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../features/errors/view/session_expired_screen.dart';
import '../../features/settings/view/settings_screen.dart';
import '../../features/activegig/view/navigation_handoff_screen.dart';
import '../../features/task_detail/view/task_detail_screen.dart';
import '../../features/onboarding/view/phone_entry_error_screen.dart';
import '../../features/notifications/view/notification_center_screen.dart';
import '../../features/earnings/view/add_edit_bank_account_screen.dart';
import '../../features/misc/view/change_phone_number_screen.dart';
import '../../features/profile/view/rewards_screen.dart';
import '../../features/history/view/completed_gig_detail_screen.dart';
import '../../features/taskdetail/view/race_lost_screen.dart';
import '../../features/taskchat/view/call_ended_screen.dart';
import '../../features/support/view/emergency_sos_screen.dart';
import '../../features/taskdetail/view/cancel_confirmation_screen.dart';
import '../widgets/scaffold_with_nav_bar.dart';
import '../../features/profile/view/my_documents_screen.dart';
import '../../features/errors/view/account_suspended_screen.dart';
import '../../features/profile/view/profile_edit_screen.dart';
import '../../features/taskchat/view/task_chat_reconnecting_screen.dart';
import '../../features/history/view/gig_history_list_screen.dart';
import '../../features/support/view/raise_dispute_screen.dart';
import '../../features/taskchat/view/incoming_call_screen.dart';
import '../../features/activegig/view/post_gig_summary_screen.dart';
import '../../features/misc/view/rating_submitted_screen.dart';
import '../../features/misc/view/earnings_empty_state_screen.dart';
import '../../features/activegig/view/proof_of_delivery_screen.dart';
import '../../features/misc/view/report_submitted_screen.dart';
import '../../features/earnings/view/payout_success_screen.dart';
import '../../features/notifications/widgets/incoming_task_alert_bottom_sheet.dart';
import '../../features/notifications/view/notification_center_empty_screen.dart';
import '../../features/onboarding/view/splash_screen.dart';
import '../../features/notifications/view/location_permission_screen.dart';
import '../../features/onboarding/view/welcome_screen.dart';
import '../../features/taskchat/view/task_chat_error_screen.dart';
import '../../features/support/view/sos_alert_sent_confirmation_screen.dart';
import '../../features/registration/view/vehicle_details_screen.dart';
import '../../features/profile/view/profile_screen.dart';
import '../../features/taskchat/view/task_chat_empty_screen.dart';
import 'package:flutter/material.dart';
import '../../features/profile/view/profile_loading_screen.dart';
import '../../features/errors/view/app_update_required_screen.dart';
import '../../features/errors/view/system_error_fallback_screen.dart';
import '../../features/taskdetail/view/task_detail_error_screen.dart';
import '../../features/taskdetail/view/cancel_confirmation_loading_screen.dart';
import '../../features/misc/view/earnings_summary_loading_screen.dart';
import '../../features/settings/view/notification_settings_screen.dart';
import '../../features/onboarding/view/phone_entry_screen.dart';
import '../../features/misc/view/logout_confirmation_dialog.dart';
import '../../features/support/view/report_customer_screen.dart';
import '../../features/registration/view/personal_info_screen.dart';
import '../../features/onboarding/view/otp_verification_error_screen.dart';
import '../../features/notifications/view/location_permission_denied_screen.dart';
import '../../features/earnings/view/withdraw_earnings_screen.dart';
import '../../features/support/view/dispute_status_tracking_screen.dart';
import '../../features/earnings/view/earnings_history_screen.dart';
import '../../features/earnings/view/earnings_screen.dart';
import '../../features/notifications/view/notification_permission_screen.dart';
import '../../features/registration/view/doc_rejected_screen.dart';
import '../../features/misc/view/earnings_summary_screen.dart';
import '../../features/taskdetail/view/matched_confirmation_screen.dart';
import '../../features/misc/view/rate_customer_screen.dart';
import '../../features/activegig/view/complete_confirmation_screen.dart';
import '../../features/home/view/home_screen.dart';
import '../../features/errors/view/shader_screen.dart';
import '../../features/activegig/view/active_gig_in_progress_screen.dart';
import '../../features/notifications/view/notification_permission_denied_screen.dart';
import '../../features/activegig/view/arrived_dropoff_screen.dart';
import '../../features/onboarding/view/otp_verification_screen.dart';
import '../../features/activegig/view/arrived_pickup_screen.dart';
import '../../features/misc/view/earnings_error_state_screen.dart';
import '../../features/registration/view/doc_approved_screen.dart';
import '../../features/registration/view/doc_pending_screen.dart';
import '../../features/history/view/cancelled_gig_detail_screen.dart';
import 'package:go_router/go_router.dart';
import '../../features/profile/view/ratings_screen.dart';
import '../../features/taskchat/view/masked_call_screen.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: '/home',
    routes: [
      ShellRoute(
        builder: (context, state, child) {
          return ScaffoldWithNavBar(child: child);
        },
        routes: [
          GoRoute(
            path: '/home',
            builder: (context, state) => const HomeScreen(),
          ),
          GoRoute(
            path: '/profile',
            builder: (context, state) => const ProfileScreen(),
          ),
          GoRoute(
            path: '/earnings',
            builder: (context, state) => const EarningsScreen(),
          ),
          GoRoute(
            path: '/chat/:id',
            builder: (context, state) => ChatScreen(taskId: state.pathParameters['id'] ?? 'latest'),
          ),
        ],
      ),
      
      GoRoute(
        path: '/errors/account-suspended',
        builder: (context, state) => const AccountSuspendedScreen(),
      ),
      GoRoute(
        path: '/activegig/active-gig-in-progress',
        builder: (context, state) => const ActiveGigInProgressScreen(),
      ),
      GoRoute(
        path: '/earnings/add-edit-bank-account',
        builder: (context, state) => const AddEditBankAccountScreen(),
      ),
      GoRoute(
        path: '/errors/app-update-required',
        builder: (context, state) => const AppUpdateRequiredScreen(),
      ),
      GoRoute(
        path: '/activegig/arrived-dropoff',
        builder: (context, state) => const ArrivedDropoffScreen(),
      ),
      GoRoute(
        path: '/activegig/arrived-pickup',
        builder: (context, state) => const ArrivedPickupScreen(),
      ),
      GoRoute(
        path: '/taskchat/call-ended',
        builder: (context, state) => const CallEndedScreen(),
      ),
      GoRoute(
        path: '/taskdetail/cancel-confirmation-loading',
        builder: (context, state) => const CancelConfirmationLoadingScreen(),
      ),
      GoRoute(
        path: '/taskdetail/cancel-confirmation',
        builder: (context, state) => const CancelConfirmationScreen(),
      ),
      GoRoute(
        path: '/history/cancelled-gig-detail',
        builder: (context, state) => CancelledGigDetailScreen(gigId: state.extra as String?),
      ),
      GoRoute(
        path: '/misc/change-phone-number',
        builder: (context, state) => const ChangePhoneNumberScreen(),
      ),
      GoRoute(
        path: '/activegig/complete-confirmation',
        builder: (context, state) => const CompleteConfirmationScreen(),
      ),
      GoRoute(
        path: '/history/completed-gig-detail',
        builder: (context, state) => CompletedGigDetailScreen(gigId: state.extra as String? ?? '8492'),
      ),
      GoRoute(
        path: '/earnings/daily-weekly-targets',
        builder: (context, state) => const DailyWeeklyTargetsScreen(),
      ),
      GoRoute(
        path: '/support/dispute-status-tracking',
        builder: (context, state) => const DisputeStatusTrackingScreen(),
      ),
      GoRoute(
        path: '/registration/doc-approved',
        builder: (context, state) => const DocApprovedScreen(),
      ),
      GoRoute(
        path: '/registration/doc-pending',
        builder: (context, state) => const DocPendingScreen(),
      ),
      GoRoute(
        path: '/registration/doc-rejected',
        builder: (context, state) => const DocRejectedScreen(),
      ),
      GoRoute(
        path: '/registration/document-upload',
        builder: (context, state) => const DocumentUploadScreen(),
      ),
      GoRoute(
        path: '/misc/earnings-empty-state',
        builder: (context, state) => const EarningsEmptyStateScreen(),
      ),
      GoRoute(
        path: '/misc/earnings-error-state',
        builder: (context, state) => const EarningsErrorStateScreen(),
      ),
      GoRoute(
        path: '/earnings/earnings-history',
        builder: (context, state) => const EarningsHistoryScreen(),
      ),
      GoRoute(
        path: '/misc/earnings-summary-loading',
        builder: (context, state) => const EarningsSummaryLoadingScreen(),
      ),
      GoRoute(
        path: '/misc/earnings-summary',
        builder: (context, state) => const EarningsSummaryScreen(),
      ),
      GoRoute(
        path: '/support/emergency-sos',
        builder: (context, state) => const EmergencySosScreen(),
      ),
      GoRoute(
        path: '/history/gig-history-list',
        builder: (context, state) => const GigHistoryListScreen(),
      ),
      GoRoute(
        path: '/support/help-and-support',
        builder: (context, state) => const HelpAndSupportScreen(),
      ),
      GoRoute(
        path: '/support/help-center',
        builder: (context, state) => const HelpAndSupportScreen(),
      ),
      GoRoute(
        path: '/taskchat/incoming-call',
        builder: (context, state) => const IncomingCallScreen(),
      ),
      GoRoute(
        path: '/notifications/incoming-task-alert-bottom-sheet',
        builder: (context, state) => const IncomingTaskAlertBottomSheet(),
      ),
      GoRoute(
        path: '/notifications/location-permission-denied',
        builder: (context, state) => const LocationPermissionDeniedScreen(),
      ),
      GoRoute(
        path: '/notifications/location-permission',
        builder: (context, state) => const LocationPermissionScreen(),
      ),
      GoRoute(
        path: '/misc/logout-confirmation-dialog',
        builder: (context, state) => const LogoutConfirmationDialog(),
      ),
      GoRoute(
        path: '/taskchat/masked-call',
        builder: (context, state) => const MaskedCallScreen(),
      ),
      GoRoute(
        path: '/taskdetail/matched-confirmation',
        builder: (context, state) => const MatchedConfirmationScreen(),
      ),
      GoRoute(
        path: '/profile/my-documents',
        builder: (context, state) => const MyDocumentsScreen(),
      ),
      GoRoute(
        path: '/profile/documents',
        builder: (context, state) => const MyDocumentsScreen(),
      ),
      GoRoute(
        path: '/activegig/navigation-handoff',
        builder: (context, state) => const NavigationHandoffScreen(),
      ),
      GoRoute(
        path: '/notifications/notification-center-empty',
        builder: (context, state) => const NotificationCenterEmptyScreen(),
      ),
      GoRoute(
        path: '/notifications/notification-center',
        builder: (context, state) => const NotificationCenterScreen(),
      ),
      GoRoute(
        path: '/notifications/notification-permission-denied',
        builder: (context, state) => const NotificationPermissionDeniedScreen(),
      ),
      GoRoute(
        path: '/notifications/notification-permission',
        builder: (context, state) => const NotificationPermissionScreen(),
      ),
      GoRoute(
        path: '/settings/notification-settings',
        builder: (context, state) => const NotificationSettingsScreen(),
      ),
      GoRoute(
        path: '/onboarding/otp-verification-error',
        builder: (context, state) => const OtpVerificationErrorScreen(),
      ),
      GoRoute(
        path: '/onboarding/otp-verification',
        builder: (context, state) => const OtpVerificationScreen(),
      ),
      GoRoute(
        path: '/earnings/payout-success',
        builder: (context, state) => const PayoutSuccessScreen(),
      ),
      GoRoute(
        path: '/registration/personal-info',
        builder: (context, state) => const PersonalInfoScreen(),
      ),
      GoRoute(
        path: '/onboarding/phone-entry-error',
        builder: (context, state) => const PhoneEntryErrorScreen(),
      ),
      GoRoute(
        path: '/onboarding/phone-entry',
        builder: (context, state) => const PhoneEntryScreen(),
      ),
      GoRoute(
        path: '/activegig/post-gig-summary',
        builder: (context, state) => const PostGigSummaryScreen(),
      ),
      GoRoute(
        path: '/profile/profile-edit',
        builder: (context, state) => const ProfileEditScreen(),
      ),
      GoRoute(
        path: '/profile/profile-loading',
        builder: (context, state) => const ProfileLoadingScreen(),
      ),
      GoRoute(
        path: '/activegig/proof-of-delivery',
        builder: (context, state) => const ProofOfDeliveryScreen(),
      ),
      GoRoute(
        path: '/taskdetail/race-lost',
        builder: (context, state) => const RaceLostScreen(),
      ),
      GoRoute(
        path: '/support/raise-dispute',
        builder: (context, state) => const RaiseDisputeScreen(),
      ),
      GoRoute(
        path: '/misc/rate-customer',
        builder: (context, state) => const RateCustomerScreen(),
      ),
      GoRoute(
        path: '/misc/rating-submitted',
        builder: (context, state) => const RatingSubmittedScreen(),
      ),
      GoRoute(
        path: '/profile/ratings',
        builder: (context, state) => const RatingsScreen(),
      ),
      GoRoute(
        path: '/support/report-customer',
        builder: (context, state) => const ReportCustomerScreen(),
      ),
      GoRoute(
        path: '/misc/report-submitted',
        builder: (context, state) => const ReportSubmittedScreen(),
      ),
      GoRoute(
        path: '/profile/rewards',
        builder: (context, state) => const RewardsScreen(),
      ),
      GoRoute(
        path: '/errors/session-expired',
        builder: (context, state) => const SessionExpiredScreen(),
      ),
      GoRoute(
        path: '/session-expired',
        builder: (context, state) => const SessionExpiredScreen(),
      ),
      GoRoute(
        path: '/settings/settings',
        builder: (context, state) => const SettingsScreen(),
      ),
      GoRoute(
        path: '/settings',
        builder: (context, state) => const SettingsScreen(),
      ),
      GoRoute(
        path: '/errors/shader',
        builder: (context, state) => const ShaderScreen(),
      ),
      GoRoute(
        path: '/support/sos-alert-sent-confirmation',
        builder: (context, state) => const SosAlertSentConfirmationScreen(),
      ),

      GoRoute(
        path: '/splash-onboarding',
        builder: (context, state) => const SplashScreen(),
      ),

      GoRoute(
        path: '/errors/system-error-fallback',
        builder: (context, state) => const SystemErrorFallbackScreen(),
      ),
      GoRoute(
        path: '/taskchat/task-chat-empty',
        builder: (context, state) => const TaskChatEmptyScreen(),
      ),
      GoRoute(
        path: '/taskchat/task-chat-error',
        builder: (context, state) => const TaskChatErrorScreen(),
      ),
      GoRoute(
        path: '/taskchat/task-chat-reconnecting',
        builder: (context, state) => const TaskChatReconnectingScreen(),
      ),

      GoRoute(
        path: '/taskdetail/task-detail-error',
        builder: (context, state) => const TaskDetailErrorScreen(),
      ),
      GoRoute(
        path: '/taskdetail/task-detail-loading',
        builder: (context, state) => const TaskDetailLoadingScreen(),
      ),
      GoRoute(
        path: '/task/:id',
        builder: (context, state) => TaskDetailScreen(taskId: state.pathParameters['id'] ?? ''),
      ),
      GoRoute(
        path: '/registration/vehicle-details',
        builder: (context, state) => const VehicleDetailsScreen(),
      ),
      GoRoute(
        path: '/activegig/navigation',
        builder: (context, state) => GigNavigationScreen(taskId: state.extra as String? ?? ''),
      ),
      GoRoute(
        path: '/onboarding/welcome',
        builder: (context, state) => const WelcomeScreen(),
      ),
      GoRoute(
        path: '/earnings/withdraw-earnings',
        builder: (context, state) => const WithdrawEarningsScreen(),
      ),
    ],
  );
});
