import 'package:flutter/material.dart';

const textPrimary = Color(0xFFFFFFFF);
const textPrimaryLight = Color(0xFF000000);

class Themes {
  final ThemeData darkTheme = ThemeData.dark().copyWith(
    colorScheme: ColorScheme.fromSwatch().copyWith(
      surface: const Color(0xFF0e0e10),
      secondary: const Color(0xFF18181b),
      error: const Color(0xFFEC0808),
      surfaceContainerHigh: const Color(0xFF0e0e10),

      //buttons color
      tertiary: Colors.deepPurpleAccent[200],
      tertiaryContainer: Colors.grey[850],
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: textPrimary),
      bodyMedium: TextStyle(color: textPrimary),
      bodySmall: TextStyle(color: textPrimary),
      titleLarge: TextStyle(color: textPrimary),
      titleMedium: TextStyle(color: textPrimary),
      titleSmall: TextStyle(color: textPrimary),
      displayLarge: TextStyle(color: textPrimary),
      displayMedium: TextStyle(color: textPrimary),
      displaySmall: TextStyle(color: textPrimary),
      headlineLarge: TextStyle(color: textPrimary),
      headlineMedium: TextStyle(color: textPrimary),
      headlineSmall: TextStyle(color: textPrimary),
      labelLarge: TextStyle(color: textPrimary),
      labelMedium: TextStyle(color: textPrimary),
      labelSmall: TextStyle(color: textPrimary),
    ),
    primaryIconTheme: const IconThemeData(color: Colors.white),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey[600]!),
      ),
      hintStyle: const TextStyle(
        color: Color.fromARGB(255, 75, 75, 75),
        fontSize: 16,
      ),
      helperStyle: const TextStyle(
        color: Colors.white,
      ),
      labelStyle: TextStyle(
        color: Colors.deepPurpleAccent[200],
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey[600]!),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.deepPurpleAccent[200]!),
      ),
      iconColor: Colors.white,
      prefixIconColor: Colors.white,
    ),
    tabBarTheme: TabBarThemeData(
      labelColor: Colors.deepPurpleAccent[200],
      unselectedLabelColor: Colors.white,
      dividerColor: Colors.transparent,
      indicatorColor: Colors.deepPurpleAccent[200],
      labelPadding: const EdgeInsets.symmetric(horizontal: 30),
      indicatorSize: TabBarIndicatorSize.tab,
    ),
    appBarTheme: const AppBarTheme(
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 18,
      ),
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
      backgroundColor: Color(0xFF18181b),
      surfaceTintColor: Colors.transparent,
      centerTitle: false,
    ),
    dividerTheme: const DividerThemeData(
      thickness: 2,
      indent: 0,
      endIndent: 0,
      color: Color(0xFF18181b),
    ),
    textButtonTheme: const TextButtonThemeData(
      style: ButtonStyle(
        textStyle: WidgetStatePropertyAll(
          TextStyle(
            fontSize: 12,
          ),
        ),
        foregroundColor: WidgetStatePropertyAll(Colors.white),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        textStyle: const WidgetStatePropertyAll(
          TextStyle(
            fontSize: 12,
          ),
        ),
        foregroundColor: const WidgetStatePropertyAll(Colors.white),
        backgroundColor: WidgetStatePropertyAll(Colors.deepPurpleAccent[200]),
      ),
    ),
    chipTheme: ChipThemeData(
      deleteIconColor: Colors.white,
      labelStyle: const TextStyle(
        color: Colors.white,
      ),
      side: const BorderSide(
        color: Colors.white,
      ),
      disabledColor: const Color(0xFF18181b),
      selectedColor: Colors.deepPurpleAccent[200],
      iconTheme: const IconThemeData(color: Colors.white),
    ),
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith(
        (Set<WidgetState> states) {
          if (states.contains(WidgetState.selected)) {
            return Colors.white;
          }
          if (states.contains(WidgetState.disabled)) {
            return null;
          }
          return Colors.white;
        },
      ),
      trackColor: WidgetStateProperty.resolveWith(
        (Set<WidgetState> states) {
          if (states.contains(WidgetState.selected)) {
            return Colors.deepPurpleAccent[200];
          }
          if (states.contains(WidgetState.disabled)) {
            return Colors.grey[850];
          }
          return Colors.grey[850];
        },
      ),
    ),
    sliderTheme: SliderThemeData(
      activeTrackColor: Colors.deepPurpleAccent[200],
      inactiveTrackColor: Colors.grey[850],
      thumbColor: Colors.white,
      // overlayColor: Colors.deepPurpleAccent[200],
      // trackHeight: 2,
      // thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 8),
      // overlayShape: const RoundSliderOverlayShape(overlayRadius: 16),
    ),
    listTileTheme: const ListTileThemeData(
      textColor: Colors.white,
    ),
    checkboxTheme: CheckboxThemeData(
      side: const BorderSide(
        color: Colors.white,
      ),
      checkColor: WidgetStateProperty.all(Colors.deepPurple[600]),
    ),
  );

  final ThemeData lightTheme = ThemeData.light().copyWith(
    colorScheme: ColorScheme.fromSwatch().copyWith(
      surface: const Color(0xFFffffff),
      secondary: const Color(0xFFefeff1),
      error: const Color(0xFFEC0808),
      surfaceContainerHigh: const Color(0xFFffffff),

      //buttons color
      tertiary: Colors.deepPurpleAccent[200],
      tertiaryContainer: Colors.grey[850],
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: textPrimaryLight),
      bodyMedium: TextStyle(color: textPrimaryLight),
      bodySmall: TextStyle(color: textPrimaryLight),
      titleLarge: TextStyle(color: textPrimaryLight),
      titleMedium: TextStyle(color: textPrimaryLight),
      titleSmall: TextStyle(color: textPrimaryLight),
      displayLarge: TextStyle(color: textPrimaryLight),
      displayMedium: TextStyle(color: textPrimaryLight),
      displaySmall: TextStyle(color: textPrimaryLight),
      headlineLarge: TextStyle(color: textPrimaryLight),
      headlineMedium: TextStyle(color: textPrimaryLight),
      headlineSmall: TextStyle(color: textPrimaryLight),
      labelLarge: TextStyle(color: textPrimaryLight),
      labelMedium: TextStyle(color: textPrimaryLight),
      labelSmall: TextStyle(color: textPrimaryLight),
    ),
    primaryIconTheme: const IconThemeData(color: Colors.black),
    inputDecorationTheme: InputDecorationTheme(
      border: const OutlineInputBorder(),
      helperStyle: const TextStyle(
        color: Color.fromARGB(255, 28, 25, 25),
      ),
      hintStyle: const TextStyle(
        color: Color.fromARGB(255, 75, 75, 75),
        fontSize: 16,
      ),
      labelStyle: TextStyle(
        color: Colors.deepPurpleAccent[200],
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey[600]!),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.deepPurpleAccent[200]!),
      ),
      iconColor: Colors.black,
      prefixIconColor: Colors.black,
    ),
    tabBarTheme: TabBarThemeData(
      labelColor: Colors.deepPurpleAccent[200],
      unselectedLabelColor: Colors.black,
      dividerColor: Colors.transparent,
      indicatorColor: Colors.deepPurpleAccent[200],
      labelPadding: const EdgeInsets.symmetric(horizontal: 30),
      indicatorSize: TabBarIndicatorSize.tab,
    ),
    appBarTheme: const AppBarTheme(
      titleTextStyle: TextStyle(
        color: Colors.black,
        fontSize: 18,
      ),
      iconTheme: IconThemeData(
        color: Colors.black,
      ),
      backgroundColor: Color(0xFFefeff1),
      surfaceTintColor: Colors.transparent,
      centerTitle: false,
    ),
    dividerTheme: const DividerThemeData(
      thickness: 2,
      indent: 0,
      endIndent: 0,
      color: Color(0xFFefeff1),
    ),
    textButtonTheme: const TextButtonThemeData(
      style: ButtonStyle(
        textStyle: WidgetStatePropertyAll(
          TextStyle(
            fontSize: 12,
          ),
        ),
        foregroundColor: WidgetStatePropertyAll(Colors.black),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        textStyle: const WidgetStatePropertyAll(
          TextStyle(
            fontSize: 12,
          ),
        ),
        foregroundColor: const WidgetStatePropertyAll(Colors.white),
        backgroundColor: WidgetStatePropertyAll(Colors.deepPurpleAccent[200]),
      ),
    ),
    chipTheme: ChipThemeData(
      deleteIconColor: Colors.black,
      labelStyle: const TextStyle(
        color: Colors.black,
      ),
      side: const BorderSide(),
      disabledColor: const Color(0xFF18181b),
      selectedColor: Colors.deepPurpleAccent[200],
      iconTheme: const IconThemeData(color: Colors.white),
    ),
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith(
        (Set<WidgetState> states) {
          if (states.contains(WidgetState.selected)) {
            return Colors.white;
          }
          if (states.contains(WidgetState.disabled)) {
            return null;
          }
          return Colors.white;
        },
      ),
      trackColor: WidgetStateProperty.resolveWith(
        (Set<WidgetState> states) {
          if (states.contains(WidgetState.selected)) {
            return Colors.deepPurpleAccent[200];
          }
          if (states.contains(WidgetState.disabled)) {
            return Colors.grey[850];
          }
          return Colors.grey[850];
        },
      ),
    ),
    sliderTheme: SliderThemeData(
      activeTrackColor: Colors.deepPurpleAccent[200],
      inactiveTrackColor: Colors.grey[850],
      thumbColor: Colors.deepPurpleAccent[400],
      // overlayColor: Colors.deepPurpleAccent[200],
      // trackHeight: 2,
      // thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 8),
      // overlayShape: const RoundSliderOverlayShape(overlayRadius: 16),
    ),
    listTileTheme: const ListTileThemeData(
      textColor: Colors.black,
    ),
    checkboxTheme: CheckboxThemeData(
      side: const BorderSide(),
      checkColor: WidgetStateProperty.all(Colors.deepPurple[600]),
    ),
  );
}
