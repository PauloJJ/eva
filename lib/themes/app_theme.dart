import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// The [AppTheme] defines light and dark themes for the app.
///
/// Theme setup for FlexColorScheme package v8.
/// Use same major flex_color_scheme package version. If you use a
/// lower minor version, some properties may not be supported.
/// In that case, remove them after copying this theme to your
/// app or upgrade the package to version 8.3.1.
///
/// Use it in a [MaterialApp] like this:
///
/// MaterialApp(
///   theme: AppTheme.light,
///   darkTheme: AppTheme.dark,
/// );
abstract final class AppTheme {
  // The FlexColorScheme defined light mode ThemeData.
  static ThemeData light = FlexThemeData.light(
    // User defined custom colors made with FlexSchemeColor() API.
    colors: const FlexSchemeColor(
      primary: Color(0xFFB07CCE),
      primaryContainer: Color(0xFFA57EBC),
      secondary: Color(0xFFFAF5FF),
      secondaryContainer: Color(0xFFB07CCE),
      tertiary: Color(0xFFC0A7CF),
      tertiaryContainer: Color(0xFFC0A7CF),
      appBarColor: Color(0xFFB07CCE),
      error: Color(0xFFBA1A1A),
      errorContainer: Color(0xFFFFDAD6),
    ),
    // Component theme configurations for light mode.
    subThemesData: const FlexSubThemesData(
      cardElevation: 0,
      interactionEffects: true,
      tintedDisabledControls: true,
      useM2StyleDividerInM3: true,
      defaultRadius: 10.0,
      inputDecoratorContentPadding: EdgeInsetsDirectional.fromSTEB(
        12,
        16,
        12,
        12,
      ),
      inputDecoratorBackgroundAlpha: 7,
      inputDecoratorBorderSchemeColor: SchemeColor.primary,
      inputDecoratorBorderType: FlexInputBorderType.outline,
      inputDecoratorRadius: 8.0,
      inputDecoratorUnfocusedBorderIsColored: true,
      inputDecoratorBorderWidth: 1.0,
      inputDecoratorFocusedBorderWidth: 2.0,
      inputDecoratorPrefixIconSchemeColor: SchemeColor.primaryContainer,
      inputDecoratorSuffixIconSchemeColor: SchemeColor.primary,
      alignedDropdown: true,
      snackBarBackgroundSchemeColor: SchemeColor.primaryContainer,
      bottomAppBarSchemeColor: SchemeColor.onSecondaryContainer,
      tabBarIndicatorAnimation: TabIndicatorAnimation.elastic,
      bottomSheetBackgroundColor: SchemeColor.transparent,
      bottomSheetModalBackgroundColor: SchemeColor.transparent,
      bottomSheetElevation: 0.0,
      bottomSheetModalElevation: 0.0,
      searchBarBackgroundSchemeColor: SchemeColor.secondary,
      searchViewBackgroundSchemeColor: SchemeColor.secondary,
      searchBarElevation: 0.0,
      searchViewElevation: 0.0,
      searchBarRadius: 15.0,
      searchViewRadius: 15.0,
      navigationRailUseIndicator: true,
    ),
    // Direct ThemeData properties.
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
    cupertinoOverrideTheme: const CupertinoThemeData(applyThemeToAll: true),
    fontFamily: GoogleFonts.poppins().fontFamily,
  );

  // The FlexColorScheme defined dark mode ThemeData.
  static ThemeData dark = FlexThemeData.dark(
    // User defined custom colors made with FlexSchemeColor() API.
    colors: const FlexSchemeColor(
      primary: Color(0xFFFF0971),
      primaryContainer: Color(0xFFFF0971),
      primaryLightRef: Color(0xFFB07CCE), // The color of light mode primary
      secondary: Color(0xFFFFCEED),
      secondaryContainer: Color(0xFFFF4191),
      secondaryLightRef: Color(0xFFFAF5FF), // The color of light mode secondary
      tertiary: Color(0xFFE792FF),
      tertiaryContainer: Color(0xFFFFF8F8),
      tertiaryLightRef: Color(0xFFC0A7CF), // The color of light mode tertiary
      appBarColor: Color(0xFFB07CCE),
      error: Color(0xFFFFB4AB),
      errorContainer: Color(0xFF93000A),
    ),
    // Component theme configurations for dark mode.
    subThemesData: const FlexSubThemesData(
      interactionEffects: true,
      tintedDisabledControls: true,
      blendOnColors: true,
      useM2StyleDividerInM3: true,
      defaultRadius: 10.0,
      inputDecoratorSchemeColor: SchemeColor.primary,
      inputDecoratorContentPadding: EdgeInsetsDirectional.fromSTEB(
        12,
        16,
        12,
        12,
      ),
      inputDecoratorBackgroundAlpha: 40,
      inputDecoratorBorderSchemeColor: SchemeColor.primary,
      inputDecoratorBorderType: FlexInputBorderType.outline,
      inputDecoratorRadius: 8.0,
      inputDecoratorUnfocusedBorderIsColored: true,
      inputDecoratorBorderWidth: 1.0,
      inputDecoratorFocusedBorderWidth: 2.0,
      inputDecoratorPrefixIconSchemeColor: SchemeColor.primaryFixed,
      inputDecoratorSuffixIconSchemeColor: SchemeColor.primary,
      alignedDropdown: true,
      snackBarBackgroundSchemeColor: SchemeColor.primaryContainer,
      tabBarIndicatorAnimation: TabIndicatorAnimation.elastic,
      bottomSheetBackgroundColor: SchemeColor.transparent,
      bottomSheetModalBackgroundColor: SchemeColor.transparent,
      bottomSheetElevation: 0.0,
      bottomSheetModalElevation: 0.0,
      searchBarBackgroundSchemeColor: SchemeColor.secondary,
      searchViewBackgroundSchemeColor: SchemeColor.secondary,
      searchBarElevation: 0.0,
      searchViewElevation: 0.0,
      searchBarRadius: 15.0,
      searchViewRadius: 15.0,
      navigationRailUseIndicator: true,
    ),
    // Direct ThemeData properties.
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
    cupertinoOverrideTheme: const CupertinoThemeData(applyThemeToAll: true),
    textTheme: GoogleFonts.getTextTheme('Poppins'),
  );
}
