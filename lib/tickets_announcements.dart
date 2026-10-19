import 'package:flutter/material.dart';
import 'app_data.dart';

// ==========================================
// 1. TICKETS & RAISE A TICKET SCREENS
// ==========================================
class TicketsListScreen extends StatefulWidget {
  const TicketsListScreen({super.key});

  @override
  State<TicketsListScreen> createState() => _TicketsListScreenState();
}

class _TicketsListScreenState extends State<TicketsListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgGrey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textDark),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Tickets', style: TextStyle(color: AppColors.textDark, fontSize: 20, fontWeight: FontWeight.w600)),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: AppColors.textDark),
            onPressed: () {},
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.done_all, size: 48, color: AppColors.textLightGrey),
              const SizedBox(height: 16),
              const Text(
                'No tickets here yet.',
                style: TextStyle(color: AppColors.textDark, fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 6),
              const Text(
                'Raise one with the button below.',
                style: TextStyle(color: AppColors.textGrey, fontSize: 14),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        color: Colors.white,
        child: SizedBox(
          width: double.infinity,
          height: 52,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryBlue,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(26)),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const RaiseTicketScreen()),
              );
            },
            child: const Text('Raise a ticket', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600)),
          ),
        ),
      ),
    );
  }
}

class RaiseTicketScreen extends StatefulWidget {
  const RaiseTicketScreen({super.key});

  @override
  State<RaiseTicketScreen> createState() => _RaiseTicketScreenState();
}

