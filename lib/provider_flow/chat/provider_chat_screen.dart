import 'package:flutter/material.dart';
import 'package:direct_task_web/widgets/text_widget.dart';

const Color kBg = Color(0xFFF9F9FB);
const Color kPrimary = Color(0xFFFF8A65);
const Color kBlue = Color(0xFF4C4FA1);
const Color kGrey = Color(0xFF7A7A7A);
const Color kBorder = Color(0xFFEAEAEA);

class ProviderChatScreen extends StatelessWidget {
  const ProviderChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kBg,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      child: Center(
        child: SizedBox(
          width: 1200,
          height: 640, // ✅ FIXED HEIGHT (CRITICAL)
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// ================= LEFT CHAT LIST =================
              Container(
                width: 320,
                padding: const EdgeInsets.all(16),
                decoration: _card(),
                child: Column(
                  children: [
                    /// SEARCH
                    _searchBar(),
                    const SizedBox(height: 16),

                    /// CHAT LIST (SCROLLABLE)
                    Expanded(
                      child: ListView.builder(
                        itemCount: 10,
                        itemBuilder: (_, index) {
                          return _chatTile(active: index == 0);
                        },
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 24),

              /// ================= RIGHT CHAT WINDOW =================
              Expanded(
                child: Container(
                  decoration: _card(),
                  child: Column(
                    children: [
                      /// HEADER
                      _chatHeader(),

                      /// MESSAGES (SCROLLABLE)
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: ListView(
                            children: [
                              _incomingMsg(),
                              _incomingMsg(),
                              _outgoingMsg(),
                              _incomingMsg(),
                              _outgoingMsg(),
                            ],
                          ),
                        ),
                      ),

                      /// INPUT
                      _chatInput(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ===================== UI PARTS =====================

  BoxDecoration _card() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(18),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.04),
          blurRadius: 10,
        ),
      ],
    );
  }

  Widget _searchBar() {
    return Container(
      height: 44,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFF4F4F4),
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Row(
        children: [
          Icon(Icons.search, size: 18, color: kGrey),
          SizedBox(width: 8),
          TextWidget('Search', fontSize: 13, color: kGrey),
        ],
      ),
    );
  }

  Widget _chatHeader() {
    return Container(
      height: 64,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: const BoxDecoration(
        color: kBlue,
        borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
      ),
      child: Row(
        children: const [
          CircleAvatar(
            radius: 18,
            backgroundImage: AssetImage('assets/images/cleaner1.png'),
          ),
          SizedBox(width: 12),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextWidget(
                'William Jasson',
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
              TextWidget(
                'Online',
                fontSize: 11,
                color: Colors.white70,
              ),
            ],
          ),
          Spacer(),
          Icon(Icons.more_vert, color: Colors.white),
        ],
      ),
    );
  }

  Widget _chatInput() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: kBorder)),
      ),
      child: Row(
        children: [
          const Icon(Icons.attach_file, color: kGrey),
          const SizedBox(width: 12),
          Expanded(
            child: Container(
              height: 44,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: const Color(0xFFF4F4F4),
                borderRadius: BorderRadius.circular(12),
              ),
              alignment: Alignment.centerLeft,
              child: const TextWidget(
                'Type a message...',
                fontSize: 13,
                color: kGrey,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Container(
            height: 44,
            width: 44,
            decoration: const BoxDecoration(
              color: kPrimary,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.send, color: Colors.white, size: 18),
          ),
        ],
      ),
    );
  }

  // ===================== CHAT ITEMS =====================

  Widget _chatTile({bool active = false}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: active ? kPrimary.withOpacity(0.08) : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: const [
          CircleAvatar(
            radius: 20,
            backgroundImage: AssetImage('assets/images/cleaner1.png'),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextWidget(
                  'Hassan Raheem',
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
                SizedBox(height: 2),
                TextWidget(
                  'Lorem ipsum has been...',
                  fontSize: 11,
                  color: kGrey,
                  maxLines: 1,
                ),
              ],
            ),
          ),
          TextWidget(
            '12:00 AM',
            fontSize: 10,
            color: kGrey,
          ),
        ],
      ),
    );
  }

  Widget _incomingMsg() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color(0xFFF4F4F4),
          borderRadius: BorderRadius.circular(12),
        ),
        child: const TextWidget(
          'Lorem Ipsum is simply dummy text of the printing industry.',
          fontSize: 12,
          color: kGrey,
        ),
      ),
    );
  }

  Widget _outgoingMsg() {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: kPrimary.withOpacity(0.15),
          borderRadius: BorderRadius.circular(12),
        ),
        child: const TextWidget(
          'Lorem Ipsum is simply dummy text of the printing industry.',
          fontSize: 12,
          color: kGrey,
        ),
      ),
    );
  }
}