import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/cart_model.dart';
import 'models/counter_model.dart';
import 'pages/product_list_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartModel()),
        ChangeNotifierProvider(create: (_) => CounterModel()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Modern Store',
        theme: ThemeData(
          scaffoldBackgroundColor: const Color(0xFFF5EFE6),
          primaryColor: const Color(0xFF6B4F4F),
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF6B4F4F),
          ),
          appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xFF6B4F4F),
            foregroundColor: Colors.white,
            elevation: 0,
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFA47551),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
          ),
        ),
        home: const ProductListPage(),
      ),
    );
  }
}