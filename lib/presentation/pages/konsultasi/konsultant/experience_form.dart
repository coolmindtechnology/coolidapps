import 'package:coolappflutter/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class ExperienceForm extends StatefulWidget {
  final String? initialTitle;
  final String? initialDescription;
  final String? initialFileName;
  final bool? isEdit; // Tambahkan parameter isEdit
  final Function(String title, String description, String fileName)? onDataChanged;

  const ExperienceForm({
    super.key,
    this.initialTitle,
    this.initialDescription,
    this.initialFileName,
    this.isEdit, // Terima parameter isEdit
    this.onDataChanged,
  });

  @override
  State<ExperienceForm> createState() => _ExperienceFormState();
}

class _ExperienceFormState extends State<ExperienceForm> {
  late String _title;
  late String _description;
  late String? _fileName;
  late bool _isEdit; // Variabel untuk menyimpan status edit

  @override
  void initState() {
    super.initState();
    _title = widget.initialTitle ?? '';
    _description = widget.initialDescription ?? '';
    _fileName = widget.initialFileName ?? '';
    _isEdit = widget.isEdit ?? true; // Jika isEdit null, set menjadi true
  }

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      setState(() {
        _fileName = result.files.single.name; // Ini hanya nama file
        String? filePath = result.files.single.path; // Ini path lengkap
        if (filePath != null) {
          widget.onDataChanged?.call(_title, _description, filePath); // Kirim path lengkap
          print('File picked: $_fileName at path: $filePath'); // Tambahkan log ini
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Memanggil onDataChanged setiap kali data berubah
    widget.onDataChanged?.call(_title, _description, _fileName ?? '');

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(S.of(context).Experience_Title,
              style: TextStyle(fontWeight: FontWeight.w400, color: Colors.grey, fontSize: 18)),
          TextField(
            controller: TextEditingController(text: _title),
            decoration: InputDecoration(
                hintText: S.of(context).Experience_Title,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.grey))),
            onChanged: _isEdit ? (value) {
              setState(() {
                _title = value;
                widget.onDataChanged?.call(_title, _description, _fileName ?? ''); // Kirim data ke parent
              });
            } : null, // Nonaktifkan perubahan jika tidak dalam mode edit
          ),
          SizedBox(height: 10),
          Text(S.of(context).Experience_Description,
              style: TextStyle(fontWeight: FontWeight.w400, color: Colors.grey, fontSize: 18)),
          TextField(
            controller: TextEditingController(text: _description),
            decoration: InputDecoration(
                hintText: S.of(context).Tell_Us_What_You_Gained,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.grey))),
            onChanged: _isEdit ? (value) {
              setState(() {
                _description = value;
                widget.onDataChanged?.call(_title, _description, _fileName ?? ''); // Kirim data ke parent
              });
            } : null, // Nonaktifkan perubahan jika tidak dalam mode edit
          ),
          SizedBox(height: 10),
          Text(S.of(context).Supporting_Documents,
              style: TextStyle(fontWeight: FontWeight.w400, color: Colors.grey, fontSize: 18)),
          GestureDetector(
            onTap: _isEdit ? _pickFile : null, // Nonaktifkan pick file jika tidak dalam mode edit
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey),
              ),
              child: _fileName == null
                  ? Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.attach_file, color: Colors.blue),
                  SizedBox(width: 8),
                  Text(S.of(context).Add_Supporting_Documents,
                      style: TextStyle(color: Colors.grey)),
                ],
              )
                  : Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.file_present, color: Colors.grey),
                  SizedBox(width: 8),
                  Text(_fileName!,overflow: TextOverflow.ellipsis, style: TextStyle(color: Colors.grey)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
