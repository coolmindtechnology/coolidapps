import 'package:coolappflutter/data/provider/provider_affiliate.dart';
import 'package:coolappflutter/data/response/affiliate/res_home_affiliate.dart';
import 'package:coolappflutter/data/response/affiliate/res_list_bank.dart';
import 'package:coolappflutter/presentation/utils/circular_progress_widget.dart';
import 'package:coolappflutter/presentation/utils/notification_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:provider/provider.dart';
import '../../../generated/l10n.dart';
import '../../theme/color_utils.dart';
import 'components/drowpdown.dart';

class ScreenInputRekening extends StatefulWidget {
  final Function? onUpdate;
  final DataAffiliasi? dataBank;
  const ScreenInputRekening({super.key, this.dataBank, this.onUpdate});

  @override
  State<ScreenInputRekening> createState() => _ScreenInputRekeningState();
}

class _ScreenInputRekeningState extends State<ScreenInputRekening> {
  final keyForm = GlobalKey<FormState>();
  String? _selectedValue;
  final TextEditingController _typeAheadController = TextEditingController();
  String? selectedValue;

  @override
  void initState() {
    debugPrint("tes cek vacum");
    Future.microtask(() {
      if (widget.dataBank != null) {
        context.read<ProviderAffiliate>().noRek =
            TextEditingController(text: widget.dataBank?.bankNumber);
        context.read<ProviderAffiliate>().nameBank =
            TextEditingController(text: widget.dataBank?.bankName);
        context.read<ProviderAffiliate>().getListRekening(context);
      } else {
        context.read<ProviderAffiliate>().getListRekening(context);
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProviderAffiliate>(context);
    return Consumer<ProviderAffiliate>(
      builder: (BuildContext context, value, Widget? child) => Scaffold(
        appBar: AppBar(
          // automaticallyImplyLeading: false,
          title: Text(
            S.of(context).bank_account,
            style: TextStyle(color: whiteColor),
          ),
          backgroundColor: primaryColor,
        ),
        body: Form(
          key: keyForm,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  S.of(context).bank_account,
                  style: const TextStyle(fontSize: 14),
                ),
                const SizedBox(
                  height: 8,
                ),
                // DropdownWithSearch(
                //   listRek: value.listRek.map((e) {
                //     return DropdownMenuItem(
                //       value: e.code,
                //       child: Text(
                //         e.name ?? "",
                //       ),
                //     );
                //   }).toList(), // Ganti dengan daftar item Anda
                //   selectedValue: _selectedValue,
                //   onChanged: (val) {
                //     setState(() {
                //       _selectedValue = val;
                //     });
                //   },
                // ),
                TypeAheadField(
                  controller:
                      _typeAheadController, // your custom controller, or null
                  builder: (context, controller, focusNode) {
                    return TextField(
                      controller:
                          controller, // note how the controller is passed
                      focusNode: focusNode,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                      ),
                    );
                  },
                  suggestionsCallback: (pattern) {
                    // Filter daftar rekening berdasarkan input pengguna
                    return provider.listRek
                        .where((item) => item.name!
                            .toLowerCase()
                            .contains(pattern.toLowerCase()))
                        .toList();
                  },
                  itemBuilder: (context, suggestion) {
                    return ListTile(
                      title: Text(suggestion.name ?? ""),
                    );
                  },
                  onSelected: (suggestion) {
                    setState(() {
                      _typeAheadController.text = suggestion.name ?? "";
                      _selectedValue = suggestion.code;
                    });
                  },
                ),
                // TypeAheadFormField<DataRek>(
                //   textFieldConfiguration: TextFieldConfiguration(
                //     controller: _typeAheadController,
                //     decoration: InputDecoration(
                //       labelText: S.of(context).select_bank_account,
                //       border: OutlineInputBorder(
                //         borderRadius: BorderRadius.circular(10),
                //       ),
                //       fillColor: Colors.grey.withOpacity(0.2),
                //       filled: true,
                //     ),
                //   ),
                //   suggestionsCallback: (pattern) {
                //     // Filter daftar rekening berdasarkan input pengguna
                //     return provider.listRek
                //         .where((item) => item.name!
                //             .toLowerCase()
                //             .contains(pattern.toLowerCase()))
                //         .toList();
                //   },
                //   itemBuilder: (context, suggestion) {
                //     return ListTile(
                //       title: Text(suggestion.name ?? ""),
                //     );
                //   },
                //   noItemsFoundBuilder: (context) => const Padding(
                //     padding: EdgeInsets.all(8.0),
                //     child: Text(
                //       'No Bank Accounts Found',
                //       style: TextStyle(color: Colors.grey),
                //     ),
                //   ),
                //   onSuggestionSelected: (suggestion) {
                //     setState(() {
                //       _typeAheadController.text = suggestion.name ?? "";
                //       _selectedValue = suggestion.code;
                //     });
                //   },
                //   validator: (value) =>
                //       value!.isEmpty ? S.of(context).select_bank_account : null,
                // ),
                const SizedBox(height: 16),
                if (provider.isListRek && provider.listRek.isEmpty)
                  const Text('No bank accounts available.'),
                if (provider.isListRek && provider.listRek.isNotEmpty)
                  Text('Selected Value: $_selectedValue'),
                if (provider.isListRek)
                  const CircularProgressIndicator(), // Tampilkan loading jika sedang memuat data
                // DropdownButtonFormField(
                //   value: _selectedValue,
                //   hint: Text(S.of(context).select_bank_account),
                //   isExpanded: true,
                //   items: value.listRek.map((e) {
                //     return DropdownMenuItem(
                //       value: e.code,
                //       child: Text(
                //         e.name ?? "",
                //       ),
                //     );
                //   }).toList(),
                //   validator: (value) =>
                //       value == null ? S.of(context).select_bank : null,
                //   onChanged: (val) {
                //     setState(() {
                //       _selectedValue = val;
                //     });
                //   },
                //   decoration: InputDecoration(
                //     labelText: S.of(context).select_source,
                //     border: OutlineInputBorder(
                //         borderSide: BorderSide(width: 1, color: whiteColor),
                //         borderRadius: BorderRadius.circular(
                //             10) // Set the border color here
                //         ),
                //     focusedBorder: OutlineInputBorder(
                //       borderRadius: BorderRadius.circular(10.0),
                //       borderSide: const BorderSide(),
                //     ),
                //     enabledBorder: OutlineInputBorder(
                //       borderRadius: BorderRadius.circular(10.0),
                //       borderSide: const BorderSide(
                //         width: 1.0,
                //       ),
                //     ),
                //     fillColor: Colors.grey.withOpacity(0.2),
                //     floatingLabelBehavior: FloatingLabelBehavior.never,
                //   ),
                // ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  S.of(context).account_number,
                  style: const TextStyle(fontSize: 14),
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  controller: value.noRek,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
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
                const SizedBox(
                  height: 25,
                ),
                value.isAccountBank
                    ? const CircularProgressWidget()
                    : MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        color: primaryColor,
                        textColor: whiteColor,
                        height: 54,
                        minWidth: MediaQuery.of(context).size.width,
                        onPressed: () async {
                          if (keyForm.currentState?.validate() == true) {
                            await value.getDataAccountBank(
                                context,
                                _selectedValue ?? "",
                                value.noRek?.text ?? "", onUpdate: () {
                              widget.onUpdate!();
                            });
                          }
                        },
                        child: Text(S.of(context).check_account),
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
