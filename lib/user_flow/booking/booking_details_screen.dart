import 'package:direct_task_web/user_flow/booking/checkout_screen.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:direct_task_web/widgets/text_widget.dart';
import 'package:direct_task_web/widgets/WebNavbar.dart';
import 'package:direct_task_web/widgets/footer_section.dart';

/// ================= FIGMA CONSTANTS =================
const Color kBg = Color(0xFFF9F9FB);
const Color kPrimary = Color(0xFFF48C5A);
const Color kBlue = Color(0xFF4C4FA1);
const Color kBorderGrey = Color(0xFFD1D1D1);
const Color kHintGrey = Color(0xFF9E9E9E);

const double kRadius = 14;
const double kFieldHeight = 52;

class BookingDetailsScreen extends StatelessWidget {
  const BookingDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final bool isDesktop = width >= 1200;

    return Scaffold(
      backgroundColor: kBg,
      body: Column(
        children: [
          /// ================= NAVBAR =================
          WebNavbar(
            showBack: true,
            currentIndex: -1,
            onTap: (_) {},
            onBack: () => Navigator.pop(context),
          ),

          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 40),

                  /// ================= MAIN CONTENT =================
                  Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 1200),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: isDesktop ? 24 : 16,
                        ),
                        child: isDesktop
                            ? const Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(child: CalendarCard()),
                                  SizedBox(width: 32),
                                  Expanded(child: BookingFormCard()),
                                ],
                              )
                            : const Column(
                                children: [
                                  CalendarCard(),
                                  SizedBox(height: 24),
                                  BookingFormCard(),
                                ],
                              ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 40),

                  /// ================= BOOK NOW =================
                  const BookNowButton(),

                  const SizedBox(height: 80),

                  /// ================= FOOTER =================
                  const FooterSection(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// ================= CALENDAR CARD =================
class CalendarCard extends StatefulWidget {
  const CalendarCard({super.key});

  @override
  State<CalendarCard> createState() => _CalendarCardState();
}

class _CalendarCardState extends State<CalendarCard> {
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final bool isDesktop = width >= 1200;
    final bool isTablet = width >= 768 && width < 1200;

    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TextWidget(
            'Booking Details',
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
          const SizedBox(height: 6),
          const TextWidget(
            'Select Date',
            fontSize: 13,
            color: kPrimary,
          ),
          const SizedBox(height: 18),

          /// ✅ RESPONSIVE HEIGHT (WEB UNCHANGED)
          SizedBox(
            height: isDesktop
                ? 380
                : isTablet
                    ? 360
                    : 320,
            child: TableCalendar(
              firstDay: DateTime.utc(2020),
              lastDay: DateTime.utc(2035),
              focusedDay: _focusedDay,
              selectedDayPredicate: (d) => isSameDay(_selectedDay, d),
              onDaySelected: (selected, focused) {
                setState(() {
                  _selectedDay = selected;
                  _focusedDay = focused;
                });
              },
              headerStyle: const HeaderStyle(
                formatButtonVisible: false,
                titleCentered: false,
                titleTextStyle: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              calendarStyle: CalendarStyle(
                isTodayHighlighted: false,
                selectedDecoration: const BoxDecoration(
                  color: kPrimary,
                  shape: BoxShape.circle,
                ),
                selectedTextStyle: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
                outsideTextStyle:
                    TextStyle(color: Colors.grey.shade400),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// ================= BOOKING FORM =================
class BookingFormCard extends StatefulWidget {
  const BookingFormCard({super.key});

  @override
  State<BookingFormCard> createState() => _BookingFormCardState();
}

class _BookingFormCardState extends State<BookingFormCard> {
  final timeFrom = TextEditingController();
  final timeTo = TextEditingController();
  final description = TextEditingController();
  final location = TextEditingController();

  Future<void> pickTime(TextEditingController controller) async {
    final t = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (t != null) {
      controller.text = t.format(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const InputLabel('Time From'),
          InputField(
            controller: timeFrom,
            onTap: () => pickTime(timeFrom),
            showClock: true,
          ),

          const SizedBox(height: 18),

          const InputLabel('Time To'),
          InputField(
            controller: timeTo,
            onTap: () => pickTime(timeTo),
            showClock: true,
          ),

          const SizedBox(height: 18),

          const InputLabel('Description'),
          InputField(
            controller: description,
            height: 120,
            maxLines: 4,
          ),

          const SizedBox(height: 18),

          const InputLabel('Location'),
          InputField(controller: location),

          const SizedBox(height: 24),

          const InputLabel('Payment'),
          const SizedBox(height: 8),
          const PaymentToggle(),
        ],
      ),
    );
  }
}

/// ================= INPUT LABEL =================
class InputLabel extends StatelessWidget {
  final String text;
  const InputLabel(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return TextWidget(
      text,
      fontSize: 13,
      fontWeight: FontWeight.w500,
    );
  }
}

/// ================= INPUT FIELD =================
class InputField extends StatelessWidget {
  final TextEditingController controller;
  final double height;
  final int maxLines;
  final bool showClock;
  final VoidCallback? onTap;

  const InputField({
    super.key,
    required this.controller,
    this.height = kFieldHeight,
    this.maxLines = 1,
    this.showClock = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      margin: const EdgeInsets.only(top: 6),
      padding: const EdgeInsets.symmetric(horizontal: 18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(kRadius),
        border: Border.all(color: kBorderGrey, width: 1.2),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              maxLines: maxLines,
              readOnly: onTap != null,
              onTap: onTap,
              decoration: const InputDecoration(
                hintText: 'Write here',
                isDense: true,
                hintStyle: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: kHintGrey,
                ),
                border: InputBorder.none,
              ),
            ),
          ),
          if (showClock)
            Image.asset(
              'assets/images/clock.png',
              width: 20,
              height: 20,
            ),
        ],
      ),
    );
  }
}

/// ================= PAYMENT TOGGLE =================
class PaymentToggle extends StatefulWidget {
  const PaymentToggle({super.key});

  @override
  State<PaymentToggle> createState() => _PaymentToggleState();
}

class _PaymentToggleState extends State<PaymentToggle> {
  bool isCash = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: const Color(0xFFF3F3F3),
        borderRadius: BorderRadius.circular(26),
        border: Border.all(color: kBorderGrey),
      ),
      child: Row(
        children: [
          Expanded(
            child: _ToggleItem(
              title: 'Through Cash',
              active: isCash,
              onTap: () => setState(() => isCash = true),
            ),
          ),
          Expanded(
            child: _ToggleItem(
              title: 'Online',
              active: !isCash,
              onTap: () => setState(() => isCash = false),
            ),
          ),
        ],
      ),
    );
  }
}

class _ToggleItem extends StatelessWidget {
  final String title;
  final bool active;
  final VoidCallback onTap;

  const _ToggleItem({
    required this.title,
    required this.active,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(22),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: active ? kBlue : Colors.transparent,
          borderRadius: BorderRadius.circular(22),
        ),
        alignment: Alignment.center,
        child: TextWidget(
          title,
          color: active ? Colors.white : Colors.grey,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

/// ================= BOOK NOW =================
class BookNowButton extends StatelessWidget {
  const BookNowButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const CheckoutScreen(),
          ),
        );
      },
      borderRadius: BorderRadius.circular(26),
      child: Container(
        height: 52,
        padding: const EdgeInsets.symmetric(horizontal: 40),
        decoration: BoxDecoration(
          color: kPrimary,
          borderRadius: BorderRadius.circular(26),
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextWidget(
              'Book Now',
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
            SizedBox(width: 12),
            Icon(Icons.arrow_forward, size: 18, color: Colors.white),
          ],
        ),
      ),
    );
  }
}