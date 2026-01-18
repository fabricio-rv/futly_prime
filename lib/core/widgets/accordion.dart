import 'package:flutter/material.dart';

class AccordionItem {
  final String title;
  final List<String> items;
  bool isExpanded;

  AccordionItem({
    required this.title,
    required this.items,
    this.isExpanded = false,
  });
}

class AccordionSection extends StatefulWidget {
  final List<AccordionItem> items;

  const AccordionSection({
    Key? key,
    required this.items,
  }) : super(key: key);

  @override
  State<AccordionSection> createState() => _AccordionSectionState();
}

class _AccordionSectionState extends State<AccordionSection> {
  late List<AccordionItem> _items;

  @override
  void initState() {
    super.initState();
    _items = widget.items
        .map((item) => AccordionItem(
              title: item.title,
              items: item.items,
              isExpanded: item.isExpanded,
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      children: List.generate(_items.length, (index) {
        final item = _items[index];
        return Column(
          children: [
            InkWell(
              onTap: () {
                setState(() {
                  item.isExpanded = !item.isExpanded;
                });
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: isDark
                          ? const Color(0xFF333333)
                          : const Color(0xFFEEEEEE),
                      width: 1,
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        item.title,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                    Icon(
                      item.isExpanded ? Icons.expand_less : Icons.expand_more,
                    ),
                  ],
                ),
              ),
            ),
            if (item.isExpanded)
              Container(
                padding: const EdgeInsets.all(16),
                color:
                    isDark ? const Color(0xFF0F0F0F) : const Color(0xFFFAFAFA),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: item.items
                      .map((text) => Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Text(
                              '• $text',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ))
                      .toList(),
                ),
              ),
          ],
        );
      }),
    );
  }
}
