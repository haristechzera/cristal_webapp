import 'package:cristal_webapp/registerScreen.dart';
import 'package:cristal_webapp/registrationCubit/register_cubit.dart';
import 'package:cristal_webapp/services/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await ServiceLocator.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // return const MaterialApp(
    //   home: RegisterCodePage(),
    // );
    return MultiBlocProvider(
      providers: [
        BlocProvider<RegisterCubit>(create: (_) => sl<RegisterCubit>()),

      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Cristal',
        theme: ThemeData(
          fontFamily: 'TitilliumWeb',
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          appBarTheme: const AppBarTheme(
            elevation: 0,
            scrolledUnderElevation: 0,
            surfaceTintColor: Colors.transparent,
            // systemOverlayStyle: SystemUiOverlayStyle(
            //   statusBarColor: AppColors.theme,
            //   statusBarIconBrightness: Brightness.dark,
            //   statusBarBrightness: Brightness.light,
            // ),
          ),
        ),
        home: const RegisterCodePage(),
      ),
    );
  }
}

