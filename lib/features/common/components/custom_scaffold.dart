import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class CustomScaffold extends StatelessWidget {
  final Color backgroundColor;
  final Widget body;

  const CustomScaffold({
    super.key,
    this.backgroundColor = Colors.white,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    // Default constraint for WEB
    /*
      H: 852.0
      W: 393.0
    */
    const maxH = 800.0;
    const maxW = 360.0;

    return Scaffold(
      backgroundColor: kIsWeb ? Colors.amber : backgroundColor,
      body: LayoutBuilder(
        builder: (context, constraint) {
          if (kIsWeb) {
            // Default constraint for WEB
            return Padding(
              padding: const EdgeInsets.all(16),
              child: Center(
                child: Container(
                  constraints: const BoxConstraints(
                    maxHeight: maxH,
                    maxWidth: maxW,
                  ),
                  decoration: BoxDecoration(
                    color: backgroundColor,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x49000000),
                        blurRadius: 10,
                        offset: Offset(3, 4),
                        spreadRadius: 0,
                      ),
                      BoxShadow(
                        color: Color(0x42000000),
                        blurRadius: 19,
                        offset: Offset(11, 15),
                        spreadRadius: 0,
                      ),
                      BoxShadow(
                        color: Color(0x26000000),
                        blurRadius: 25,
                        offset: Offset(25, 34),
                        spreadRadius: 0,
                      ),
                      BoxShadow(
                        color: Color(0x0A000000),
                        blurRadius: 30,
                        offset: Offset(44, 61),
                        spreadRadius: 0,
                      ),
                      BoxShadow(
                        color: Color(0x02000000),
                        blurRadius: 33,
                        offset: Offset(68, 95),
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                  child: body,
                ),
              ),
            );
          }
          return body;
        },
      ),
    );
  }
}
