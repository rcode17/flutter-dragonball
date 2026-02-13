import 'package:dragonball/features/documentations/presentation/bloc/documentation_state.dart';
import 'package:dragonball/features/documentations/presentation/bloc/web_view_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../core/network/env.dart';
import '../../../planets/presentation/bloc/planet_bloc.dart';
import '../../../planets/presentation/bloc/planet_state.dart';

class DocumentationPage extends StatelessWidget {
  const DocumentationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WebViewBloc, WebViewState>(
      builder: (context, state) {
        if (state is WebViewLoading) {
          return const CircularProgressIndicator();
        }

        /*if(state is WebViewLoaded){
          return Padding(
            padding: const EdgeInsets.all(28.0),
            child: Container(
              height: 400,
              width: 400,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: WebViewWidget(controller: state.controller),
              ),
            ),
          );
        }*/

        late final WebViewController controller;

        controller = WebViewController();

        controller
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
          ..setNavigationDelegate(
            NavigationDelegate(
              onPageFinished: (url) {
                final token = "abc123TOKEN";

                controller.runJavaScript(
                    "receiveTokenFromFlutter('$token');"
                );
              },
            ),
          )
          ..loadRequest(
            Uri.parse('https://carrusel-1ed6e.web.app/'),
          );


        return WebViewWidget(controller: controller);





      },

    );

  }
}
