import 'package:flutter/foundation.dart';
import 'package:m_and_r_quiz_admin_panel/local_storage/session/sessionhelper.dart';
import 'package:m_and_r_quiz_admin_panel/service/api_worker.dart';

import '../../export/___app_file_exporter.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isPasswordShow = false;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    if (kDebugMode) {
      emailController.text = "nemikardani6867@gmail.com";
      passwordController.text = "Test@123";
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      context: context,
      myBody: MyScrollView(
        children: [_mainWidget(context)],
      ),
    );
  }

  Widget _mainWidget(BuildContext context) {
    if (context.isMobile) {
      return _mainView(context);
    } else {
      return _mainView(context);
    }
  }

  Widget _mainView(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          MyRegularText(
            label: "$welcomeStr $toStr $appNameStr",
            fontSize: NkFontSize.largeFont,
            fontWeight: NkGeneralSize.nkBoldFontWeight,
          ),
          nkLargeSizedBox,
          Center(
            child: MyCommnonContainer(
              isCardView: true,
              boxConstraints: BoxConstraints.tightFor(
                width: context.isMobile ? context.width : 12.dp,
              ),
              padding: nkRegularPadding,
              child: AutofillGroup(
                child: Column(
                  children: [
                    MyRegularText(
                      label: "$loginStr $accountStr",
                      fontSize: NkFontSize.headingFont,
                    ),
                    nkMediumSizedBox,
                    _filedText(
                        autofillHints: [AutofillHints.email],
                        label: emailStr,
                        controller: emailController,
                        validator: NkFormValidation.emailValidation),
                    nkExtraSmallSizedBox,
                    _filedText(
                        autofillHints: [AutofillHints.password],
                        obscureText: !isPasswordShow,
                        suffixIcon: NkBouncingWidget(
                            onPress: () {
                              setState(() {
                                isPasswordShow = !isPasswordShow;
                              });
                            },
                            child:
                                NkCommonFunction.passwordIcon(isPasswordShow)),
                        label: passwordStr,
                        controller: passwordController),
                    nkSmallSizedBox,
                    FittedBox(
                        child: MyThemeButton(
                            buttonText: loginStr,
                            isLoadingButton: true,
                            onPressed: () async {
                              if (formKey.currentState!.validate()) {
                                await login();
                              }
                            })),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> login() async {
    ApiWorker()
        .loginAdmin(
            email: emailController.text, password: passwordController.text)
        .then(
      (value) {
        nkDevLog("USER DATA CONVERTED : ${value?.toJson()}");
        if (value != null && value.data != null) {
          SessionHelper.instance.setLoginData(value.data!).then(
                (value) {},
              );
          AppRoutes.navigator.goNamed(AppRoutes.dashboardScreen);
        } else {
          NKToast.warning(title: ErrorStrings.noDataFound);
        }
      },
    );
  }

  Widget _filedText(
      {String label = "",
      required TextEditingController controller,
      Widget? suffixIcon,
      bool obscureText = false,
      Iterable<String>? autofillHints,
      String? Function(dynamic)? validator}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MyRegularText(label: label),
        MyFormField(
            isShowDefaultValidator: validator == null,
            suffixIcon: suffixIcon,
            autofillHints: autofillHints,
            obscureText: obscureText,
            maxLines: 1,
            isOutlineBorder: true,
            controller: controller,
            validator: validator,
            labelText: label),
      ].addSpaceEveryWidget(space: nkExtraSmallSizedBox),
    );
  }
}
