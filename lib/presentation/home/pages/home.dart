import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spotify/common/helpers/is_dark_mode.dart';
import 'package:spotify/common/widgets/appbar/app_bar.dart';
import 'package:spotify/core/config/assets/app_images.dart';
import 'package:spotify/core/config/assets/app_vectors.dart';
import 'package:spotify/core/config/theme/app_colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(showLogo: true, showBackButton: false),
      body: SingleChildScrollView(
        child: Column(children: [_homeArtistCard(), _tabs(context)]),
      ),
    );
  }

  Widget _homeArtistCard() {
    return Center(
      child: SizedBox(
        height: 150,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: SvgPicture.asset(AppVectors.homePageArtistBg),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Image.asset(AppImages.homePageTopArtist),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _tabs(BuildContext context) {
    return TabBar(
      controller: _tabController,
      isScrollable: true,
      indicatorColor: AppColors.primary,
      labelColor: context.isDarkMode ? Colors.white : Colors.black,
      unselectedLabelColor: context.isDarkMode 
          ? Colors.white.withOpacity(0.6) 
          : Colors.black.withOpacity(0.6),
      padding: const EdgeInsets.only(bottom: 20, top: 30),
      labelPadding: const EdgeInsets.symmetric(horizontal: 12),
      
      tabs: const [
        Text('News'),
        Text('Videos'),
        Text('Artists'),
        Text('Podcast')
      ],
    );
  }
}
