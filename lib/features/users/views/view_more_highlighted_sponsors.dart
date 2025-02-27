import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teen_splash/features/admin/admin_bloc/admin_bloc.dart';
import 'package:teen_splash/features/users/views/highlighted_sponsors_details_screen.dart';
import 'package:teen_splash/utils/gaps.dart';
import 'package:teen_splash/widgets/app_bar.dart';

class ViewMoreHighlightedSponsors extends StatefulWidget {
  const ViewMoreHighlightedSponsors({super.key});

  @override
  State<ViewMoreHighlightedSponsors> createState() =>
      _ViewMoreHighlightedSponsorsState();
}

class _ViewMoreHighlightedSponsorsState
    extends State<ViewMoreHighlightedSponsors> {
  late final AdminBloc adminBloc;
  @override
  void initState() {
    adminBloc = context.read<AdminBloc>();
    if (adminBloc.sponsors.isEmpty) {
      adminBloc.add(
        GetSponsors(),
      );
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: AppBarWidget(
          isBackIcon: true,
          isTittle: true,
          title: 'Highlighted Sponsors',
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.only(
                  top: 40,
                  left: 20,
                  right: 20,
                  bottom: 20,
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.25),
                      offset: const Offset(-4, 4),
                      blurRadius: 4,
                    ),
                  ],
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BlocBuilder<AdminBloc, AdminState>(
                        builder: (context, state) {
                          if (state is GettingSponsor) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (state is GetSponsorFailed) {
                            return Center(
                              child: Text(state.message),
                            );
                          }
                          return adminBloc.sponsors.isEmpty
                              ? const Center(
                                  child: Text(
                                    'No sponsors',
                                  ),
                                )
                              : ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: adminBloc.sponsors.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 10.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (
                                                    context,
                                                  ) =>
                                                      HighlightedSponsorDetailsScreen(
                                                    sponsor: adminBloc
                                                        .sponsors[index],
                                                  ),
                                                ),
                                              );
                                            },
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                vertical: 12.0,
                                                horizontal: 12.0,
                                              ),
                                              width: double.infinity,
                                              height: 140,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                  8.0,
                                                ),
                                                image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: NetworkImage(
                                                    adminBloc.sponsors[index]
                                                            .image ??
                                                        '',
                                                  ),
                                                ),
                                              ),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [],
                                              ),
                                            ),
                                          ),
                                          Gaps.hGap05,
                                          Text(
                                            adminBloc.sponsors[index]
                                                    .businessName ??
                                                '',
                                            style: TextStyle(
                                              fontFamily: 'OpenSans',
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .primary,
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
