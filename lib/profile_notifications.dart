import 'package:flutter/material.dart';
import 'app_data.dart';
import 'main.dart'; // for SuitAvatarWidget

// ==========================================
// 1. MY PROFILE & SUB-SCREENS
// ==========================================
class MyProfileScreen extends StatelessWidget {
  const MyProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final data = AppData.instance;
    return Scaffold(
      backgroundColor: AppColors.bgGrey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text('My Profile', style: TextStyle(color: AppColors.textDark, fontSize: 22, fontWeight: FontWeight.w600)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // User Card
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10, offset: const Offset(0, 4))],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Stack(
                      children: [
                        const SuitAvatarWidget(size: 64),
                        Positioned(
                          right: 0,
                          bottom: 0,
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: const BoxDecoration(color: AppColors.primaryBlue, shape: BoxShape.circle),
                            child: const Icon(Icons.camera_alt, color: Colors.white, size: 12),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data.studentName,
                            style: const TextStyle(color: AppColors.textDark, fontSize: 18, fontWeight: FontWeight.w700),
                          ),
                          const SizedBox(height: 6),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(color: AppColors.iconBgBlue, borderRadius: BorderRadius.circular(20)),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(Icons.bed_outlined, size: 14, color: AppColors.primaryBlue),
                                const SizedBox(width: 6),
                                Text(
                                  data.hostelRoomDot,
                                  style: const TextStyle(color: AppColors.primaryBlue, fontSize: 12, fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    const Icon(Icons.phone_outlined, size: 16, color: AppColors.textGrey),
                    const SizedBox(width: 10),
                    Text(data.studentMobile, style: const TextStyle(color: AppColors.textDark, fontSize: 14)),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.email_outlined, size: 16, color: AppColors.textGrey),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        data.studentEmail,
                        style: const TextStyle(color: AppColors.textDark, fontSize: 14),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      backgroundColor: Colors.white,
                      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
                      builder: (_) => Padding(
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text('Show my QR code', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
                            const SizedBox(height: 16),
                            Container(
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(border: Border.all(color: AppColors.borderGrey), borderRadius: BorderRadius.circular(16)),
                              child: const Icon(Icons.qr_code_2, size: 160, color: AppColors.textDark),
                            ),
                            const SizedBox(height: 12),
                            Text(data.studentName, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15)),
                            Text(data.hostelRoomDot, style: const TextStyle(color: AppColors.textGrey, fontSize: 13)),
                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(color: AppColors.iconBgBlue, borderRadius: BorderRadius.circular(14)),
                    child: Row(
                      children: [
                        const Icon(Icons.qr_code, color: AppColors.primaryBlue),
                        const SizedBox(width: 12),
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Show my QR code', style: TextStyle(color: AppColors.textDark, fontSize: 15, fontWeight: FontWeight.w600)),
                              SizedBox(height: 2),
                              Text('Attendance, amenities and check-in', style: TextStyle(color: AppColors.textGrey, fontSize: 12)),
                            ],
                          ),
                        ),
                        const Icon(Icons.chevron_right, color: AppColors.primaryBlue),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // Menu List
          Container(
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
            child: Column(
              children: [
                _buildMenuTile(
                  icon: Icons.person_outline,
                  title: 'My Information',
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const StudentInfoScreen())),
                ),
                const Divider(height: 1, indent: 16, endIndent: 16),
                _buildMenuTile(
                  icon: Icons.lock_outline,
                  title: 'Change Password',
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ChangePasswordScreen())),
                ),
                const Divider(height: 1, indent: 16, endIndent: 16),
                _buildMenuTile(
                  icon: Icons.settings_outlined,
                  title: 'App Settings',
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AppSettingsScreen())),
                ),
                const Divider(height: 1, indent: 16, endIndent: 16),
                _buildMenuTile(
                  icon: Icons.privacy_tip_outlined,
                  title: 'Privacy & Consent',
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const PrivacyConsentScreen())),
                ),
                const Divider(height: 1, indent: 16, endIndent: 16),
                _buildMenuTile(
                  icon: Icons.logout,
                  title: 'Sign Out',
                  titleColor: AppColors.signOutRed,
                  iconColor: AppColors.signOutRed,
                  onTap: () => _showSignOutDialog(context),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text('Privacy Policy', style: TextStyle(color: AppColors.textGrey, fontSize: 13, decoration: TextDecoration.underline)),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Text('•', style: TextStyle(color: AppColors.textGrey)),
              ),
              Text('Terms & Conditions', style: TextStyle(color: AppColors.textGrey, fontSize: 13, decoration: TextDecoration.underline)),
            ],
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildMenuTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Color titleColor = AppColors.textDark,
    Color iconColor = AppColors.textGrey,
  }) {
    return ListTile(
      leading: Icon(icon, color: iconColor),
      title: Text(title, style: TextStyle(color: titleColor, fontSize: 15, fontWeight: FontWeight.w500)),
      trailing: const Icon(Icons.chevron_right, color: AppColors.textGrey),
      onTap: onTap,
    );
  }

  void _showSignOutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(color: const Color(0xFFFFF2F3), borderRadius: BorderRadius.circular(10)),
              child: const Icon(Icons.logout, color: AppColors.signOutRed, size: 20),
            ),
            const SizedBox(width: 12),
            const Text('Sign out of SpaceBasic?', style: TextStyle(fontSize: 18)),
          ],
        ),
        content: const Text("You'll need your login details to get back in.", style: TextStyle(color: AppColors.textGrey)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Stay signed in', style: TextStyle(color: AppColors.primaryBlue, fontWeight: FontWeight.w600)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.signOutRed, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
            onPressed: () => Navigator.pop(context),
            child: const Text('Sign out', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}

class StudentInfoScreen extends StatelessWidget {
  const StudentInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final data = AppData.instance;
    return Scaffold(
      backgroundColor: AppColors.bgGrey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(icon: const Icon(Icons.arrow_back, color: AppColors.textDark), onPressed: () => Navigator.pop(context)),
        title: const Text('Student Information', style: TextStyle(color: AppColors.textDark, fontSize: 20, fontWeight: FontWeight.w600)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
            child: Column(
              children: [
                const SuitAvatarWidget(size: 64),
                const SizedBox(height: 12),
                Text(data.studentName, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
                const Divider(height: 30),
                _infoRow('Gender', data.gender, 'Mobile no', data.studentMobile, hasCall: true),
                const Divider(height: 24),
                _infoRow('DOB', data.dob, 'Email', data.studentEmail),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('HOSTEL INFO', style: TextStyle(color: AppColors.textGrey, fontSize: 12, fontWeight: FontWeight.w600)),
                const SizedBox(height: 16),
                _infoRow('Room Number', data.roomNumber, 'Floor', data.floor),
                const Divider(height: 24),
                _infoRow('Block', data.blockName, 'Hostel', data.hostelName),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('PARENTS', style: TextStyle(color: AppColors.textGrey, fontSize: 12, fontWeight: FontWeight.w600)),
                const SizedBox(height: 16),
                _infoRow('Name', data.parentName, 'Mobile no', data.parentMobile, hasCall: true),
                const Divider(height: 24),
                _infoRow('Email', data.parentEmail, 'Occupation', data.parentOccupation),
                const Divider(height: 24),
                _infoRow('Address', data.parentAddress, 'City', data.parentCity),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoRow(String label1, String val1, String label2, String val2, {bool hasCall = false}) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label1, style: const TextStyle(color: AppColors.textGrey, fontSize: 12)),
              const SizedBox(height: 2),
              Text(val1, style: const TextStyle(color: AppColors.textDark, fontSize: 14, fontWeight: FontWeight.w600)),
            ],
          ),
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(label2, style: const TextStyle(color: AppColors.textGrey, fontSize: 12)),
                    const SizedBox(height: 2),
                    Text(val2, style: const TextStyle(color: AppColors.textDark, fontSize: 14, fontWeight: FontWeight.w600), overflow: TextOverflow.ellipsis),
                  ],
                ),
              ),
              if (hasCall)
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(color: AppColors.iconBgBlue, shape: BoxShape.circle),
                  child: const Icon(Icons.phone, size: 16, color: AppColors.primaryBlue),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgGrey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(icon: const Icon(Icons.arrow_back, color: AppColors.textDark), onPressed: () => Navigator.pop(context)),
        title: const Text('Change password', style: TextStyle(color: AppColors.textDark, fontSize: 20, fontWeight: FontWeight.w600)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Pick something you don't use anywhere else. You'll stay signed in on this device.", style: TextStyle(color: AppColors.textGrey, fontSize: 13, height: 1.4)),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Current password', style: TextStyle(color: AppColors.textGrey, fontSize: 13)),
                  const SizedBox(height: 6),
                  TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'Enter your current password',
                      suffixIcon: const Icon(Icons.visibility_outlined, color: AppColors.textGrey),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.borderGrey)),
                      contentPadding: const EdgeInsets.all(14),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text('New password', style: TextStyle(color: AppColors.textGrey, fontSize: 13)),
                  const SizedBox(height: 2),
                  const Text('8–16 characters, with a capital letter, a number, and one of @ $ ! % * ? &', style: TextStyle(color: AppColors.textLightGrey, fontSize: 11)),
                  const SizedBox(height: 6),
                  TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'Enter a new password',
                      suffixIcon: const Icon(Icons.visibility_outlined, color: AppColors.textGrey),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.borderGrey)),
                      contentPadding: const EdgeInsets.all(14),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text('Confirm new password', style: TextStyle(color: AppColors.textGrey, fontSize: 13)),
                  const SizedBox(height: 6),
                  TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'Type it again',
                      suffixIcon: const Icon(Icons.visibility_outlined, color: AppColors.textGrey),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.borderGrey)),
                      contentPadding: const EdgeInsets.all(14),
                      
