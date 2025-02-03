import 'package:coolappflutter/data/data_global.dart';
import 'package:coolappflutter/data/provider/provider_consultant.dart';
import 'package:coolappflutter/data/response/consultant/res_get_comissen.dart';
import 'package:coolappflutter/generated/l10n.dart';
import 'package:coolappflutter/presentation/pages/Konsultasi/Normal_User/non_konsultasi.dart';
import 'package:coolappflutter/presentation/theme/color_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HistoryKomisen extends StatefulWidget {
  const HistoryKomisen({super.key});

  @override
  State<HistoryKomisen> createState() => _HistoryKomisenState();
}

class _HistoryKomisenState extends State<HistoryKomisen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  DateTime? selectedDate;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<ConsultantProvider>(context, listen: false);
      provider.getCommissions(context);
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ConsultantProvider>(
      builder: (context, provider, _) {
        if (provider.isLoadingCommissions) {
          return Scaffold(body: Center(child: CircularProgressIndicator()));
        }
        final allData = provider.commissionData!.data!.result!;
        final consultationData =
        allData.where((result) => result.type == "curhat").toList();
        final curhatData =
        allData.where((result) => result.type == "consultation").toList();

        return DefaultTabController(
          length: 3,
          child: Scaffold(
            appBar: AppBar(
              title: Text(
                S.of(context).Commission_History,
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.only(bottom: 30, top: 30, right: 20, left: 20),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: primaryColor,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(S.of(context).Total_Commission,
                                  style: TextStyle(color: Colors.white)),
                              Text(
                                'Rp. ${provider.commissionData!.data!.totalComission.toString()}',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16),
                              )
                            ],
                          ),
                          Icon(Icons.wallet, color: Colors.blue, size: 35)
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  InkWell(
                    onTap: () {
                      _selectDate(context);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.calendar_month, size: 30),
                        SizedBox(width: 10),
                        Text(
                          selectedDate == null
                              ? S.of(context).Filter_By_Date
                              : DateFormat('yyyy-MM-dd').format(selectedDate!),
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  TabBar(
                    controller: _tabController,
                    tabs: [
                      Tab(
                        child: Text(
                          S.of(context).all,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                      Tab(
                        child: Text(
                          S.of(context).Curhat,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                      Tab(
                        child: Text(
                          S.of(context).Consultation,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        _buildDataList(allData),
                        _buildDataList(consultationData),
                        _buildDataList(curhatData),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildDataList(List<Result> data) {
    if (data.isEmpty) {
      return Center(child: NoneKonsul());
    }

    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        final result = data[index];
        return ListTile(
          title: Text(
            '+ ${result.amount ?? 'N/A'}',
            style: TextStyle(fontWeight: FontWeight.w600, color: Colors.green),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${result.date != null ? result.date.toString().split(' ')[0] : 'N/A'}'),
              Text('${result.time ?? 'N/A'}'),
            ],
          ),
          trailing: Column(
            children: [
              Text('${dataGlobal.dataConsultant?.name ?? 'N/A'}'),
              Text('${result.type ?? 'N/A'}'),
            ],
          ),
          onTap: () {
            // Aksi saat item di tap (optional)
          },
        );
      },
    );
  }
}
