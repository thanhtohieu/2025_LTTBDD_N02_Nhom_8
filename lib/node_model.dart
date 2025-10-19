// lib/note_model.dart
class Note {
  final String title;
  final String content;
  final DateTime timestamp;

  Note({
    required this.title,
    required this.content,
    required this.timestamp,
  });
}

// Danh sách dữ liệu giả để hiển thị lên giao diện
final List<Note> fakeNotes = [
  Note(
    title: 'Họp nhóm Bài tập lớn',
    content:
        'Thảo luận về việc phân chia công việc cho project Lập trình di động. Cần hoàn thành UI trước cuối tuần này.',
    timestamp: DateTime.now(),
  ),
  Note(
    title: 'Danh sách mua sắm',
    content:
        '1. Trứng\n2. Sữa\n3. Bánh mì\n4. Rau củ',
    timestamp: DateTime.now().subtract(
      const Duration(days: 1),
    ),
  ),
  Note(
    title: 'Ý tưởng cho ứng dụng',
    content:
        'Thêm tính năng tìm kiếm ghi chú và sắp xếp theo ngày tạo.',
    timestamp: DateTime.now().subtract(
      const Duration(days: 2),
    ),
  ),
  Note(
    title: 'Mật khẩu Wi-Fi',
    content:
        'Ở nhà: MyHomeWifi123\nỞ trường: Phenikaa-Wifi-Free',
    timestamp: DateTime.now().subtract(
      const Duration(days: 4),
    ),
  ),
];
