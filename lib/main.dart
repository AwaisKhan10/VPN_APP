// ignore_for_file: library_private_types_in_public_api, avoid_print

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VPN App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: VpnHomeScreen(),
    );
  }
}

// ignore: use_key_in_widget_constructors
class VpnHomeScreen extends StatefulWidget {
  @override
  _VpnHomeScreenState createState() => _VpnHomeScreenState();
}

class _VpnHomeScreenState extends State<VpnHomeScreen> {
  bool _isConnected = false;
  bool _isLoading = false; // Add a loading state variable

  // Replace with your WireGuard configuration
  final String _config = '''
  [Interface]
  PrivateKey = YOUR_PRIVATE_KEY
  Address = 10.0.0.2/24
  DNS = 1.1.1.1

  [Peer]
  PublicKey = SERVER_PUBLIC_KEY
  Endpoint = SERVER_ENDPOINT_IP:PORT
  AllowedIPs = 0.0.0.0/0
  PersistentKeepalive = 25
  ''';

  // Method to connect VPN
  Future<void> _connectVpn() async {
    setState(() {
      _isLoading = true; // Start loading
    });

    try {
      // Simulating the VPN connection
      await Future.delayed(const Duration(seconds: 2));
      setState(() {
        _isConnected = true;
      });
      print('VPN connected');
    } catch (e) {
      print('Failed to connect VPN: $e');
    } finally {
      setState(() {
        _isLoading = false; // Stop loading
      });
    }
  }

  // Method to disconnect VPN
  Future<void> _disconnectVpn() async {
    setState(() {
      _isLoading = true; // Start loading
    });

    try {
      // Simulating the VPN disconnection
      await Future.delayed(const Duration(seconds: 2));
      setState(() {
        _isConnected = false;
      });
      print('VPN disconnected');
    } catch (e) {
      print('Failed to disconnect VPN: $e');
    } finally {
      setState(() {
        _isLoading = false; // Stop loading
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('VPN App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              _isConnected ? 'VPN Connected' : 'VPN Disconnected',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            if (_isLoading) // Show loading indicator if connecting or disconnecting
              const CircularProgressIndicator(),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isLoading
                  ? null // Disable button while loading
                  : (_isConnected ? _disconnectVpn : _connectVpn),
              child: Text(_isLoading
                  ? 'Processing...' // Change button text while loading
                  : (_isConnected ? 'Disconnect VPN' : 'Connect VPN')),
            ),
          ],
        ),
      ),
    );
  }
}
