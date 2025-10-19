// lib/note_editor_screen.dart
import 'package:flutter/material.dart';

class NoteEditorScreen extends StatelessWidget {
  const NoteEditorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ghi chú mới'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () {
              // TODO: Implement save functionality
              Navigator.pop(
                context,
              ); // Quay lại màn hình trước
            },
            tooltip: 'Lưu',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Ô nhập tiêu đề
            TextField(
              decoration: InputDecoration(
                hintText: 'Tiêu đề',
                border: InputBorder
                    .none, // Bỏ đường viền
              ),
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16.0),
            // Ô nhập nội dung
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Nội dung...',
                  border: InputBorder.none,
                ),
                maxLines:
                    null, // Cho phép nhập nhiều dòng không giới hạn
                keyboardType:
                    TextInputType.multiline,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
