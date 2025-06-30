import 'package:coolappflutter/data/provider/provider_adress.dart';
import 'package:coolappflutter/data/provider/provider_user.dart';
import 'package:coolappflutter/generated/l10n.dart';
import 'package:coolappflutter/presentation/on_boarding/on_boarding_isi_ktp.dart';
import 'package:coolappflutter/presentation/on_boarding/onboarding_isi_email.dart';
import 'package:coolappflutter/presentation/theme/color_utils.dart';
import 'package:coolappflutter/presentation/utils/nav_utils.dart';
import 'package:coolappflutter/presentation/widgets/GlobalButton.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class IdentityPage extends StatefulWidget {
  @override
  State<IdentityPage> createState() => _IdentityPageState();
}

class _IdentityPageState extends State<IdentityPage> {
  final TextEditingController nameController = TextEditingController();
  String address = '';

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final providerUser = Provider.of<ProviderUser>(context, listen: false);
      providerUser.getUser(context);
      loadAddress();
    });
  }


  Future<void> loadAddress() async {
    final savedAddress = await AddressPreferences.getAddressString();
    setState(() {
      address = savedAddress ?? '';
    });
  }


  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Consumer<ProviderUser>(builder: (context, providerUser, child) {
      providerUser.addressController.text = address;

      return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [primaryColor, Colors.white], // Gradasi biru ke putih
              begin: Alignment.topCenter,
              end: Alignment.center,
            ),
          ),
          child: Center(
            child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset(
                          'images/identitas.png', // Ganti dengan path gambar kamu
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                     Text(
                      S.of(context).isiIdentitas,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                     Text(
                       S.of(context).isi_nama_lengkap,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 24),
                    TextFormField(
                      controller: providerUser.nameController,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderSide:
                            const BorderSide(color: Colors.white, width: 1),
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      validator: (validator) {
                        if (validator!.isEmpty) {
                          return S.of(context).cannot_be_empty;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 60),
                    providerUser.isLoadingUpdateUser ? Center(child: CircularProgressIndicator(color: primaryColor,)) : GlobalButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          // validasi berhasil, lanjut eksekusi
                          await providerUser.updateUser(context,'registrasi');
                        } else {
                          // validasi gagal, form menampilkan error
                        }

                      },
                      color: primaryColor,
                      text: S.of(context).next,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  });
  }
}
