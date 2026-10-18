import 'package:flutter/material.dart';
import 'app_data.dart';

// ==========================================
// 1. LEAVE MANAGER SCREEN
// ==========================================
class LeaveManagerScreen extends StatefulWidget {
  const LeaveManagerScreen({super.key});

  @override
  State<LeaveManagerScreen> createState() => _LeaveManagerScreenState();
}

class _LeaveManagerScreenState extends State<LeaveManagerScreen> {
  int _selectedFilterIndex = 0;
  final List<String> _filters = ['Requests', 'Active', 'Approved', 'Partly approved'];

  @override
  Widget build(BuildContext context) {
    final data = AppData.instance;
    return Scaffold(
      backgroundColor: AppColors.bgGrey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        titleSpacing: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textDark),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Leave manager',
          style: TextStyle(
            color: AppColors.textDark,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline, color: AppColors.textDark),
            onPressed: () {
              setState(() {
                data.leaves.clear();
                data.notifyAndSave();
              });
            },
          ),
          IconButton(
            icon: const Icon(Icons.tune, color: AppColors.textDark),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Filter Tabs
          Container(
            color: Colors.white,
            padding: const EdgeInsets.only(bottom: 12),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: List.generate(_filters.length, (index) {
                  final bool isSelected = _selectedFilterIndex == index;
                  return Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: ChoiceChip(
                      label: Text(_filters[index]),
                      selected: isSelected,
                      selectedColor: AppColors.primaryBlue,
                      backgroundColor: const Color(0xFFF0F2F8),
                      labelStyle: TextStyle(
                        color: isSelected ? Colors.white : AppColors.textDark,
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                        side: BorderSide.none,
                      ),
                      onSelected: (val) {
                        setState(() => _selectedFilterIndex = index);
                      },
                    ),
                  );
                }),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              data.totalLeavesText,
              style: const TextStyle(
                color: AppColors.textGrey,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(height: 8),
          // Leave Cards List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemCount: data.leaves.length,
              itemBuilder: (context, index) {
                final leave = data.leaves[index];
                return _buildLeaveCard(context, leave);
              },
            ),
          ),
        ],
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
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(26),
              ),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ApplyForLeaveScreen()),
              );
            },
            child: const Text(
              'Apply for leave',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLeaveCard(BuildContext context, LeaveItem leave) {
    final data = AppData.instance;
    final bool isCompleted = leave.status.toLowerCase() == 'completed';
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: isCompleted ? AppColors.greenBg : AppColors.orangeBg,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  leave.status,
                  style: TextStyle(
                    color: isCompleted ? AppColors.greenText : AppColors.orangeText,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFF2F4F8),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  leave.leaveType,
                  style: const TextStyle(
                    color: AppColors.textDark,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            leave.approvalSubtitle,
            style: const TextStyle(
              color: AppColors.textGrey,
              fontSize: 13,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const CircleAvatar(
                radius: 18,
                backgroundColor: Color(0xFFDCDFE6),
                child: Icon(Icons.person, color: Colors.white, size: 20),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data.studentName,
                      style: const TextStyle(
                        color: AppColors.textDark,
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      data.hostelRoomDot,
                      style: const TextStyle(
                        color: AppColors.textGrey,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: Divider(color: AppColors.borderGrey, height: 1),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Out', style: TextStyle(color: AppColors.textGrey, fontSize: 12)),
                  const SizedBox(height: 2),
                  Text(
                    leave.outDate.replaceAll('\n', ' '),
                    style: const TextStyle(color: AppColors.textDark, fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                  Text(leave.outTime, style: const TextStyle(color: AppColors.textGrey, fontSize: 11)),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFF0F2FA),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.access_time, size: 14, color: AppColors.primaryBlue),
                    const SizedBox(width: 4),
                    Text(
                      leave.duration,
                      style: const TextStyle(color: AppColors.primaryBlue, fontSize: 12, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text('Back', style: TextStyle(color: AppColors.textGrey, fontSize: 12)),
                  const SizedBox(height: 2),
                  Text(
                    leave.backDate.replaceAll('\n', ' '),
                    style: const TextStyle(color: AppColors.textDark, fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                  Text(leave.backTime, style: const TextStyle(color: AppColors.textGrey, fontSize: 11)),
                ],
              ),
            ],
          ),
          if (leave.reason.trim().isNotEmpty) ...[
            const SizedBox(height: 8),
            Text(leave.reason, style: const TextStyle(color: AppColors.textDark, fontSize: 13)),
          ],
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: Divider(color: AppColors.borderGrey, height: 1),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Applied on ${leave.appliedOn}',
                style: const TextStyle(color: AppColors.textGrey, fontSize: 12),
              ),
              Text(
                'Approvals ${leave.approvals}',
                style: const TextStyle(color: AppColors.textDark, fontSize: 12, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ==========================================
// 2. APPLY FOR LEAVE SCREEN
// ==========================================
class ApplyForLeaveScreen extends StatefulWidget {
  const ApplyForLeaveScreen({super.key});

  @override
  State<ApplyForLeaveScreen> createState() => _ApplyForLeaveScreenState();
}

class _ApplyForLeaveScreenState extends State<ApplyForLeaveScreen> {
  String? _selectedLeaveType;
  String? _selectedReason;
  final TextEditingController _descController = TextEditingController();
  final TextEditingController _whereController = TextEditingController();
  final TextEditingController _travelController = TextEditingController();
  bool _agreed = false;

  @override
  Widget build(BuildContext context) {
    final data = AppData.instance;
    return Scaffold(
      backgroundColor: AppColors.bgGrey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        titleSpacing: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textDark),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Apply for leave',
          style: TextStyle(color: AppColors.textDark, fontSize: 20, fontWeight: FontWeight.w600),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('THE LEAVE', style: TextStyle(color: AppColors.textGrey, fontSize: 12, fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Leave type', style: TextStyle(color: AppColors.textGrey, fontSize: 13)),
                  const SizedBox(height: 6),
                  DropdownButtonFormField<String>(
                    value: _selectedLeaveType,
                    hint: const Text('Choose a leave type'),
                    isExpanded: true,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.borderGrey)),
                    ),
                    items: ['Home Out New', 'Extraordinary Outing', 'Day Permission'].map((t) {
                      return DropdownMenuItem(value: t, child: Text(t));
                    }).toList(),
                    onChanged: (val) => setState(() => _selectedLeaveType = val),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Text('WHEN', style: TextStyle(color: AppColors.textGrey, fontSize: 12, fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Dates', style: TextStyle(color: AppColors.textDark, fontSize: 14, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(border: Border.all(color: AppColors.borderGrey), borderRadius: BorderRadius.circular(12)),
                          child: const Text('Choose a type first', style: TextStyle(color: AppColors.textLightGrey, fontSize: 13)),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(border: Border.all(color: AppColors.borderGrey), borderRadius: BorderRadius.circular(12)),
                          child: const Text('Pick a start first', style: TextStyle(color: AppColors.textLightGrey, fontSize: 13)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Text('WHY', style: TextStyle(color: AppColors.textGrey, fontSize: 12, fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Reason', style: TextStyle(color: AppColors.textGrey, fontSize: 13)),
                  const SizedBox(height: 6),
                  DropdownButtonFormField<String>(
                    value: _selectedReason,
                    hint: const Text('Choose a reason'),
                    isExpanded: true,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.borderGrey)),
                    ),
                    items: ['Others', 'Okay', 'Ok', 'Family Function', 'Medical'].map((r) {
                      return DropdownMenuItem(value: r, child: Text(r));
                    }).toList(),
                    onChanged: (val) => setState(() => _selectedReason = val),
                  ),
                  const SizedBox(height: 16),
                  const Text('Description', style: TextStyle(color: AppColors.textGrey, fontSize: 13)),
                  const SizedBox(height: 2),
                  const Text('The approver reads this.', style: TextStyle(color: AppColors.textLightGrey, fontSize: 11)),
                  const SizedBox(height: 6),
                  TextField(
                    controller: _descController,
                    decoration: InputDecoration(
                      hintText: 'Where you are going and why',
                      hintStyle: const TextStyle(color: AppColors.textLightGrey),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.borderGrey)),
                      contentPadding: const EdgeInsets.all(14),
                    ),
                    maxLines: 3,
                  ),
                  const SizedBox(height: 16),
                  const Text("Where you'll be", style: TextStyle(color: AppColors.textGrey, fontSize: 13)),
                  const SizedBox(height: 6),
                  TextField(
                    controller: _whereController,
                    decoration: InputDecoration(
                      hintText: 'Optional',
                      hintStyle: const TextStyle(color: AppColors.textLightGrey),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.borderGrey)),
                      contentPadding: const EdgeInsets.all(14),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text("How you'll travel", style: TextStyle(color: AppColors.textGrey, fontSize: 13)),
                  const SizedBox(height: 6),
                  TextField(
                    controller: _travelController,
                    decoration: InputDecoration(
                      hintText: 'Optional',
                      hintStyle: const TextStyle(color: AppColors.textLightGrey),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.borderGrey)),
                      contentPadding: const EdgeInsets.all(14),
                    ),
       
