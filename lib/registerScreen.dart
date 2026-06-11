import 'package:cristal_webapp/params/schoolCodeRequest.dart';
import 'package:cristal_webapp/registrationCubit/register_cubit.dart';
import 'package:cristal_webapp/webviewScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'config/shared_preference_helper.dart';


class RegisterCodePage extends StatefulWidget {
  const RegisterCodePage({super.key});

  @override
  State<RegisterCodePage> createState() => _RegisterCodePageState();
}


class _RegisterCodePageState extends State<RegisterCodePage> {

  @override
  void initState() {
    checkLoginedStatus();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    final TextEditingController schoolCodeController = TextEditingController();
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Top Purple Section

            const SizedBox(height: 50),

            // Register Code Title
            const Text(
              "Register Code",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),

            const SizedBox(height: 20),

            // TextField
            BlocConsumer<RegisterCubit, RegisterState>(
              listener: (context, state) async {
                if (state is FetchSchoolLoading) {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (_) =>
                    const Center(child: CircularProgressIndicator()),
                  );
                }

                if (state is FetchSchoolSuccess) {
                  print('SuccessResult ${state.response.message}');
                  if(state.response.message=='School Not Found'){
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text('School Code not found..!')));
                  }
                  Navigator.pop(context); // close loader

                  // final school = state.response.schoolDetails?.first;
                  final pref = SharedPreferenceHelper();
                  // 👉 You can store baseUrl + dbName here if needed
                  await pref.saveSchoolRegistered(true); // 🔥 THIS IS IMPORTANT

                  print("Saved school registered TRUE"); // add this

                  /// 🔥 GET SCHOOL DATA
                  final school = state.response.schoolDetails?.first;

                  if (school != null) {
                    /// ✅ SAVE BASE URL


                    // School Code
                    await pref.setSchoolCode(
                      schoolCodeController.text.toString() ?? "",
                    );

                    /// ✅ SAVE DB NAME
                    await pref.setDatabaseName(school.dbName ?? '');

                    await pref.setAppStoreVersion(school.appStoreVersion!);
                    await pref.setPlayStoreVersion(school.playStoreVersion!);

                    print("BaseURL saved: ${school.baseUrl}");
                    print("DB Name saved: ${school.dbName}");
                    final url = school.baseUrl!;
                    final base = Uri.parse(url).origin;
                    print(base); // https://fsp.cristaledu.com
                    await pref.setBaseUrl(base ?? '');
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => WebViewPage(webString: base),
                      ),
                    );
                  }

                }

                if (state is FetchSchoolFailure) {
                  Navigator.pop(context); // close loader

                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text(state.message)));
                }

              },
              builder: (context, state) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: TextField(
                    controller: schoolCodeController,
                    textCapitalization: TextCapitalization.characters,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[A-Z0-9]')),
                      UpperCaseTextFormatter(),
                    ],
                    decoration: InputDecoration(
                      hintText: "Enter School Code",
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 16,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.grey.shade400),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.grey.shade400),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(
                          color: Color(0xFF8D84E8),
                          width: 1.5,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),

          //  const Spacer(),

            // Connect Button
            Padding(
              padding: const EdgeInsets.all(16),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF8D84E8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                    elevation: 0,
                  ),
                  onPressed: () {
                    final code = schoolCodeController.text.trim();

                    if (code.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Please enter school code"),
                        ),
                      );
                      return;
                    }

                    /// 🔥 CALL API
                    context.read<RegisterCubit>().fetchSchools(
                      FetchSchoolRequest(slno: code),
                    );
                  },
                  child: const Text(
                    "Connect",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
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

  Future<void> checkLoginedStatus() async {
    final baseUrl = await SharedPreferenceHelper().getBaseUrl();
    if(baseUrl!.isNotEmpty){
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => WebViewPage(webString: baseUrl),
        ),
      );
    }
  }
}
class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    return newValue.copyWith(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}