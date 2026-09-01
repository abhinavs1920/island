import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io' show Platform;

import '../providers/route_provider.dart';
import '../../task_detail/providers/task_detail_provider.dart';

class GigNavigationScreen extends ConsumerStatefulWidget {
  final String taskId;
  const GigNavigationScreen({super.key, required this.taskId});

  @override
  ConsumerState<GigNavigationScreen> createState() => _GigNavigationScreenState();
}

class _GigNavigationScreenState extends ConsumerState<GigNavigationScreen> {
  bool _isLoadingLocation = true;
  String? _locationError;
  Position? _position;

  @override
  void initState() {
    super.initState();
    _initLocationAndRoute();
  }

  Future<void> _initLocationAndRoute() async {
    setState(() {
      _isLoadingLocation = true;
      _locationError = null;
    });

    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        throw const LocationServiceDisabledException();
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw const PermissionDeniedException('Location permissions are denied');
        }
      }

      if (permission == LocationPermission.deniedForever) {
        throw const PermissionDeniedException('Location permissions are permanently denied');
      }

      final position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      
      setState(() {
        _position = position;
        _isLoadingLocation = false;
      });

      ref.read(routeProvider.notifier).fetchRoute(
            widget.taskId,
            position.latitude,
            position.longitude,
          );
    } catch (e) {
      setState(() {
        if (e is LocationServiceDisabledException) {
          _locationError = 'Location services are disabled.';
        } else if (e is PermissionDeniedException) {
          _locationError = e.message ?? 'Permission denied';
        } else {
          _locationError = 'Failed to get location: $e';
        }
        _isLoadingLocation = false;
      });
    }
  }

  void _openInMaps() async {
    final taskState = ref.read(taskDetailProvider(widget.taskId));
    final taskData = taskState.value;
    
    if (taskData == null || taskData['constraints'] == null) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No destination coordinates available')),
        );
      }
      return;
    }
    
    final constraints = taskData['constraints'] as Map<String, dynamic>;
    final destLat = constraints['destination_lat'];
    final destLng = constraints['destination_lng'];

    if (destLat == null || destLng == null) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No destination coordinates available')),
        );
      }
      return;
    }

    Uri mapUrl;
    if (Platform.isIOS) {
      mapUrl = Uri.parse('maps://?daddr=$destLat,$destLng');
    } else {
      mapUrl = Uri.parse('google.navigation:q=$destLat,$destLng&mode=d');
    }

    if (await canLaunchUrl(mapUrl)) {
      await launchUrl(mapUrl);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Could not launch maps app')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;
    
    final routeAsync = ref.watch(routeProvider);

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        title: const Text('Navigation'),
        leading: const BackButton(),
      ),
      body: _isLoadingLocation 
        ? const Center(child: CircularProgressIndicator())
        : _locationError != null
          ? Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(_locationError!, textAlign: TextAlign.center),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _initLocationAndRoute,
                    child: const Text('Retry'),
                  ),
                ],
              ),
            )
          : Column(
              children: [
                Expanded(
                  flex: 5,
                  child: Stack(
                    children: [
                      Container(
                        color: colorScheme.surfaceContainerHighest,
                        child: Center(
                          child: Text(
                            'Map View',
                            style: textTheme.titleMedium?.copyWith(
                              color: colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ),
                      ),
                      if (routeAsync.hasData && routeAsync.value != null)
                        Positioned(
                          top: 16,
                          left: 0,
                          right: 0,
                          child: Center(
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                              decoration: BoxDecoration(
                                color: colorScheme.surface,
                                borderRadius: BorderRadius.circular(24),
                                border: Border.all(color: colorScheme.outlineVariant),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 4,
                                  ),
                                ],
                              ),
                              child: Text(
                                '${routeAsync.value!.distanceKm.toStringAsFixed(1)} km · ~${routeAsync.value!.etaMinutes.round()} min',
                                style: textTheme.labelLarge?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: colorScheme.onSurface,
                                ),
                              ),
                            ),
                          ),
                        ),
                      Positioned(
                        bottom: 16,
                        right: 16,
                        child: FloatingActionButton.extended(
                          onPressed: _openInMaps,
                          icon: const Icon(Icons.map),
                          label: const Text('Open in Maps'),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    decoration: BoxDecoration(
                      color: colorScheme.surface,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 4,
                          offset: const Offset(0, -2),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Delivery',
                              style: textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            routeAsync.when(
                              data: (route) => route != null 
                                ? Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        '${route.etaMinutes.round()} min',
                                        style: textTheme.titleMedium?.copyWith(
                                          color: colorScheme.primary,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        '${route.distanceKm.toStringAsFixed(1)} km',
                                        style: textTheme.labelMedium?.copyWith(
                                          color: colorScheme.onSurfaceVariant,
                                        ),
                                      ),
                                    ],
                                  )
                                : const SizedBox.shrink(),
                              loading: () => const Text('Loading route...'),
                              error: (err, st) => GestureDetector(
                                onTap: _initLocationAndRoute,
                                child: Text(
                                  'Could not fetch route. Tap to retry.',
                                  style: textTheme.bodySmall?.copyWith(color: colorScheme.error),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        ElevatedButton.icon(
                          onPressed: () => context.push('/chat/${widget.taskId}'),
                          icon: const Icon(Icons.chat_bubble),
                          label: const Text('Chat'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: colorScheme.primaryContainer,
                            foregroundColor: colorScheme.onPrimaryContainer,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                        ),
                        const SizedBox(height: 12),
                        FilledButton.icon(
                          onPressed: _openInMaps,
                          icon: const Icon(Icons.navigation),
                          label: const Text('Open in Google Maps'),
                          style: FilledButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
