import 'package:flutter/material.dart';

class ContactSellerScreen extends StatefulWidget {
  final String sellerName;
  final String propertyTitle;

  const ContactSellerScreen({
    Key? key,
    required this.sellerName,
    required this.propertyTitle,
  }) : super(key: key);

  @override
  State<ContactSellerScreen> createState() => _ContactSellerScreenState();
}

class _ContactSellerScreenState extends State<ContactSellerScreen> {
  final TextEditingController _messageController = TextEditingController();

  void _sendMessage() {
    if (_messageController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('يرجى كتابة رسالة قبل الإرسال.')),
      );
      return;
    }
    // ✅ هنا تكتب كود الارسال للبائع عبر API
    print('تم إرسال الرسالة: ${_messageController.text}');
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('تم إرسال الرسالة بنجاح!')),
    );
    _messageController.clear();
  }

  void _callSeller() {
    // ✅ هنا تكتب كود الاتصال بالبائع (url_launcher أو غيره).
    print('جارِ الاتصال بالبائع...');
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('جارِ الاتصال بالبائع...')),
    );
  }

  void _sendEmail() {
    // ✅ هنا تكتب كود فتح البريد الإلكتروني
    print('فتح البريد الإلكتروني...');
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('فتح البريد الإلكتروني...')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(" Contact Seller "),
          backgroundColor: Colors.green,
        ),
        body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
    child: Card(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    elevation: 3,
    child: Padding(
    padding: const EdgeInsets.all(16),
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    Text(
    " ${widget.propertyTitle}",
    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    ),
    const SizedBox(height: 12),
    const Text(
    "اكتب رسالة للبائع للاستفسار أو تحديد موعد لزيارة العقار.",
    style: TextStyle(fontSize: 16, color: Colors.black54),
    ),
    const SizedBox(height: 16),
    TextField(
    controller: _messageController,
    maxLines: 5,
    decoration: InputDecoration(
    labelText: "Enter Message",
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
    ),
    ),
    const SizedBox(height: 16),
    SizedBox(
    width: double.infinity,
    child: ElevatedButton.icon(
    icon: const Icon(Icons.send),
    label: const Text("Send Message"),
    onPressed: _sendMessage,
    style: ElevatedButton.styleFrom(
    padding: const EdgeInsets.symmetric(vertical: 14),
    backgroundColor: Colors.green,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
    ),
    ),
    const SizedBox(height: 24),
    const Text(
    "خيارات تواصل سريعة",
    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    ),
    const SizedBox(height: 12),
    Row(
    children: [Expanded(
      child: ElevatedButton.icon(
        icon: const Icon(Icons.call),
        label: const Text("Call the Seller"),
        onPressed: _callSeller,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 14),
          backgroundColor: Colors.teal,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    ),
      const SizedBox(width: 12),
      Expanded(
        child: ElevatedButton.icon(
          icon: const Icon(Icons.email),
          label: const Text("Send Emaill"),
          onPressed: _sendEmail,
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 14),
            backgroundColor: Colors.teal,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
      ),
    ],
    )
    ],
    ),
    ),
    ),
        ),
    );
  }
}