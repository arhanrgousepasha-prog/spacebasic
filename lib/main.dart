import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app_data.dart';
import 'leave_mess.dart';
import 'tickets_announcements.dart';
import 'profile_notifications.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ),
  );
  runApp(const SpaceBasicApp());
}

class SpaceBasicApp extends StatelessWidget {
  const SpaceBasicApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: AppData.instance,
      builder: (context, _) {
        return MaterialApp(
          title: 'SpaceBasic',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            useMaterial3: true,
            scaffoldBackgroundColor: AppColors.bgGrey,
            colorScheme: ColorScheme.fromSeed(
              seedColor: AppColors.primaryBlue,
              primary: AppColors.primaryBlue,
            ),
          ),
          home: const MainShell(),
        );
      },
    );
  }
}

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final data = AppData.instance;
    final pages = [
      const HomeScreen(),
      const NotificationsScreen(),
      const SupportScreen(),
      const MyProfileScreen(),
    ];

    return Scaffold(
      body: pages[_currentIndex],
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(color: Color(0xFFECEEF4), width: 1),
          ),
        ),
        child: SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(
                  index: 0,
                  label: 'Home',
                  icon: Icons.home_outlined,
                  activeIcon: Icons.home,
                ),
                _buildNavItem(
                  index: 1,
                  label: 'Notifications',
                  icon: Icons.notifications_none_outlined,
                  activeIcon: Icons.notifications,
                  badgeText: data.notificationBadge,
                ),
                _buildNavItem(
                  index: 2,
                  label: 'Support',
                  icon: Icons.forum_outlined,
                  activeIcon: Icons.forum,
                ),
                _buildProfileNavItem(index: 3),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required int index,
    required String label,
    required IconData icon,
    required IconData activeIcon,
    String? badgeText,
  }) {
    final bool isSelected = _currentIndex == index;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => setState(() => _currentIndex = index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: 64,
                height: 34,
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.iconBgBlue : Colors.transparent,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Icon(
                  isSelected ? activeIcon : icon,
                  color: isSelected
                      ? AppColors.primaryBlue
                      : const Color(0xFF5A6070),
                  size: 24,
                ),
              ),
              if (badgeText != null && badgeText.trim().isNotEmpty)
                Positioned(
                  right: 8,
                  top: -2,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 1.5,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.badgeRed,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      badgeText,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              color: isSelected ? AppColors.primaryBlue : AppColors.textGrey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileNavItem({required int index}) {
    final bool isSelected = _currentIndex == index;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => setState(() => _currentIndex = index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 64,
            height: 34,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: isSelected ? AppColors.iconBgBlue : Colors.transparent,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: isSelected
                    ? Border.all(color: AppColors.primaryBlue, width: 2)
                    : null,
              ),
              child: const SuitAvatarWidget(size: 26),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'My Profile',
            style: TextStyle(
              fontSize: 12,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              color: isSelected ? AppColors.primaryBlue : AppColors.textGrey,
            ),
          ),
        ],
      ),
    );
  }
}

class SuitAvatarWidget extends StatelessWidget {
  final double size;
  const SuitAvatarWidget({super.key, this.size = 40});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF3E7B96), Color(0xFF23536B)],
        ),
      ),
      child: ClipOval(
        child: CustomPaint(
          painter: _SuitAvatarPainter(),
        ),
      ),
    );
  }
}

