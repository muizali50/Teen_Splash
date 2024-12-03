import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teen_splash/features/admin/admin_bloc/admin_bloc.dart';
import 'package:teen_splash/features/users/user_bloc/user_bloc.dart';
import 'package:teen_splash/model/coupon_model.dart';

class SpendingHabits extends StatefulWidget {
  const SpendingHabits({super.key});

  @override
  State<SpendingHabits> createState() => _SpendingHabitsState();
}

class _SpendingHabitsState extends State<SpendingHabits> {
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
        List<CouponModel> getRedeemedCoupons() {
          // Filter coupons with non-empty userIds list
          return adminBloc.coupons
              .where(
                (coupon) => (coupon.userIds?.isNotEmpty ?? false),
              )
              .toList();
        }

        final redeemedCoupons = getRedeemedCoupons();

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
              label: Text('Title'),
            ),
            DataColumn(
              label: Text('Product Name'),
            ),
            DataColumn(
              label: Text('Total Views'),
            ),
            DataColumn(
              label: Text('Total Redeemed'),
            ),
          ],
          rows: redeemedCoupons.map(
            (coupon) {
              return DataRow(
                cells: [
                  DataCell(
                    Text(coupon.businessName ?? 'N/A'),
                  ),
                  DataCell(
                    Text(coupon.item ?? 'N/A'),
                  ),
                  DataCell(
                    Text(
                      '${coupon.views?.length ?? 0}',
                    ),
                  ),
                  DataCell(
                    Text(
                      '${coupon.userIds?.length ?? 0}',
                    ),
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
