import 'package:flutter/material.dart';

class SiteSelector extends StatelessWidget {
  const SiteSelector({
    Key? key,
    required this.sites,
    required this.selectedIndex,
    required this.onChanged,
  }) : super(key: key);
  final List<String> sites;
  final int selectedIndex;
  final Function(int) onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Select site',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 12.0),
        SizedBox(
          height: 40.0,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: sites.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  onChanged(index);
                },
                child: Container(
                  height: 40.0,
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  margin: const EdgeInsets.only(right: 12.0),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(
                      width: 3.0,
                      color: selectedIndex == index
                          ? Colors.teal
                          : Colors.transparent,
                    ),
                  ),
                  child: Text(sites[index]),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
