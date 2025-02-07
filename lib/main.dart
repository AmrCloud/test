// import 'package:base/app/bloc/settings_cubit.dart';
// import 'package:base/configurations/app_states.dart';
// import 'package:base/features/products_search/ui/blocs/products_categories_bloc.dart';
// import 'package:base/features/products_search/ui/blocs/products_search_bloc.dart';
// import 'package:base/features/products_search/ui/screens/products_search_screen.dart';
// import 'package:base/navigation/app_routes.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_localizations/flutter_localizations.dart';

// import 'firebase_options.dart';
// import 'navigation/route_generator.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => SettingsCubit.instance,
//       child: BlocBuilder<SettingsCubit, AppStates>(
//         builder: (context, state) {
//           return MaterialApp(
//             theme: SettingsCubit.instance.isDarkMode ? ThemeData.dark() : ThemeData.light(),
//             locale: SettingsCubit.instance.locale,
//             onGenerateRoute: generateRoute,
//             initialRoute: AppRoutes.login,
//             supportedLocales: const [
//               Locale('ar'),
//               Locale('en'),
//             ],
//             localizationsDelegates: [
//               // AppLocalizationsDelegate(),
//               GlobalMaterialLocalizations.delegate,
//               GlobalWidgetsLocalizations.delegate,
//               GlobalCupertinoLocalizations.delegate,
//             ],
//           );
//         },
//       ),
//     );
//   }
// }

import 'package:base/features/home/ui/blocks/home_product_cubit.dart';
import 'package:base/features/home/ui/screens/homepage.dart';
import 'package:base/network/network_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        create: (context) =>
            ProductCubit(NetworkHandler.instance)..fetchProducts(),
        child: const HomePage(),
      ),
    );
  }
}
