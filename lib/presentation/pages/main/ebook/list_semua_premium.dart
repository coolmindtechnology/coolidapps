import 'package:coolappflutter/data/apps/app_sizes.dart';
import 'package:coolappflutter/data/provider/provider_book.dart';
import 'package:coolappflutter/data/response/res_list_ebook.dart';
import 'package:coolappflutter/generated/l10n.dart';
import 'package:coolappflutter/presentation/pages/main/ebook/detail_ebook.dart';
import 'package:coolappflutter/presentation/pages/main/ebook/favorite_saya.dart';
import 'package:coolappflutter/presentation/pages/main/ebook/list_semua_ebook.dart';
import 'package:coolappflutter/presentation/pages/main/ebook/notes.dart';
import 'package:coolappflutter/presentation/pages/main/ebook/ratings.dart';
import 'package:coolappflutter/presentation/pages/main/read_book.dart';
import 'package:coolappflutter/presentation/pages/user/Setting/Report/Report_Page.dart';
import 'package:coolappflutter/presentation/theme/color_utils.dart';
import 'package:coolappflutter/presentation/utils/nav_utils.dart';
import 'package:coolappflutter/presentation/utils/notification_utils.dart';
import 'package:coolappflutter/presentation/widgets/costum_floatingbutton.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListSemuaPremium extends StatefulWidget {
  const ListSemuaPremium({super.key});

  @override
  State<ListSemuaPremium> createState() => _ListSemuaPremiumState();
}

class _ListSemuaPremiumState extends State<ListSemuaPremium> {
  @override
  Widget build(BuildContext context) {
    ProviderBook provider = ProviderBook();
    return ChangeNotifierProvider(create: (BuildContext context) {
      return ProviderBook.initAllBook(context);
    }, child: Consumer<ProviderBook>(
        builder: (BuildContext context, value, Widget? child) {
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Image.asset("images/buku/arrowleft.png")),
              title:  Text(
                S.of(context).list_semua_buku_premium,
                style: TextStyle(color: Colors.white),
              ),
              centerTitle: false,
              actions: const [],
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 50,
                      width: double.infinity,
                      child: TextField(
                        controller: value.searchController,
                        onChanged: (text) {
                          value.updateSearchController(text);
                        },
                        decoration: InputDecoration(
                            prefixIcon: GestureDetector(
                              onTap: () {
                                value.updateSearchController("");
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(1.0),
                                child: Image.asset(
                                  "images/buku/search-buku.png",
                                  color: blueContainer,
                                  width: 10,
                                  height: 10,
                                ),
                              ),
                            ),
                            hintText: S.of(context).cari_judul_buku,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(Sizes.p10),
                              borderSide: const BorderSide(
                                color: Colors.grey,
                              ),
                            )),
                      ),
                    ),
                  ),
                  gapH16,
                  SizedBox(
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, // jumlah item per baris, sesuaikan dengan lebar layar
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        childAspectRatio: 100 / 200, // lebar : tinggi
                      ),
                      itemCount: value.displayPremium.length,
                      itemBuilder: (context, index) {
                        DataBook data = value.displayPremium[index];
                        return GestureDetector(
                          onTap: () {

                            NotificationUtils.showSimpleDialog2(
                                context,
                                "${S.of(context).pay_to_see_more}, ${S.of(context).just} Rp ${data.price ?? ""}",
                                textButton1:
                                S.of(context).yes_continue,
                                textButton2: S.of(context).no,
                                onPress2: () {
                                  Nav.back();
                                }, onPress1: () async {
                              Nav.back();
                              await provider
                                  .createLogEbook(
                                  context, data.id ?? 0)
                                  .then((_) {
                                provider.paymentEbook(
                                    context,
                                    data.id ?? 0,
                                    data.price ?? "",
                                    "Ebook - ${data.title}",
                                    onUpdate: () {});
                              });
                            },
                                colorButon1: primaryColor,
                                colorButton2: Colors.white);
                          },
                          child: Card(
                            color: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: SizedBox(
                                      height: 150,
                                      width: double.infinity,
                                      child: Image.network(
                                        "${data.imagePath ?? ""}",
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Spacer(),
                                  Padding(
                                    padding:
                                    const EdgeInsets.only(left: 5, right: 5),
                                    child: Center(
                                      child: Text(
                                        data.title.toString(),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600
                                        ),
                                      ),
                                    ),
                                  ),
                                  gapH10
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            floatingActionButton: const CustomFAB(),
          );
        }));
  }
}
