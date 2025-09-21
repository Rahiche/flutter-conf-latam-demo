import 'package:experience_common/experience_client.dart';

class ServerpodService {
  ServerpodService(
    String host, {
    dynamic securityContext,
    AuthenticationKeyManager? authenticationKeyManager,
    Duration? streamingConnectionTimeout,
    Duration? connectionTimeout,
    dynamic Function(MethodCallContext, Object, StackTrace)? onFailedCall,
    dynamic Function(MethodCallContext)? onSucceededCall,
    bool? disconnectStreamsOnLostInternetConnection,
  }) {
    _client = Client(
      host,
      securityContext: securityContext,
      authenticationKeyManager: authenticationKeyManager,
      streamingConnectionTimeout: streamingConnectionTimeout,
      connectionTimeout: connectionTimeout,
      onFailedCall: onFailedCall,
      onSucceededCall: onSucceededCall,
      disconnectStreamsOnLostInternetConnection:
          disconnectStreamsOnLostInternetConnection,
    );
  }

  late final Client _client;

  Modules get modules => _client.modules;

  EndpointExperience get experiences => _client.experience;

  EndpointUser get users => _client.user;

  EndpointCategory get categories => _client.category;

  void setConnectivityMonitor(ConnectivityMonitor connectivityMonitor) {
    _client.connectivityMonitor = connectivityMonitor;
  }
}
