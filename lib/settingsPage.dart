import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:breeze_weather_forecast/core/theme/theme_service.dart';
import 'core/translations/app_language.dart';
import 'features/auth/auth.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeCubit = context.read<ThemeCubit>();
    final languageCubit = context.read<LanguageCubit>();
    
    return Scaffold(
      appBar: AppBar(
        title: Text('settingsTitle'.tr),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'chooseLanguage'.tr,
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            LanguageDropdown(languageCubit: languageCubit),
            const SizedBox(height: 20),
            Text(
              'selectTheme'.tr,
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            ThemeToggle(themeCubit: themeCubit),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                // Navigate to the main screen (e.g., LoginPage) after settings are selected
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginPage()),
                );
              },
              child: Text('continue'.tr),
            ),
          ],
        ),
      ),
    );
  }
}

class LanguageDropdown extends StatelessWidget {
  final LanguageCubit languageCubit;

  const LanguageDropdown({Key? key, required this.languageCubit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageCubit, String>(
      builder: (context, selectedLanguage) {
        return DropdownButton<String>(
          value: selectedLanguage,
          onChanged: (newLanguage) {
            if (newLanguage != null) {
              languageCubit.changeLanguage(newLanguage);
            }
          },
          items: const [
            DropdownMenuItem(value: 'en', child: Text('English')),
            DropdownMenuItem(value: 'ar', child: Text('Arabic')),
            DropdownMenuItem(value: 'fr', child: Text('French')),
          ],
        );
      },
    );
  }
}

class ThemeToggle extends StatelessWidget {
  final ThemeCubit themeCubit;

  const ThemeToggle({Key? key, required this.themeCubit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, themeMode) {
        return SwitchListTile(
          title: Text('darkMode'.tr ,style: TextStyle(color: Get.theme.canvasColor ),),
          value: themeMode == ThemeMode.dark,
          onChanged: (isDarkMode) {
            themeCubit.toggleTheme();
          },
        );
      },
    );
  }
}
class SelectLanguageWidgetAlert extends StatefulWidget {
  @override
  _SelectLanguageWidgetAlertState createState() =>
      _SelectLanguageWidgetAlertState();
}

class _SelectLanguageWidgetAlertState extends State<SelectLanguageWidgetAlert> {
  int selectedRadioTile = 0;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      _init();
    });
  }

  _init() {
    final languageCode = context.read<LanguageCubit>().state;
    if (languageCode == 'en') {
      setState(() {
        selectedRadioTile = 0;
      });
    } else if (languageCode == 'fr') {
      setState(() {
        selectedRadioTile = 1;
      });
    } else if (languageCode == 'ar') {
      setState(() {
        selectedRadioTile = 2;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageCubit, String>(
        builder: (context, languageCode) => AlertDialog(
              title: Text(
                "_language".tr,
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  RadioListTile(
                    value: 0,
                    groupValue: selectedRadioTile,
                    activeColor: Colors.red,
                    title: Text(
                      "English",
                    ),
                    onChanged: (val) {
                      setSelectedRadioTile(val!);
                    },
                  ),
                  RadioListTile(
                    value: 1,
                    groupValue: selectedRadioTile,
                    activeColor: Colors.red,
                    title: Text(
                      "French",
                    ),
                    onChanged: (val) {
                      setSelectedRadioTile(val!);
                    },
                  ),
                  RadioListTile(
                    value: 2,
                    groupValue: selectedRadioTile,
                    activeColor: Colors.red,
                    title: Text(
                      "العربية",
                    ),
                    onChanged: (val) {
                      setSelectedRadioTile(val!);
                    },
                  ),
                ],
              ),
             
               actions: [
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // if (widget.isHasCancel)
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(Icons.close),
                ),
              // if (widget.isSaveAppeared)
                IconButton(
                    icon: Icon(
                      Icons.done,
                      //color: Colors.white,
                    ),
                    onPressed:() {
                switch (selectedRadioTile) {
                  case 0:
                    context.read<LanguageCubit>().changeLanguage('en');
                    break;

                  case 1:
                    context.read<LanguageCubit>().changeLanguage('fr');
                    break;

                  case 2:
                    context.read<LanguageCubit>().changeLanguage('ar');
                    break;
                }

                Get.updateLocale(Locale(context.read<LanguageCubit>().state));
                Navigator.pop(context);
              },),
            ],
          ),
        ),
      ],
      
            ));
  }

  setSelectedRadioTile(int val) {
    setState(() {
      selectedRadioTile = val;
    });
  }
}
Widget linkMenuDrawer(
    String title, IconData icon, VoidCallback onPressed, BuildContext context) {
  return ListTile(
    title: Text(
      title,
      style: TextStyle(color: Get.theme.canvasColor ),
    ),
    leading: Icon(
      icon,color: Get.theme.canvasColor 
    ),
    onTap: onPressed,
  );
}