import 'package:aros_staff/config/routes/router_names.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/di/service_locator.dart';
import '../../../auth/data/data_sources/local/auth_local_data_source.dart';
import '../../domain/usecases/get_support_usecase.dart';
import '../bloc/setting_bloc.dart';
import '../widgets/custom_setting_card.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen>
    with AutomaticKeepAliveClientMixin {
  late SettingBloc bloc;
  @override
  void didChangeDependencies() {
    bloc = SettingBloc(sl<GetSupportInfo>());
    bloc.add(FetchSupportInfo());
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    print('SettingScreen');
    return BlocProvider(
      create: (context) => bloc,
      child: Builder(builder: (context) {
        return Container(
          color: Colors.white,
          child: ListView(
            children: [
              CustomSettingCard(
                  onTap: () => context.push(AppRoutesName.language),
                  leadingIcon: Icons.language,
                  title: "Language",
                  trialingIcon: Icon(Icons.arrow_forward_ios_outlined)),
              CustomSettingCard(
                  onTap: () => context.push(AppRoutesName.support,
                      extra: context.read<SettingBloc>().state.supportInfo),
                  leadingIcon: Icons.help_outline_outlined,
                  title: "Help & Support",
                  trialingIcon: Icon(Icons.arrow_forward_ios_outlined)),
              CustomSettingCard(
                  leadingIcon: Icons.privacy_tip_outlined,
                  title: "Privacy Policy",
                  trialingIcon: Icon(Icons.arrow_forward_ios_outlined)),
              CustomSettingCard(
                  onTap: () {
                    print(context.read<SettingBloc>().state.supportInfo);
                  },
                  leadingIcon: Icons.light_mode,
                  title: "System theme",
                  trialingIcon: CupertinoSwitch(
                      activeTrackColor: Colors.black,
                      value: false,
                      onChanged: (value) {})),
              CustomSettingCard(
                  onTap:(){onTap(context);} ,

                  leadingIcon: Icons.logout,
                  title: "Log out",
                  trialingIcon: Icon(Icons.arrow_forward_ios_outlined)),
            ],
          ),
        );
      }),
    );
  }

  void onTap(BuildContext context) async {
    bool? confirmLogout = await showCupertinoDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: const Text(
            'Log Out',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w600,
            ),
          ),
          content: const Padding(
            padding: EdgeInsets.only(top: 8.0),
            child: Text(
              'Are you sure you want to log out of your account?',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          actions: [
            CupertinoDialogAction(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text(
                'Cancel',
                style: TextStyle(
                  color: CupertinoColors.systemBlue,
                  fontSize: 17,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            CupertinoDialogAction(
              isDestructiveAction: true,
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text(
                'Log Out',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        );
      },
    );

    if (confirmLogout == true && context.mounted) {
      await sl<AuthUserLocalDataSource>().deleteUserInfo();
      if(context.mounted) context.go(AppRoutesName.signIn);
    }
  }

  @override
  bool get wantKeepAlive => true;
  }