class _SuitAvatarPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // Suit shoulders
    final suitPaint = Paint()..color = const Color(0xFF42474D);
    final suitPath = Path()
      ..moveTo(w * 0.12, h)
      ..quadraticBezierTo(w * 0.5, h * 0.65, w * 0.88, h)
      ..close();
    canvas.drawPath(suitPath, suitPaint);

    // White shirt V
    final shirtPaint = Paint()..color = Colors.white;
    final shirtPath = Path()
      ..moveTo(w * 0.36, h * 0.72)
      ..lineTo(w * 0.5, h)
      ..lineTo(w * 0.64, h * 0.72)
      ..close();
    canvas.drawPath(shirtPath, shirtPaint);

    // Purple tie
    final tiePaint = Paint()..color = const Color(0xFF8C3A75);
    final tiePath = Path()
      ..moveTo(w * 0.46, h * 0.74)
      ..lineTo(w * 0.54, h * 0.74)
      ..lineTo(w * 0.53, h)
      ..lineTo(w * 0.47, h)
      ..close();
    canvas.drawPath(tiePath, tiePaint);

    // Neck
    final skinPaint = Paint()..color = const Color(0xFFF3C8A6);
    canvas.drawRect(
      Rect.fromLTWH(w * 0.41, h * 0.55, w * 0.18, h * 0.2),
      skinPaint,
    );

    // Head
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(w * 0.5, h * 0.4),
        width: w * 0.38,
        height: h * 0.42,
      ),
      skinPaint,
    );

    // Hair
    final hairPaint = Paint()..color = const Color(0xFF3A3532);
    final hairPath = Path()
      ..moveTo(w * 0.31, h * 0.4)
      ..quadraticBezierTo(w * 0.3, h * 0.16, w * 0.5, h * 0.17)
      ..quadraticBezierTo(w * 0.7, h * 0.16, w * 0.69, h * 0.4)
      ..quadraticBezierTo(w * 0.6, h * 0.27, w * 0.48, h * 0.28)
      ..quadraticBezierTo(w * 0.36, h * 0.28, w * 0.31, h * 0.4)
      ..close();
    canvas.drawPath(hairPath, hairPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final data = AppData.instance;
    return Column(
      children: [
        // Top Blue Banner
        Container(
          width: double.infinity,
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top + 22,
            left: 20,
            right: 20,
            bottom: 26,
          ),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [AppColors.headerBlueTop, AppColors.headerBlueBottom],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 34,
                    height: 34,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.menu_book_rounded,
                      color: Color(0xFF17375E),
                      size: 21,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      data.universityName,
                      style: const TextStyle(
                        color: Color(0xFFD6DCFF),
                        fontSize: 13,
                        letterSpacing: 1.5,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              Text(
                data.greetingText,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 27,
                  fontWeight: FontWeight.w500,
                  letterSpacing: -0.3,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                data.homeDateText,
                style: const TextStyle(
                  color: Color(0xFFC5CEFF),
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
        // Body Content
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 22),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    'QUICK ACTIONS',
                    style: TextStyle(
                      color: AppColors.textGrey,
                      fontSize: 12.5,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.0,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      _buildQuickActionPill(
                        context: context,
                        icon: Icons.calendar_month_outlined,
                        label: 'Apply for leave',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const ApplyForLeaveScreen(),
                            ),
                          );
                        },
                      ),
                      const SizedBox(width: 12),
                      _buildQuickActionPill(
                        context: context,
                        icon: Icons.handyman_outlined,
                        label: 'Raise a ticket',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const RaiseTicketScreen(),
                            ),
                          );
                        },
                      ),
                      const SizedBox(width: 12),
                      _buildQuickActionPill(
                        context: context,
                        icon: Icons.restaurant_outlined,
                        label: 'Mess bookings',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const MessBookingsScreen(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 26),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    'APPS',
                    style: TextStyle(
                      color: AppColors.textGrey,
                      fontSize: 12.5,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.0,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 20,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.03),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildAppShortcut(
                          icon: Icons.calendar_month_outlined,
                          label: 'Leave\nManager',
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const LeaveManagerScreen(),
                              ),
                            );
                          },
                        ),
                        _buildAppShortcut(
                          icon: Icons.handyman_outlined,
                          label: 'Tickets',
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const TicketsListScreen(),
                              ),
                            );
                          },
                        ),
                        _buildAppShortcut(
                          icon: Icons.campaign_outlined,
                          label: 'Announce\nments',
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const AnnouncementsScreen(),
                              ),
                            );
                          },
                        ),
                        _buildAppShortcut(
                          icon: Icons.restaurant_outlined,
                          label: 'Mess\nManager',
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const MessMenuScreen(),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildQuickActionPill({
    required BuildContext context,
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: AppColors.primaryBlue, size: 20),
            const SizedBox(width: 10),
            Text(
              label,
              style: const TextStyle(
                color: AppColors.textDark,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppShortcut({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: AppColors.iconBgBlue,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Icon(
              icon,
              color: AppColors.primaryBlue,
              size: 28,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: AppColors.textDark,
              font
