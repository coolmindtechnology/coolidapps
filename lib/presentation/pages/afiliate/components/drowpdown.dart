import 'package:coolappflutter/generated/l10n.dart';
import 'package:flutter/material.dart';

import '../../../../data/response/affiliate/res_home_affiliate.dart';

class DropdownWithSearch extends StatefulWidget {
  final List<DropdownMenuItem<String>>
      listRek; // Ganti 'Item' dengan tipe data sesuai Anda
  final String? selectedValue;
  final ValueChanged<String?> onChanged;

  const DropdownWithSearch({
    super.key,
    required this.listRek,
    this.selectedValue,
    required this.onChanged,
  });

  @override
  _DropdownWithSearchState createState() => _DropdownWithSearchState();
}

class _DropdownWithSearchState extends State<DropdownWithSearch> {
  late List<DropdownMenuItem<String>> _filteredItems;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _filteredItems = widget.listRek;
    _searchController.addListener(_filterItems);
  }

  void _filterItems() {
    setState(() {
      _filteredItems = widget.listRek.map((e) {
        return DropdownMenuItem(
          value: e.value,
          child: Text(
            e.value ?? "",
          ),
        );
      }).toList();
    });
  }

  // value.listRek.map((e) {
  //                   return DropdownMenuItem(
  //                     value: e.code,
  //                     child: Text(
  //                       e.name ?? "",
  //                     ),
  //                   );
  //                 }).toList(),

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // TextField untuk pencarian
        TextField(
          controller: _searchController,
          decoration: InputDecoration(
            labelText: S.of(context).select_bank,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        const SizedBox(height: 8),
        // DropdownButtonFormField untuk hasil pencarian
        DropdownButtonFormField<String>(
          value: widget.selectedValue,
          hint: Text(S.of(context).select_bank_account),
          isExpanded: true,
          items: _filteredItems.map((item) {
            return DropdownMenuItem(
              value: item.value,
              child: Text(item.value.toString()),
            );
          }).toList(),
          validator: (value) =>
              value == null ? S.of(context).select_bank : null,
          onChanged: widget.onChanged,
          decoration: InputDecoration(
            labelText: S.of(context).select_source,
            border: OutlineInputBorder(
              borderSide: const BorderSide(width: 1, color: Colors.white),
              borderRadius: BorderRadius.circular(10),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(
                width: 1.0,
              ),
            ),
            fillColor: Colors.grey.withOpacity(0.2),
            floatingLabelBehavior: FloatingLabelBehavior.never,
          ),
        ),
      ],
    );
  }
}
