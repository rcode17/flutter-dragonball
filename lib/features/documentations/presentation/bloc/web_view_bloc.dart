
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'documentation_event.dart';
import 'documentation_state.dart';

class WebViewBloc extends Bloc<WebViewEvent, WebViewState> {
  late final WebViewController controller;

  WebViewBloc() : super(const WebViewInitial()) {
    on<CarrouselStarted>(_onCarrouselStarted);
  }

  void _onCarrouselStarted(CarrouselStarted event, Emitter<WebViewState> emit) async {
    emit(const WebViewLoading());

    emit(WebViewLoaded(controller: _initializeController()));
  }

  WebViewController _initializeController()  {
    return controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {},
          onPageFinished: (String url) {
            controller.runJavaScript(
              "document.getElementById('product-card-tc-1')?.scrollIntoView();",
            );
          },
        ),
      )
      ..loadRequest(Uri.parse('https://carrusel-1ed6e.web.app/'));
  }
}
