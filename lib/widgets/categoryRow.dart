import 'package:flutter/material.dart';
import 'package:movieapp/widgets/movieTab.dart';

const _accent = Color(0xFFE23B5B);
const _promoPink = Color(0xFFFCE4EA);

class CategoryRow extends StatelessWidget {
  const CategoryRow({
    super.key,
    required this.selected,
    required this.onTap,
  });

  final int selected;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 116,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        scrollDirection: Axis.horizontal,
        itemCount: movieTabs.length,
        separatorBuilder: (_, __) => const SizedBox(width: 35),
        itemBuilder: (context, i) {
          final tab = movieTabs[i];
          final isSelected = i == selected;

          return GestureDetector(
            onTap: () => onTap(i),
            child: SizedBox(
              width: 72,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CategoryAvatar(tab: tab, isSelected: isSelected),
                  const SizedBox(height: 6),
                  Text(
                    tab.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                      fontWeight:
                      isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class CategoryAvatar extends StatelessWidget {
  const CategoryAvatar({
    super.key,
    required this.tab,
    required this.isSelected,
  });

  final MovieTab tab;
  final bool isSelected;

  IconData get _icon {
    switch (tab.category) {
      case MovieCategory.nowPlaying:
        return Icons.movie;
      case MovieCategory.upcoming:
        return Icons.schedule;
      case MovieCategory.topRated:
        return Icons.star;
      case MovieCategory.popular:
        return Icons.local_fire_department;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: isSelected ? _accent : Colors.transparent,
          width: 2,
        ),
      ),
      child: CircleAvatar(
        radius: 30,
        backgroundColor: _promoPink,
        child: Icon(_icon, color: _accent, size: 28),
      ),
    );
  }
}