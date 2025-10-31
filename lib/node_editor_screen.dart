import 'package:flutter/material.dart';
import 'node_model.dart'; // <-- 1. Import model của bạn

// 2. Chuyển từ StatelessWidget sang StatefulWidget
class NoteEditorScreen extends StatefulWidget {
  // 3. Thêm biến để nhận ghi chú (có thể null nếu là tạo mới)
  final Note? note;

  // 4. Cập nhật hàm tạo để nhận 'note'
  const NoteEditorScreen({super.key, this.note});

  @override
  State<NoteEditorScreen> createState() =>
      _NoteEditorScreenState();
}

class _NoteEditorScreenState
    extends State<NoteEditorScreen> {
  // 5. Khai báo các Controller để quản lý text
  late TextEditingController _titleController;
  late TextEditingController _contentController;

  @override
  void initState() {
    super.initState();
    // 6. Khởi tạo controller với dữ liệu
    //    - Nếu widget.note tồn tại (chỉnh sửa), lấy title/content của nó
    //    - Nếu null (tạo mới), dùng chuỗi rỗng ''
    _titleController = TextEditingController(
      text: widget.note?.title ?? '',
    );
    _contentController = TextEditingController(
      text: widget.note?.content ?? '',
    );
  }

  @override
  void dispose() {
    // 7. Hủy controller để tránh rò rỉ bộ nhớ
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // 8. Đặt tiêu đề động
        title: Text(
          widget.note == null
              ? 'Ghi chú mới'
              : 'Chỉnh sửa ghi chú',
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () {
              // TODO: Implement save functionality
              // Bạn có thể lấy text từ:
              // final title = _titleController.text;
              // final content = _contentController.text;
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
              controller:
                  _titleController, // <-- 9. Gán controller
              decoration: const InputDecoration(
                hintText: 'Tiêu đề',
                border: InputBorder
                    .none, // Bỏ đường viền
              ),
              style: const TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16.0),
            // Ô nhập nội dung
            Expanded(
              child: TextField(
                controller:
                    _contentController, // <-- 10. Gán controller
                decoration: const InputDecoration(
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
