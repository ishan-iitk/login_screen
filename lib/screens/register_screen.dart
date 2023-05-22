import "package:country_picker/country_picker.dart";
import "package:flutter/material.dart";
import "package:login_screen/provider/auth_provider.dart";
import "package:login_screen/widgets/custom_button.dart";
import "package:provider/provider.dart";

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController phoneController = TextEditingController();
  Country selectedCountry = Country(phoneCode: "91", countryCode: "IN",
      e164Sc: 0, geographic: true, level: 1, name: "India",
      example: "India", displayName: "India",
      displayNameNoCountryCode: "IN", e164Key: "");
  @override
  Widget build(BuildContext context) {
    phoneController.selection = TextSelection.fromPosition(
      TextPosition(offset: phoneController.text.length),
    );
    return Scaffold(
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: 25,
                horizontal: 35,
              ),
              child: Column(
                children: [
                  Container(
                    width: 200,
                    height: 200,
                    padding: EdgeInsets.all(30.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.purple.shade50,
                    ),
                    child: Image.asset('assets/2.png'),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Register",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Add your phone number to receive an OTP",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black38,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    cursorColor: Colors.purple,
                    controller: phoneController,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    onChanged: (value){
                      setState(() {
                        phoneController.text=value;
                      });
                    },
                    decoration: InputDecoration(
                      hintText: "Enter phone number",
                      hintStyle: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                        color: Colors.grey.shade600,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.black12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.black12),
                      ),
                      prefixIcon: Container(
                        padding: EdgeInsets.all(12.0),
                        child: InkWell(
                          onTap: () {
                            showCountryPicker(context: context,
                              countryListTheme: CountryListThemeData(
                                bottomSheetHeight: 500,
                              ),
                              onSelect: (value){
                                setState(() {
                                  selectedCountry=value;
                                });
                              },);
                          },

                          child: Text("${selectedCountry.flagEmoji} +${selectedCountry.phoneCode}" ,
                              style: TextStyle(fontSize: 18, color: Colors.black,
                                fontWeight: FontWeight.bold,
                              )
                          ),),
                      ),
                      suffixIcon: phoneController.text.length > 9 ? Container(
                          height: 30,
                          width: 30,
                            margin: EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.green,
                          ),
                          child: Icon(
                            Icons.done,
                            color: Colors.white,
                            size:20,
                          )) :  null,

                    ),
                  ),
                  SizedBox(height:20),
                  SizedBox(
                    width: double.infinity,
                    height:50,
                    child: CustomButton(text: "Login",
                        onPressed: ()=> sendPhoneNumber()),
                  ),

                ],
              ),
            ),
          ),
        ));
  }
void sendPhoneNumber()
{
  final ap = Provider.of<AuthProvider>(context, listen: false);
  String phoneNumber = phoneController.text.trim();
  ap.signInWithPhone(context, "+${selectedCountry.phoneCode}$phoneNumber");
}
  

}
