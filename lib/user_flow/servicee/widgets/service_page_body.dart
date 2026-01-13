import 'package:flutter/material.dart';
import 'package:direct_task_web/widgets/text_widget.dart';
import 'package:direct_task_web/user_flow/home/widgets/OurServiceProvidersSection.dart';

class ServicePageBody extends StatelessWidget {
  const ServicePageBody({super.key});

  void _openFilters(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFFF9F9FB),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => const SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: ServiceFilters(),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    final bool isDesktop = width >= 1200;
    final bool isTablet = width >= 768 && width < 1200;
    final bool isMobile = width < 768;

    final int gridCount = isDesktop
        ? 4
        : isTablet
            ? 2
            : 1;

    final double aspectRatio = isDesktop
        ? 0.80
        : isTablet
            ? 0.85
            : 1.05;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 48 : 16,
        vertical: 32,
      ),
      color: const Color(0xFFF9F9FB),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// ================= LEFT FILTERS (DESKTOP / TABLET) =================
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
                /// SEARCH + SORT + FILTER
                Row(
                  children: [
                    Expanded(child: _SearchBox()),
                    const SizedBox(width: 12),

                    if (isMobile)
                      InkWell(
                        onTap: () => _openFilters(context),
                        child: Container(
                          height: 44,
                          width: 44,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            Icons.filter_list,
                            color: Color(0xFFF48C5A),
                          ),
                        ),
                      )
                    else
                      _SortDropdown(),
                  ],
                ),

                const SizedBox(height: 24),

                /// PROVIDER GRID
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 12,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: gridCount,
                    crossAxisSpacing: 24,
                    mainAxisSpacing: 24,
                    childAspectRatio: aspectRatio,
                  ),
                  itemBuilder: (_, __) => const ProviderCardItem(),
                ),

                const SizedBox(height: 40),

                /// SEE MORE
                Align(
                  alignment: Alignment.center,
                  child: _SeeMoreButton(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// ================= SEARCH =================
class _SearchBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: const [
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
            DropdownMenuItem(value: 'Lowest Price', child: Text('Lowest Price')),
            DropdownMenuItem(value: 'Highest Price', child: Text('Highest Price')),
          ],
          onChanged: (v) => setState(() => value = v!),
        ),
      ),
    );
  }
}

/// ================= FILTERS =================
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

        _FilterCard(
          title: 'Services',
          isOpen: servicesOpen,
          onToggle: () => setState(() => servicesOpen = !servicesOpen),
          child: Column(
            children: const [
              _CheckItem('Service Name', active: true),
              _CheckItem('Service Name'),
              _CheckItem('Service Name'),
              _CheckItem('Service Name'),
            ],
          ),
        ),

        const SizedBox(height: 16),

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
                color: i < stars
                    ? const Color(0xFFFFB703)
                    : Colors.grey.shade300,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CheckItem extends StatelessWidget {
  final String title;
  final bool active;

  const _CheckItem(this.title, {this.active = false});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(value: active, onChanged: (_) {}),
        TextWidget(
          title,
          fontSize: 13,
          color: active ? const Color(0xFFF48C5A) : Colors.black,
        ),
      ],
    );
  }
}

/// ================= SEE MORE =================
class _SeeMoreButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      padding: const EdgeInsets.symmetric(horizontal: 26),
      decoration: BoxDecoration(
        color: const Color(0xFFF48C5A),
        borderRadius: BorderRadius.circular(22),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: const [
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

class LocationSelector extends StatelessWidget {
  const LocationSelector({super.key});

  void _openLocationPopup(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (_) => const LocationPopup(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _openLocationPopup(context),
      child: Container(
        height: 44,
        padding: const EdgeInsets.symmetric(horizontal: 14),
        decoration: BoxDecoration(
          color: const Color(0xFFFFF3EC),
          borderRadius: BorderRadius.circular(22),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            TextWidget(
              'New York, USA',
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: Color(0xFFF48C5A),
            ),
            Icon(
              Icons.location_on,
              size: 18,
              color: Color(0xFFF48C5A),
            ),
          ],
        ),
      ),
    );
  }
}

/// ================= LOCATION POPUP =================
class LocationPopup extends StatelessWidget {
  const LocationPopup({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: Container(
          width: 720,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              /// HEADER
              Row(
                children: const [
                  TextWidget(
                    'Select Location',
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                  Spacer(),
                  Icon(Icons.close),
                ],
              ),

              const SizedBox(height: 16),

              /// MAP PREVIEW
              ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: Image.asset(
                  'assets/images/map_preview.png',
                  height: 280,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),

              const SizedBox(height: 20),

              /// SAVE BUTTON
              Container(
                height: 44,
                padding: const EdgeInsets.symmetric(horizontal: 28),
                decoration: BoxDecoration(
                  color: const Color(0xFFF48C5A),
                  borderRadius: BorderRadius.circular(22),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextWidget(
                      'Save',
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                    SizedBox(width: 10),
                    Icon(Icons.arrow_forward, size: 16, color: Colors.white),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}