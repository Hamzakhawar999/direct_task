import 'package:flutter/material.dart';
import 'package:direct_task_web/widgets/text_widget.dart';
import 'package:direct_task_web/widgets/footer_section.dart';

class RequestScreen extends StatelessWidget {
  const RequestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final bool isDesktop = width >= 1200;
    final bool isTablet = width >= 768 && width < 1200;
    final bool isMobile = width < 768;

    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            color: const Color(0xFFF9F9FB),
            padding: EdgeInsets.symmetric(
              horizontal: isDesktop ? 48 : 16,
              vertical: 32,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// ================= LEFT FILTERS =================
                if (!isMobile)
                  const SizedBox(
                    width: 260,
                    child: ServiceFilters(),
                  ),

                if (!isMobile) const SizedBox(width: 32),

                /// ================= RIGHT CONTENT =================
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// SEARCH + SORT + FILTER (MOBILE)
                      Row(
                        children: [
                          const Expanded(child: _SearchBox()),
                          const SizedBox(width: 12),
                          _SortDropdown(),
                          if (isMobile) ...[
                            const SizedBox(width: 12),
                            _MobileFilterButton(),
                          ],
                        ],
                      ),

                      const SizedBox(height: 24),

                      /// ================= GRID =================
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: 20,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: _gridCount(width),
                          crossAxisSpacing: 24,
                          mainAxisSpacing: 24,
                          childAspectRatio: _gridAspectRatio(width),
                        ),
                        itemBuilder: (_, __) => const RequestCardItem(),
                      ),

                      const SizedBox(height: 32),
                      const Center(child: _SeeMoreButton()),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const FooterSection(),
        ],
      ),
    );
  }

  int _gridCount(double width) {
    if (width >= 1200) return 2;
    if (width >= 768) return 2;
    return 1;
  }

  double _gridAspectRatio(double width) {
    if (width >= 1200) return 4.3;
    if (width >= 768) return 3.4;
    return 2.8;
  }
}

/// ================= MOBILE FILTER BUTTON =================
class _MobileFilterButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _openSheet(context),
      child: Container(
        height: 44,
        width: 44,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Icon(Icons.tune),
      ),
    );
  }

  void _openSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Color(0xFFF9F9FB),
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: SafeArea(
          top: false,
          child: SingleChildScrollView(
            child: Column(
              children: const [
                ServiceFilters(),
                SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// ================= SEARCH =================
class _SearchBox extends StatelessWidget {
  const _SearchBox();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Row(
        children: [
          Icon(Icons.search, size: 18, color: Colors.grey),
          SizedBox(width: 10),
          TextWidget(
            'Search for anything...',
            fontSize: 14,
            color: Color(0xFF9E9E9E),
          ),
        ],
      ),
    );
  }
}

/// ================= SORT =================
class _SortDropdown extends StatefulWidget {
  @override
  State<_SortDropdown> createState() => _SortDropdownState();
}

class _SortDropdownState extends State<_SortDropdown> {
  String value = 'Top Rated';

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          items: const [
            DropdownMenuItem(value: 'Top Rated', child: Text('Top Rated')),
            DropdownMenuItem(value: 'Lowest Budget', child: Text('Lowest Budget')),
            DropdownMenuItem(value: 'Highest Budget', child: Text('Highest Budget')),
          ],
          onChanged: (v) => setState(() => value = v!),
        ),
      ),
    );
  }
}

/// ================= REQUEST CARD =================
class RequestCardItem extends StatelessWidget {
  const RequestCardItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.035),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextWidget(
            'Need plumber for service',
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
          SizedBox(height: 4),
          TextWidget(
            'Posted 1 hour ago',
            fontSize: 11,
            color: Color(0xFFF48C5A),
          ),
          SizedBox(height: 6),
          TextWidget(
            'Lorem Ipsum is simply dummy text of the printing industry.',
            fontSize: 12,
            height: 1.25,
            color: Color(0xFF9E9E9E),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

/// ================= SEE MORE =================
class _SeeMoreButton extends StatelessWidget {
  const _SeeMoreButton();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      padding: const EdgeInsets.symmetric(horizontal: 26),
      decoration: BoxDecoration(
        color: const Color(0xFFF48C5A),
        borderRadius: BorderRadius.circular(22),
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextWidget(
            'See More',
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
          SizedBox(width: 10),
          Icon(Icons.arrow_forward, size: 16, color: Colors.white),
        ],
      ),
    );
  }
}

