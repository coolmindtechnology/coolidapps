// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'package:coolappflutter/data/networks/endpoint/api_endpoint.dart';
import 'package:coolappflutter/data/provider/provider_user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:provider/provider.dart';

class DeletedAccount extends StatefulWidget {
  const DeletedAccount({super.key});

  @override
  State<DeletedAccount> createState() => _DeletedAccountState();
}

class _DeletedAccountState extends State<DeletedAccount> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Delete Account',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: ChangeNotifierProvider(
        create: (_) => ProviderUser(),
        child: Consumer<ProviderUser>(
          builder: (context, provider, child) {
            return Stack(
              children: [
                InAppWebView(
                  initialUrlRequest: URLRequest(
                    url: Uri.parse(
                        '${ApiEndpoint.baseUrl}/users/delete/account'),
                  ),
                  onLoadStart: (controller, url) {
                    provider.setLoading(true);
                  },
                  onLoadStop: (controller, url) async {
                    provider.setLoading(false);
                  },
                  onLoadError: (controller, url, code, message) {
                    provider.setLoading(false);
                  },
                  onLoadHttpError: (controller, url, statusCode, description) {
                    provider.setLoading(false);
                  },
                  initialOptions: InAppWebViewGroupOptions(
                    android: AndroidInAppWebViewOptions(
                      useHybridComposition: true,
                    ),
                  ),
                ),
                if (provider.isLoading)
                  const Center(child: CircularProgressIndicator()),
              ],
            );
          },
        ),
      ),
    );
  }
}
