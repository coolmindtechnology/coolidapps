import 'package:coolappflutter/data/apps/app_assets.dart';
import 'package:coolappflutter/data/provider/provider_consultant.dart';
import 'package:coolappflutter/generated/l10n.dart';
import 'package:coolappflutter/presentation/pages/konsultasi/konsultant/experience_form.dart';
import 'package:coolappflutter/presentation/pages/main/nav_home.dart';
import 'package:coolappflutter/presentation/theme/color_utils.dart';
import 'package:coolappflutter/presentation/utils/nav_utils.dart';
import 'package:coolappflutter/presentation/widgets/Container/Container_Promo.dart';
import 'package:coolappflutter/presentation/widgets/GlobalButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Pastikan untuk mengimpor provider


class ExperiencePage extends StatefulWidget {
  const ExperiencePage({super.key});

  @override
  State<ExperiencePage> createState() => _ExperiencePageState();
}

class _ExperiencePageState extends State<ExperiencePage> {
  // List untuk menyimpan semua widget ExperienceForm
  List<ExperienceForm> experienceForms = [ExperienceForm()]; // List mulai dengan satu form
  List<String> titles = [];
  List<String> descriptions = [];
  List<String> documents = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              Text(
                S.of(context).Related_Experience,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ),
              ),
              SizedBox(height: 30),
              Center(child: Image.asset(AppAsset.imgCoolMind)),
              SizedBox(height: 30),
              Text(
                S.of(context).Describe_Your_Experience,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ),
              ),
              SizedBox(height: 10),
              Text(
                S.of(context).Classes_Training,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
              ),
              SizedBox(height: 30),
              // Menampilkan semua ExperienceForm yang ada dalam list
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (int i = 0; i < experienceForms.length; i++)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10),
                        Text(
                          S.of(context).Experience + ' ${i + 1}', // Menampilkan Experience 1, 2, dll.
                          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                        ),
                        SizedBox(height: 10),
                        ExperienceForm(
                          initialTitle: titles.length > i ? titles[i] : '',
                          initialDescription: descriptions.length > i ? descriptions[i] : '',
                          initialFileName: documents.length > i ? documents[i] : '',
                          onDataChanged: (title, description, filePath) { // Ganti fileName dengan filePath
                            // Simpan data ke list
                            if (i < titles.length) {
                              titles[i] = title;
                              descriptions[i] = description;
                              documents[i] = filePath; // Pastikan ini diperbarui dengan path lengkap
                            } else {
                              titles.add(title);
                              descriptions.add(description);
                              documents.add(filePath); // Pastikan ini ditambahkan
                            }
                            print('Documents: $documents'); // Tambahkan log ini untuk debugging
                          },
                        ),// Menampilkan ExperienceForm yang sesuai
                      ],
                    ),
                ],
              ),
              SizedBox(height: 30),
              GlobalButton(
                onPressed: () {
                  setState(() {
                    // Menambahkan form baru ke list
                    experienceForms.add(ExperienceForm());
                  });
                },
                color: LightBlue,
                text: S.of(context).Add_Experience,
                textStyle: TextStyle(color: primaryColor),
              ),
              SizedBox(height: 10),
              GlobalButton(
                onPressed: () async {
                  // Mengambil provider
                  final provider = Provider.of<ConsultantProvider>(context, listen: false);
                  try {
                    // Log data yang akan dikirim
                    print('Title Experience: $titles');
                    print('Description Experience: $descriptions');
                    print('Documents: $documents');

                    // Mengirim data ke provider
                    await provider.registerConsultant(
                      titleExperience: titles,
                      descriptionExperience: descriptions,
                      documents: documents,
                    );

                    // Menampilkan dialog konfirmasi
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        Future.delayed(Duration(seconds: 3), () {
                          Nav.toAll(NavMenuScreen()); // Ganti ke rute tujuan
                        });

                        return Dialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: SizedBox(
                            height: 400,
                            child: ContainerPromo(
                              title: S.of(context).Awaiting_Confirmation,
                              imageUrl: AppAsset.icClock,
                              subtitle: S.of(context).Thank_You_For_Registering,
                              subtitle2: S.of(context).Back_to_Consultation,
                            ),
                          ),
                        );
                      },
                    );
                  } catch (e) {
                    print('Error: $e'); // Mencetak error ke konsol
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('An error occurred: $e')), // Menampilkan pesan error di SnackBar
                    );
                  }
                },
                color: primaryColor,
                text: S.of(context).next,
              ),
            ],
          ),
        ),
      ),
    );
  }
}