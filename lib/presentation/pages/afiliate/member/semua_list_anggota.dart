import 'package:coolappflutter/data/apps/app_sizes.dart';
import 'package:coolappflutter/generated/l10n.dart';
import 'package:coolappflutter/presentation/pages/afiliate/member/deetail_anggota.dart';
import 'package:coolappflutter/presentation/theme/color_utils.dart';
import 'package:coolappflutter/presentation/utils/nav_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:coolappflutter/data/provider/provider_affiliate.dart';
import 'package:intl/intl.dart';

class SemuaAnggotaPage extends StatefulWidget {
  @override
  _SemuaAnggotaPageState createState() => _SemuaAnggotaPageState();
}

class _SemuaAnggotaPageState extends State<SemuaAnggotaPage> {
  String _searchText = '';

  String formatTanggal(String dateString) {
    try {
      DateTime dateTime = DateTime.parse(dateString);
      return DateFormat('dd MMMM yyyy', 'id').format(dateTime);
    } catch (e) {
      return '-';
    }
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      final provider = Provider.of<ProviderAffiliate>(context, listen: false);
      provider.getListMember(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF4CCBF4),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          S.of(context).semua_anggota,
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: Consumer<ProviderAffiliate>(
        builder: (context, provider, child) {
          final listMember = provider.listMember?.data ?? [];

          // Filter berdasarkan searchText
          final filteredMembers = listMember.where((member) {
            return (member.name ?? '')
                .toLowerCase()
                .contains(_searchText.toLowerCase());
          }).toList();

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search bar
              Padding(
                padding: const EdgeInsets.all(16),
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      _searchText = value;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: S.of(context).Search,
                    prefixIcon:  Icon(Icons.search,color: primaryColor,),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),

              // Label
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  S.of(context).member,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
              const SizedBox(height: 8),

              // List anggota
              Expanded(
                child: filteredMembers.isEmpty
                    ? Center(child: Text(S.of(context).no_data))
                    : ListView.builder(
                  itemCount: filteredMembers.length,
                  itemBuilder: (context, index) {
                    final member = filteredMembers[index];
                    return ListTile(
                      onTap: () {
                        Nav.to(DetailAnggotaPage(idMember: member.id.toString(),));
                      },
                      leading: CircleAvatar(
                        radius: 25,
                        backgroundImage: NetworkImage(
                          member.image?.toString() ?? '',
                        ),
                      ),
                      title: Text(
                        member.name ?? '-',
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Text(S.of(context).jadi_anggota_pada),
                      ),
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            member.tipeOtak ?? '-',
                            style:  TextStyle(
                              fontSize: 16,
                              color: _getColorForType(member.tipeOtak ?? '-'),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            formatTanggal(member.createdAt.toString() ?? ''),
                            style: const TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
  Color _getColorForType(String type) {
    switch (type) {
      case 'Emotion In':
      case 'Emotion Out':
        return Colors.green;
      case 'Logic In':
      case 'Logic Out':
        return Colors.yellow;
      case 'Master':
        return Colors.black;
      case 'Creative In':
      case 'Creative Out':
        return Colors.orange;
      case 'Action In':
      case 'Action Out':
        return Colors.red;
      default:
        return Colors.grey; // Warna default jika type tidak cocok
    }
  }
}

