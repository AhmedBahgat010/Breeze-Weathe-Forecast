import 'package:breeze_weather_forecast/utils/ext/ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_utils/get_utils.dart';
import '../../../../core/core.dart';
import '../../../../core/theme/theme_service.dart';
import '../../../../core/translations/app_language.dart';
import '../../../../settingsPage.dart';
import '../../../weather/presentation/pages/weather_page.dart';
import '../../auth.dart';
import '../widget/widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  /// Controller
  final _conEmail = TextEditingController();
  final _conPassword = TextEditingController();

  /// Focus Node
  final _fnEmail = FocusNode();
  final _fnPassword = FocusNode();

  /// Global key
  final _keyForm = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {    final themeCubit = context.read<ThemeCubit>();
    final languageCubit = context.read<LanguageCubit>();

    return Parent(
      backgroundAsset: Images.background,
      child: BlocListener<AuthCubit, AuthState>(
        listener: (_, state) {
          if (state is AuthStateLoading) {
            context.show();
          } else if (state is AuthStateSuccess) {
            context.dismiss();

            // context.go(Routes.home.path);

            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (_) => WeatherPage()),
                (route) => false);
          } else if (state is AuthStateFailed) {
            context.dismiss();
            state.error.toString().toToastError(context);
          }
        },
        child: Column(
          children: [
            
            Container(
              child: linkMenuDrawer("_language".tr, Icons.language, () {
                            languageAlert(context: context);
                          }, context),
            ),            ThemeToggle(themeCubit: themeCubit),
            Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(Dimens.space24),
                  child: AutofillGroup(
                    child: Form(
                      key: _keyForm,
                      child: CustomContaner(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            
                              
                            CircleAvatar(
                              backgroundColor: Palette.primaryWithOpacity,
                              foregroundColor: Palette.white,
                              child: const Icon(Icons.person),
                            ),
                            const HeaderText(
                              text: "Login to Existing User",
                            ),
                            TextF(
                              autofillHints: const [AutofillHints.email],
                              key: const Key("email"),
                              curFocusNode: _fnEmail,
                              nextFocusNode: _fnPassword,
                              textInputAction: TextInputAction.next,
                              controller: _conEmail,
                              keyboardType: TextInputType.emailAddress,
                              hintText: "username@domain.com",
                              hint: "Email",
                              validator: (String? value) => value != null
                                  ? (!value.isValidEmail()
                                      ? "Invalid email format"
                                      : null)
                                  : null,
                            ),
                            BlocBuilder<AuthCubit, AuthState>(
                              builder: (_, state) {
                                return TextF(
                                  autofillHints: const [AutofillHints.password],
                                  key: const Key("password"),
                                  curFocusNode: _fnPassword,
                                  textInputAction: TextInputAction.done,
                                  controller: _conPassword,
                                  keyboardType: TextInputType.text,
                                  obscureText: true,
                                  hintText: '••••••••••••',
                                  maxLine: 1,
                                  hint: "Password",
                                  validator: (String? value) => value != null
                                      ? (value.length < 8
                                          ? "Password must be at least 8 characters"
                                          : null)
                                      : null,
                                );
                              },
                            ),
            
                            //Remember login info
                            const SpacerV(),
            
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Checkbox(
                                      materialTapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                      visualDensity: const VisualDensity(
                                          horizontal: -4, vertical: -4),
                                      value: true,
                                      onChanged: (value) {},
                                    ),
                                    const SpacerH(),
                                    const Text(
                                      "Remember me",
                                      style: TextStyle(
                                        color: Colors.grey,
                                      ),
                                      //Strings.of(context)!.rememberMe,
                                    ),
                                  ],
                                ),
                                ButtonText(
                                  title: "Forgot Password?",
                                  onPressed: () {},
                                ),
                              ],
                            ),
            
                            SpacerV(value: Dimens.space16),
                            Button(
                              title: "Login",
                              onPressed: () {    Navigator.of(context).push(MaterialPageRoute(
                                  builder: (_) => WeatherPage()));
                                if (_keyForm.currentState?.validate() ?? false) {
                                  // context.read<AuthCubit>().login(
                                  //       LoginParams(
                                  //         email: _conEmail.text,
                                  //         password: _conPassword.text,
                                  //       ),
                                  //     );
            
                                }
                              },
                            ),
            
                            SpacerV(value: Dimens.space16),
            
                            Wrap(
                              children: [
                                const Text(
                                  "Don't have an account",
                                  style: TextStyle(color: Colors.grey),
                                ),
                                const SpacerH(),
                                ButtonText(
                                  title: "Create Account",
                                  onPressed: () {
                                    /// Direct to register page
            
                                    Navigator.of(context).push(MaterialPageRoute(
                                        builder: (_) => RegisterPage()));
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
void languageAlert({required BuildContext context}) {
  showDialog(
      context: context,
      builder: (BuildContext context) => SelectLanguageWidgetAlert());
}
}
