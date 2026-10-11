
import 'package:flutter/material.dart';

void main() {
  runApp(const ResponsiveApp());
}

class ResponsiveApp extends StatelessWidget {
  const ResponsiveApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Responsive UI Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.indigo,
        ),
        useMaterial3: true,
      ),
      home: const ResponsiveHomePage(),
    );
  }
}

class GalleryItem {
  final String title;
  final String description;
  final IconData icon;
  final Color color;

  const GalleryItem({
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
  });
}

class ResponsiveHomePage extends StatelessWidget {
  const ResponsiveHomePage({super.key});

  static const List<GalleryItem> items = [
    GalleryItem(
      title: 'Technology',
      description: 'Explore modern technology and innovation.',
      icon: Icons.computer,
      color: Colors.indigo,
    ),
    GalleryItem(
      title: 'Education',
      description: 'Discover new skills and learning resources.',
      icon: Icons.school,
      color: Colors.teal,
    ),
    GalleryItem(
      title: 'Nature',
      description: 'Experience the beauty of the natural world.',
      icon: Icons.park,
      color: Colors.green,
    ),
    GalleryItem(
      title: 'Science',
      description: 'Learn about scientific discoveries.',
      icon: Icons.science,
      color: Colors.deepPurple,
    ),
    GalleryItem(
      title: 'Travel',
      description: 'Explore exciting places around the world.',
      icon: Icons.travel_explore,
      color: Colors.deepOrange,
    ),
    GalleryItem(
      title: 'Creativity',
      description: 'Turn your ideas into creative projects.',
      icon: Icons.palette,
      color: Colors.pink,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Responsive Gallery',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final screenWidth = MediaQuery.of(context).size.width;

          final String category = screenWidth < 600
              ? 'Mobile'
              : screenWidth < 1024
                  ? 'Tablet'
                  : 'Desktop';

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Explore the Gallery',
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall
                          ?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Current device: $category',
                      style: const TextStyle(
                        color: Colors.indigo,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),

              Expanded(
                child: OrientationBuilder(
                  builder: (context, orientation) {
                    if (constraints.maxWidth < 600) {
                      return _buildMobileLayout(
                        context,
                        orientation,
                      );
                    } else if (constraints.maxWidth < 1024) {
                      return _buildTabletLayout(
                        context,
                        orientation,
                      );
                    } else {
                      return _buildDesktopLayout(context);
                    }
                  },
                ),
              ),

              _buildFooter(context, category),
            ],
          );
        },
      ),
    );
  }

  Widget _buildMobileLayout(
    BuildContext context,
    Orientation orientation,
  ) {
    if (orientation == Orientation.portrait) {
      return ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: items.length,
        itemBuilder: (context, index) {
          return _buildCard(
            items[index],
            cardHeight: 145,
          );
        },
      );
    }

    return ListView.builder(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.all(12),
      itemCount: items.length,
      itemBuilder: (context, index) {
        return SizedBox(
          width: 260,
          child: _buildCard(
            items[index],
            cardHeight: 180,
          ),
        );
      },
    );
  }

  Widget _buildTabletLayout(
    BuildContext context,
    Orientation orientation,
  ) {
    final double spacing =
        orientation == Orientation.portrait ? 12 : 24;

    final double padding =
        orientation == Orientation.portrait ? 16 : 24;

    return GridView.builder(
      padding: EdgeInsets.all(padding),
      itemCount: items.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: spacing,
        mainAxisSpacing: spacing,
        childAspectRatio:
            orientation == Orientation.portrait ? 1.2 : 1.5,
      ),
      itemBuilder: (context, index) {
        return _buildCard(items[index]);
      },
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(24),
      itemCount: items.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 24,
        mainAxisSpacing: 24,
        childAspectRatio: 1.5,
      ),
      itemBuilder: (context, index) {
        return _buildCard(items[index]);
      },
    );
  }

  Widget _buildCard(
    GalleryItem item, {
    double cardHeight = 200,
  }) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(8),
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: Container(
        constraints: BoxConstraints(
          minHeight: cardHeight,
        ),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              item.color.withValues(alpha: 0.15),
              Colors.white,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 28,
              backgroundColor: item.color,
              child: Icon(
                item.icon,
                color: Colors.white,
                size: 30,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    item.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    item.description,
                    style: const TextStyle(
                      fontSize: 13,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFooter(
    BuildContext context,
    String category,
  ) {
    final size = MediaQuery.of(context).size;
    final orientation = MediaQuery.of(context).orientation;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 14,
      ),
      color: Colors.indigo,
      child: SafeArea(
        top: false,
        child: Text(
          '$category | Width: ${size.width.toStringAsFixed(0)} px'
          ' | ${orientation == Orientation.portrait ? 'Portrait' : 'Landscape'}',
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}