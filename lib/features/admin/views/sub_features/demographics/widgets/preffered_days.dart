import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teen_splash/features/admin/admin_bloc/admin_bloc.dart';
import 'package:teen_splash/features/users/user_bloc/user_bloc.dart';

class PrefferedDays extends StatefulWidget {
  const PrefferedDays({super.key});

  @override
  State<PrefferedDays> createState() => _PrefferedDaysState();
}

class _PrefferedDaysState extends State<PrefferedDays> {
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

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdminBloc, AdminState>(
      builder: (context, state) {
        Map<String, int> calculateRedemptionsByDay() {
          final dayWiseRedemption = {
            'Monday': 0,
            'Tuesday': 0,
            'Wednesday': 0,
            'Thursday': 0,
            'Friday': 0,
            'Saturday': 0,
            'Sunday': 0,
          };

          String getDayOfWeek(int weekday) {
            switch (weekday) {
              case 1:
                return 'Monday';
              case 2:
                return 'Tuesday';
              case 3:
                return 'Wednesday';
              case 4:
                return 'Thursday';
              case 5:
                return 'Friday';
              case 6:
                return 'Saturday';
              case 7:
                return 'Sunday';
              default:
                return '';
            }
          }

          for (var coupon in adminBloc.coupons) {
            if (coupon.redemptionDates != null) {
              for (var date in coupon.redemptionDates!) {
                final day = getDayOfWeek(date.weekday);
                dayWiseRedemption[day] = (dayWiseRedemption[day] ?? 0) + 1;
              }
            }
          }

          return dayWiseRedemption;
        }

        final dayWiseRedemption = calculateRedemptionsByDay();

        if (state is GetCouponFailed) {
          return Center(
            child: Text(state.message),
          );
        } else if (state is GettingCoupon) {
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
          columns: const [
            DataColumn(
              label: Text('Day'),
            ),
            DataColumn(
              label: Text('Number of Coupons Redeemed'),
            ),
          ],
          rows: dayWiseRedemption.entries.map(
            (entry) {
              return DataRow(
                cells: [
                  DataCell(
                    Text(entry.key),
                  ),
                  DataCell(
                    Text('${entry.value}'),
                  ),
                ],
              );
            },
          ).toList(),
        );
      },
    );
  }
}