class _RaiseTicketScreenState extends State<RaiseTicketScreen> {
  String? _category;
  String? _subCategory;
  final TextEditingController _descController = TextEditingController();
  String _urgency = 'Basic'; // Basic, Medium, Critical

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgGrey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textDark),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Raise a ticket', style: TextStyle(color: AppColors.textDark, fontSize: 20, fontWeight: FontWeight.w600)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("WHAT'S THE PROBLEM", style: TextStyle(color: AppColors.textGrey, fontSize: 12, fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Category', style: TextStyle(color: AppColors.textGrey, fontSize: 13)),
                  const SizedBox(height: 6),
                  DropdownButtonFormField<String>(
                    value: _category,
                    hint: const Text('Choose a category'),
                    isExpanded: true,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.borderGrey)),
                    ),
                    items: ['Maintenance', 'Electrical', 'Plumbing', 'Internet', 'Carpentry'].map((c) {
                      return DropdownMenuItem(value: c, child: Text(c));
                    }).toList(),
                    onChanged: (val) => setState(() => _category = val),
                  ),
                  const SizedBox(height: 16),
                  const Text('Sub category', style: TextStyle(color: AppColors.textGrey, fontSize: 13)),
                  const SizedBox(height: 6),
                  DropdownButtonFormField<String>(
                    value: _subCategory,
                    hint: const Text('Choose a category first'),
                    isExpanded: true,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.borderGrey)),
                    ),
                    items: ['General Issue', 'Repair Required', 'Replacement'].map((s) {
                      return DropdownMenuItem(value: s, child: Text(s));
                    }).toList(),
                    onChanged: (val) => setState(() => _subCategory = val),
                  ),
                  const SizedBox(height: 16),
                  const Text('Description', style: TextStyle(color: AppColors.textGrey, fontSize: 13)),
                  const SizedBox(height: 6),
                  TextField(
                    controller: _descController,
                    decoration: InputDecoration(
                      hintText: "What's wrong, and where exactly?",
                      hintStyle: const TextStyle(color: AppColors.textLightGrey),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.borderGrey)),
                      contentPadding: const EdgeInsets.all(14),
                    ),
                    maxLines: 3,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Text('URGENCY', style: TextStyle(color: AppColors.textGrey, fontSize: 12, fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            Row(
              children: ['Basic', 'Medium', 'Critical'].map((u) {
                final bool isSelected = _urgency == u;
                return Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(right: u != 'Critical' ? 8 : 0),
                    child: GestureDetector(
                      onTap: () => setState(() => _urgency = u),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: isSelected ? AppColors.primaryBlue : Colors.white,
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(color: isSelected ? AppColors.primaryBlue : AppColors.borderGrey),
                        ),
                        child: Text(
                          u,
                          style: TextStyle(
                            color: isSelected ? Colors.white : AppColors.textDark,
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            const Text('PHOTOS', style: TextStyle(color: AppColors.textGrey, fontSize: 12, fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Optional. Up to 4 photos, 5MB each. A picture of the problem gets it fixed faster.',
                    style: TextStyle(color: AppColors.textGrey, fontSize: 12, height: 1.4),
                  ),
                  const SizedBox(height: 12),
                  OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: AppColors.borderGrey),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    ),
                    onPressed: () {},
                    icon: const Icon(Icons.camera_alt_outlined, color: AppColors.primaryBlue),
                    label: const Text('Add photos', style: TextStyle(color: AppColors.primaryBlue, fontSize: 14)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryBlue,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(26)),
                ),
                onPressed: () => Navigator.pop(context),
                child: const Text('Submit ticket', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ==========================================
// 2. ANNOUNCEMENTS SCREEN
// ==========================================
class AnnouncementsScreen extends StatelessWidget {
  const AnnouncementsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final data = AppData.instance;
    return Scaffold(
      backgroundColor: AppColors.bgGrey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textDark),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Announcements', style: TextStyle(color: AppColors.textDark, fontSize: 20, fontWeight: FontWeight.w600)),
        actions: [
          IconButton(
            icon: const Icon(Icons.tune, color: AppColors.textDark),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: data.announcements.length,
        itemBuilder: (context, index) {
          final item = data.announcements[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 8, offset: const Offset(0, 3)),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      item.category,
                      style: const TextStyle(color: AppColors.textGrey, fontSize: 12, fontWeight: FontWeight.w600, letterSpacing: 0.5),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                      decoration: BoxDecoration(color: AppColors.orangeBg, borderRadius: BorderRadius.circular(12)),
                      child: Row(
                        children: [
                          const CircleAvatar(radius: 3, backgroundColor: AppColors.orangeText),
                          const SizedBox(width: 6),
                          Text(
                            item.priority,
                            style: const TextStyle(color: AppColors.orangeText, fontSize: 12, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  item.message,
                  style: const TextStyle(color: AppColors.textDark, fontSize: 14, height: 1.4),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: Divider(color: AppColors.borderGrey, height: 1),
                ),
                Row(
                  children: [
                    const CircleAvatar(
                      radius: 14,
                      backgroundColor: Color(0xFF3E7B96),
                      child: Icon(Icons.person, color: Colors.white, size: 16),
                    ),
                    const SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(item.author, style: const TextStyle(color: AppColors.textDark, fontSize: 13, fontWeight: FontWeight.w600)),
                        Text(item.dateTime, style: const TextStyle(color: AppColors.textGrey, fontSize: 11)),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

// ==========================================
// 3. SUPPORT SCREEN
// ==========================================
class SupportScreen extends StatelessWidget {
  const SupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgGrey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text('Help', style: TextStyle(color: AppColors.textDark, fontSize: 22, fontWeight: FontWeight.w600)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Answers to the questions that come up most, and a person for everything else.',
              style: TextStyle(color: AppColors.textGrey, fontSize: 14, height: 1.4),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                gradient: const LinearGradient(colors: [AppColors.headerBlueTop, AppColors.headerBlueBottom]),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(12)),
                    child: const Icon(Icons.phone, color: Colors.white),
                  ),
                  const SizedBox(width: 14),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Contact us', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600)),
                        SizedBox(height: 2),
                        Text('Reach your hostel office or SpaceBasic.', style: TextStyle(color: Color(0xFFD6DCFF), fontSize: 13)),
                      ],
                    ),
                  ),
                  const Icon(Icons.arrow_forward, color: Colors.white),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(color: AppColors.iconBgBlue, borderRadius: BorderRadius.circular(12)),
                    child: const Icon(Icons.help_outline, color: AppColors.primaryBlue),
                  ),
                  const SizedBox(width: 14),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Common questions', style: TextStyle(color: AppColors.textDark, fontSize: 16, fontWeight: FontWeight.w600)),
                        SizedBox(height: 2),
                        Text('Leave, tickets, announcements and signing in', style: TextStyle(color: AppColors.textGrey, fontSize: 13)),
                      ],
                    ),
                  ),
                  const Icon(Icons.chevron_right, color: AppColors.textGrey),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(Icons.videocam_outlined, color: AppColors.textGrey, size: 18),
                  SizedBox(width: 8),
                  Text('Video tutorials are on the way.', style: TextStyle(color: AppColors.textGrey, fontSize: 13)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
