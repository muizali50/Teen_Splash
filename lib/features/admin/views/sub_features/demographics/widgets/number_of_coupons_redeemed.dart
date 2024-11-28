import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teen_splash/features/admin/admin_bloc/admin_bloc.dart';
import 'package:teen_splash/features/users/user_bloc/user_bloc.dart';

class NumberofCouponRedeemed extends StatefulWidget {
  const NumberofCouponRedeemed({super.key});

  @override
  State<NumberofCouponRedeemed> createState() => _NumberofCouponRedeemedState();
}

class _NumberofCouponRedeemedState extends State<NumberofCouponRedeemed> {
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
        if (state is GetCouponFailed) {
          return Center(
            child: Text(state.message),
          );
        } else if (state is GettingCoupon) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return adminBloc.coupons.isEmpty
            ? const Center(
                child: Text(
                  'No Coupons',
                  style: TextStyle(
                    color: Color(
                      0xFF131313,
                    ),
                  ),
                ),
              )
            : DataTable(
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
                    label: Text('Coupon Title'),
                  ),
                  DataColumn(
                    label: Text('Total Redemptions'),
                  ),
                ],
                rows: adminBloc.coupons
                    .map(
                      (offer) => DataRow(
                        cells: [
                          DataCell(
                            Text(
                              offer.businessName ?? '',
                            ),
                          ),
                          DataCell(
                            Text(
                              offer.userIds!.length.toString(),
                            ),
                          ),
                        ],
                      ),
                    )
                    .toList(),
              );
      },
    );
  }
}