/// ================= FILTERS (SERVICE DROPDOWN RESTORED) =================
class ServiceFilters extends StatefulWidget {
  const ServiceFilters({super.key});

  @override
  State<ServiceFilters> createState() => _ServiceFiltersState();
}

class _ServiceFiltersState extends State<ServiceFilters> {
  bool servicesOpen = true;
  bool ratingOpen = true;
  RangeValues priceRange = const RangeValues(10, 80);
  int selectedRating = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const LocationSelector(),
        const SizedBox(height: 12),

        /// SERVICES DROPDOWN ✅ RESTORED
        _FilterCard(
          title: 'Services',
          isOpen: servicesOpen,
          onToggle: () => setState(() => servicesOpen = !servicesOpen),
          child: Column(
            children: [
              _CheckItem('Plumber'),
              _CheckItem('Electrician'),
              _CheckItem('Cleaner'),
              _CheckItem('Painter'),
            ],
          ),
        ),

        const SizedBox(height: 16),

        /// PRICE RANGE
        _StaticFilterCard(
          title: 'Price range',
          child: RangeSlider(
            values: priceRange,
            min: 0,
            max: 100,
            divisions: 10,
            activeColor: const Color(0xFFF48C5A),
            onChanged: (v) => setState(() => priceRange = v),
          ),
        ),

        const SizedBox(height: 16),

        /// RATING
        _FilterCard(
          title: 'Rating',
          isOpen: ratingOpen,
          onToggle: () => setState(() => ratingOpen = !ratingOpen),
          child: Column(
            children: List.generate(
              5,
              (i) => _RatingItem(
                stars: 5 - i,
                selected: selectedRating == 5 - i,
                onTap: () => setState(() => selectedRating = 5 - i),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/// ================= FILTER UI =================
class _FilterCard extends StatelessWidget {
  final String title;
  final bool isOpen;
  final VoidCallback onToggle;
  final Widget child;

  const _FilterCard({
    required this.title,
    required this.isOpen,
    required this.onToggle,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          InkWell(
            onTap: onToggle,
            child: Row(
              children: [
                TextWidget(title, fontSize: 14, fontWeight: FontWeight.w600),
                const Spacer(),
                Icon(isOpen
                    ? Icons.keyboard_arrow_up
                    : Icons.keyboard_arrow_down),
              ],
            ),
          ),
          if (isOpen) ...[
            const SizedBox(height: 12),
            child,
          ],
        ],
      ),
    );
  }
}

class _StaticFilterCard extends StatelessWidget {
  final String title;
  final Widget child;

  const _StaticFilterCard({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextWidget(title, fontSize: 14, fontWeight: FontWeight.w600),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }
}

class _CheckItem extends StatelessWidget {
  final String title;

  const _CheckItem(this.title);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(value: false, onChanged: (_) {}),
        TextWidget(title, fontSize: 13),
      ],
    );
  }
}

class _RatingItem extends StatelessWidget {
  final int stars;
  final bool selected;
  final VoidCallback onTap;

  const _RatingItem({
    required this.stars,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Checkbox(value: selected, onChanged: (_) => onTap()),
          Row(
            children: List.generate(
              5,
              (i) => Icon(
                Icons.star,
                size: 14,
                color:
                    i < stars ? const Color(0xFFFFB703) : Colors.grey.shade300,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// ================= LOCATION =================
class LocationSelector extends StatelessWidget {
  const LocationSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF3EC),
        borderRadius: BorderRadius.circular(22),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextWidget(
            'New York, USA',
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: Color(0xFFF48C5A),
          ),
          Icon(Icons.location_on, size: 18, color: Color(0xFFF48C5A)),
        ],
      ),
    );
  }
}