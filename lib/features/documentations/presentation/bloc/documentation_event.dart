import 'package:equatable/equatable.dart';

abstract class WebViewEvent extends Equatable {
  const WebViewEvent();

  @override
  List<Object?> get props => [];
}

class CarrouselStarted extends WebViewEvent {
  const CarrouselStarted();
}
