import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gestion_bufete_app/src/features/gestion_bufete/presentation/bloc/gestion_bufete_bloc.dart';
import 'package:gestion_bufete_app/src/features/gestion_bufete/presentation/screens/home_screen.dart';
import 'package:responsive_framework/responsive_framework.dart';

import 'core/dependency_inyection/dependency_inyection.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<GestionBufeteBloc>(),
      child: MaterialApp(
        builder: (context, child) => ResponsiveWrapper.builder(
            ClampingScrollWrapper.builder(context, child!),
            maxWidth: 1200,
            minWidth: 450,
            defaultScale: true,
            breakpoints: [
              const ResponsiveBreakpoint.resize(450, name: MOBILE),
              const ResponsiveBreakpoint.autoScale(800, name: TABLET),
              const ResponsiveBreakpoint.autoScale(1000, name: TABLET),
              const ResponsiveBreakpoint.resize(1200, name: DESKTOP),
              const ResponsiveBreakpoint.autoScale(2460, name: "4K"),
            ],
            background: Container(color: const Color(0xFFF5F5F5))),
        debugShowCheckedModeBanner: false,
        title: 'Gestion Bufete',
        home: const HomeScreen(),
      ),
    );
  }
}
