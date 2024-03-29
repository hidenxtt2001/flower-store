import 'package:flower_store/src/blocs/auth/auth.dart';
import 'package:flower_store/src/blocs/invoice/invoice_bloc.dart';
import 'package:flower_store/src/screens/dashboard/bill/detail_bill_page.dart';
import 'package:flower_store/src/screens/dashboard/bill/widgets/bill_item.dart';
import 'package:flower_store/src/utils/components/error_widget.dart';
import 'package:flower_store/src/utils/components/loading_widget.dart';
import 'package:flower_store/src/utils/themes/app_colors.dart';
import 'package:flower_store/src/utils/themes/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InvoiceTab extends StatefulWidget {
  InvoiceTab({Key? key}) : super(key: key);

  @override
  _InvoiceTabState createState() => _InvoiceTabState();
}

class _InvoiceTabState extends State<InvoiceTab>
    with AutomaticKeepAliveClientMixin<InvoiceTab> {
  @override
  void initState() {
    context.read<InvoiceBloc>().add(InvoiceLoaded());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: RefreshIndicator(
            color: AppColors.color3,
            onRefresh: () async {
              context.read<InvoiceBloc>().add(InvoiceLoaded());
            },
            child: BlocBuilder<InvoiceBloc, InvoiceState>(
              builder: (context, state) {
                if (state is InvoiceLoadedSuccess) {
                  return ListView.separated(
                    physics: const BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics()),
                    itemCount: state.invoices.length,
                    separatorBuilder: (BuildContext context, int index) =>
                        Divider(
                      height: 1.sp,
                    ),
                    itemBuilder: (context, index) {
                      return BillItem(
                        role: (context.read<AuthBloc>().state
                                as AuthenticationAuthenticated)
                            .staff
                            .role,
                        onClick: () {
                          Navigator.pushNamed(context, DetailBillPage.nameRoute,
                              arguments: state.invoices[index]);
                        },
                        onNegative: () {
                          
                        },
                        onPositive: () {
                          
                        },
                        bill: state.invoices[index],
                      );
                    },
                  );
                } else if (state is InvoiceLoading) {
                  return Center(
                    child: LoadingWidget(),
                  );
                } else if (state is InvoiceLoadedFail) {
                  return Center(
                    child: CustomErrorWidget(
                      message: (state).message,
                    ),
                  );
                } else {
                  return Container();
                }
              },
            ),
          ),
        )
      ],
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
