
import 'package:equatable/equatable.dart';
import 'package:webview_flutter/webview_flutter.dart';

abstract class WebViewState extends Equatable {
  const WebViewState();

  @override
  List<Object?> get props => [];
}

class WebViewInitial extends WebViewState {
  const WebViewInitial();
}
class WebViewLoading extends WebViewState {
  const WebViewLoading();
}

class WebViewLoaded extends WebViewState {
  final WebViewController controller;

  const WebViewLoaded({required this.controller});
}
