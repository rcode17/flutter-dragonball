import 'package:dragonball/features/documentations/presentation/bloc/web_view_bloc.dart';
import 'package:get_it/get_it.dart';

final gt = GetIt.instance;

Future<void> initDocumentationInjector() async {
  gt.registerFactory<WebViewBloc>(
        () => WebViewBloc(),
  );
}
