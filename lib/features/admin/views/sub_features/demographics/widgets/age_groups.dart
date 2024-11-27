import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teen_splash/features/admin/admin_bloc/admin_bloc.dart';
import 'package:teen_splash/features/users/user_bloc/user_bloc.dart';

class AgeGroups extends StatefulWidget {
  const AgeGroups({super.key});

  @override
  State<AgeGroups> createState() => _AgeGroupsState();
}

class _AgeGroupsState extends State<AgeGroups> {
  late final AdminBloc adminBloc;
  late final UserBloc userBloc;
  @override
  void initState() {
    adminBloc = context.read<AdminBloc>();
    if (adminBloc.coupons.isEmpty) {
      adminBloc.add(
        GetCoupon(),
      );
    }
    userBloc = context.read<UserBloc>();
    if (userBloc.users.isEmpty) {
      userBloc.add(
        GetAllUsers(),
      );
    }
    super.initState();
  }

  final List<Map<String, int>> ageRanges = [
    {'min': 5, 'max': 10},
    {'min': 10, 'max': 15},
    {'min': 15, 'max': 20},
    {'min': 20, 'max': 25},
    {'min': 25, 'max': 30},
    {'min': 30, 'max': 35},
    {'min': 35, 'max': 40},
    {'min': 40, 'max': 45},
    {'min': 45, 'max': 50},
    {'min': 50, 'max': 100}, // 50+ years
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        Map<String, int> countUsersInAgeRanges() {
          // Combine all userIds from all coupons into a set to remove duplicates
          final Set<String> userIdsUsingCoupons = adminBloc.coupons
              .expand((coupon) => coupon.userIds ?? [])
              .cast<String>()
              .toSet();

          // Filter users who used any coupon
          final usersUsingCoupons = userBloc.users.where((user) {
            return userIdsUsingCoupons.contains(user.uid);
          });

          // Count users in each age range
          final Map<String, int> counts = {};
          for (final range in ageRanges) {
            final count = usersUsingCoupons.where((user) {
              if (user.age == null || user.age!.isEmpty) return false;
              final age = int.tryParse(user.age!);
              if (age == null) return false;
              return age >= range['min']! && age < range['max']!;
            }).length;

            counts['${range['min']}-${range['max']}'] = count;
          }

          return counts;
        }

        final ageGroupCounts = countUsersInAgeRanges();

        if (state is GetAllUsersFailed) {
          return Center(
            child: Text(state.message),
          );
        } else if (state is GettingAllUsers) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return DataTable(
          headingTextStyle: const TextStyle(
            fontFamily: 'Inter',
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: Color(
              0xFF131313,
            ),
          ),
          dataTextStyle: const TextStyle(
            fontFamily: 'Inter',
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: Color(
              0xFF131313,
            ),
          ),
          columns: ageRanges
              .map(
                (range) => DataColumn(
                  label: Text('${range['min']}-${range['max']}\nyears'),
                ),
              )
              .toList(),
          rows: [
            DataRow(
              cells: ageGroupCounts.values
                  .map(
                    (count) => DataCell(
                      Text('$count'),
                    ),
                  )
                  .toList(),
            ),
          ],
        );
      },
    );
  }
}
