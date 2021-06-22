import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_login/theme.dart';
import 'package:flutter_login/widgets.dart';
import 'package:login_example/forms/form_remittance.dart';
import 'package:login_example/forms/form_wzpdc.dart';
import 'package:login_example/lists/listPalli.dart';
import 'package:login_example/lists/listRemittance.dart';
import 'package:login_example/lists/listwzpdcl.dart';
import 'package:login_example/login_screen.dart';
import 'package:login_example/model/data.dart';
import 'package:login_example/payment_screen.dart';
import 'transition_route_observer.dart';
import 'widgets/fade_in.dart';
import 'constants.dart';
import 'widgets/animated_numeric_text.dart';
import 'widgets/round_button.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:login_example/forms/form_one.dart';

class HistoryScreen extends StatefulWidget {
  static const routeName = '/historyscreen';
  static var data_taken_Paymentscreen;
  static var data_taken = [];
  static var data_takenw = [];
  static var data_takenr = [];
  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen>
    with SingleTickerProviderStateMixin, TransitionRouteAware {
  //var dataValueDashboard = HistoryScreen.data_taken;
  // List<dynamic> dataValueDashboard = HistoryScreen.data_taken.toList();
  var paymentModelList = HistoryScreen.data_taken;

  Future<bool> _goToLogin(BuildContext context) {
    return Navigator.of(context)
        .pushReplacementNamed('/')
        // we dont want to pop the screen, just replace it completely
        .then((_) => false);
  }

  var dataValuePayscreen = PaymentScreen.data_taken_Paymentscreen;
  //var idValue = LoginScreen.id_taken;
  var phoneValue = LoginScreen.mobile_taken;

  final routeObserver = TransitionRouteObserver<PageRoute?>();
  static const headerAniInterval = Interval(.1, .3, curve: Curves.easeOut);
  late Animation<double> _headerScaleAnimation;
  AnimationController? _loadingController;

  @override
  void initState() {
    super.initState();

    _loadingController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1250),
    );

    _headerScaleAnimation =
        Tween<double>(begin: .6, end: 1).animate(CurvedAnimation(
      parent: _loadingController!,
      curve: headerAniInterval,
    ));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(
        this, ModalRoute.of(context) as PageRoute<dynamic>?);
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    _loadingController!.dispose();
    super.dispose();
  }

  @override
  void didPushAfterTransition() => _loadingController!.forward();

//top of app bar part
  AppBar _buildAppBar(ThemeData theme) {
    final menuBtn = IconButton(
      color: theme.accentColor,
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        //Navigator.pop(context,true);
        Navigator.pushReplacementNamed(context, '/dashboard');
      },
    );
    final signOutBtn = IconButton(
      icon: const Icon(FontAwesomeIcons.signOutAlt),
      color: theme.accentColor,
      onPressed: () => _goToLogin(context),
    );

    final title = Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Hero(
              tag: Constants.logoTag,
              child: Image.asset(
                'assets/images/ecorp.png',
                filterQuality: FilterQuality.high,
                height: 30,
              ),
            ),
          ),
          HeroText(
            Constants.appName,
            tag: Constants.titleTag,
            viewState: ViewState.shrunk,
            style: LoginThemeHelper.loginTextStyle,
          ),
          SizedBox(width: 20),
        ],
      ),
    );

    return AppBar(
      leading: FadeIn(
        controller: _loadingController,
        offset: .3,
        curve: headerAniInterval,
        fadeDirection: FadeDirection.startToEnd,
        child: menuBtn,
      ),
      actions: <Widget>[
        FadeIn(
          controller: _loadingController,
          offset: .3,
          curve: headerAniInterval,
          fadeDirection: FadeDirection.endToStart,
          child: signOutBtn,
        ),
      ],
      title: title,
      backgroundColor: theme.primaryColor.withOpacity(.1),
      elevation: 0,
      textTheme: theme.accentTextTheme,
      iconTheme: theme.accentIconTheme,
    );
  }

  Widget _buildButton(
      {Widget? icon, String? label, required Interval interval}) {
    return RoundButton(
      icon: icon,
      label: label,
      loadingController: _loadingController,
      interval: Interval(
        interval.begin,
        interval.end,
        curve: ElasticOutCurve(0.42),
      ),
      onPressed: () async {
        final url =
            Uri.parse(''); //fetch payment
        var data = {
          'phone': phoneValue,
        };

        var res = await http.post(url, body: data);
        print(jsonDecode(res.body));

        dataValuePayscreen = jsonDecode(res.body);

        PaymentScreen.data_taken_Paymentscreen = dataValuePayscreen;

        if (label == 'Palli Biddut') {
          print('phone value; $phoneValue');

          final url =
              Uri.parse(''); //historypalli
          var data = {
            'usermobile': phoneValue,
          };
          var res = await http.post(url, body: data);
          print(jsonEncode(res.body));

          var paymentmodelMap = jsonDecode(res.body);
          
          print('history palli $paymentmodelMap');

          paymentModelList = [];
          for (var element in paymentmodelMap) {
            paymentModelList.add(PaymentModel.fromJson(element));
          }
          //  var paymentmodel = PaymentModel.fromJson(paymentmodelMap);

          // for (var payment in paymentModelList) {
          //   print('Howdy, ${payment.mobile}!');
          // }

          // dataValueDashboard = jsonDecode(res.body);
          //dataValueDashboard = tags;

          HistoryScreen.data_taken = paymentModelList;

          await Navigator.push(
              context, MaterialPageRoute(builder: (context) => ListPalli()));
        }
        if (label == 'WZPDCL') {
          print('phone value; $phoneValue');

          final url =
              Uri.parse(''); //historywzpdcl
          var data = {
            'usermobile': phoneValue,
          };
          var res = await http.post(url, body: data);
          print(jsonEncode(res.body));

          var paymentmodelMap = jsonDecode(res.body);

          paymentModelList = [];
          for (var element in paymentmodelMap) {
            paymentModelList.add(PaymentModel.fromJson(element));
          }
          //  var paymentmodel = PaymentModel.fromJson(paymentmodelMap);

          // for (var payment in paymentModelList) {
          //   print('Howdy, ${payment.mobile}!');
          // }

          // dataValueDashboard = jsonDecode(res.body);
          //dataValueDashboard = tags;

          HistoryScreen.data_taken = paymentModelList;

          await Navigator.push(
              context, MaterialPageRoute(builder: (context) => ListWzpdcl()));
        }
        if (label == 'Remittance') {
          print('phone value; $phoneValue');

          final url = Uri.parse(
              ''); //historyremittance
          var data = {
            'usermobile': phoneValue,
          };
          var res = await http.post(url, body: data);
          print(jsonEncode(res.body));

          var paymentmodelMap = jsonDecode(res.body);

          paymentModelList = [];
          for (var element in paymentmodelMap) {
            paymentModelList.add(PaymentModel.fromJson(element));
          }
          //  var paymentmodel = PaymentModel.fromJson(paymentmodelMap);

          // for (var payment in paymentModelList) {
          //   print('Howdy, ${payment.mobile}!');
          // }

          // dataValueDashboard = jsonDecode(res.body);
          //dataValueDashboard = tags;

          HistoryScreen.data_taken = paymentModelList;

          // Navigator.of(context).pop();
          await Navigator.push(context,
              MaterialPageRoute(builder: (context) => ListRemittance()));
        }
      },
    );
  }

  Widget _buildDashboardGrid() {
    const step = 0.04;
    const aniInterval = 0.75;

    return ListView(
      padding: const EdgeInsets.symmetric(
        horizontal: 32.0,
        vertical: 20,
      ),
      children: <Widget>[
        _buildButton(
          icon: Icon(FontAwesomeIcons.user),
          label: 'Palli Biddut',
          interval: Interval(0, aniInterval),
        ),
        _buildButton(
          icon: Container(
            // fix icon is not centered like others for some reasons
            padding: const EdgeInsets.only(left: 16.0),
            alignment: Alignment.centerLeft,

            child: Icon(
              FontAwesomeIcons.moneyBillAlt,
              size: 20,
            ),
          ),
          label: 'WZPDCL',
          interval: Interval(step, aniInterval + step),
        ),
        _buildButton(
          icon: Icon(FontAwesomeIcons.handHoldingUsd),
          label: 'Remittance',
          interval: Interval(step * 2, aniInterval + step * 2),
        )
        /*_buildButton(
          icon: Icon(FontAwesomeIcons.chartLine),
          label: 'Report',
          interval: Interval(0, aniInterval),
        ),
        _buildButton(
          icon: Icon(Icons.vpn_key),
          label: 'Register',
          interval: Interval(step, aniInterval + step),
        ),
        _buildButton(
          icon: Icon(FontAwesomeIcons.history),
          label: 'History',
          interval: Interval(step * 2, aniInterval + step * 2),
        ),
        _buildButton(
          icon: Icon(FontAwesomeIcons.ellipsisH),
          label: 'Other',
          interval: Interval(0, aniInterval),
        ),
        _buildButton(
          icon: Icon(FontAwesomeIcons.search, size: 20),
          label: 'Search',
          interval: Interval(step, aniInterval + step),
        ),
        _buildButton(
          icon: Icon(FontAwesomeIcons.slidersH, size: 20),
          label: 'Settings',
          interval: Interval(step * 2, aniInterval + step * 2),
        ),*/
      ],
    );
  }

  Widget _buildDebugButtons() {
    const textStyle = TextStyle(fontSize: 12, color: Colors.white);

    return Positioned(
      bottom: 0,
      right: 0,
      child: Row(
        children: <Widget>[
          MaterialButton(
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            color: Colors.red,
            onPressed: () => _loadingController!.value == 0
                ? _loadingController!.forward()
                : _loadingController!.reverse(),
            child: Text('loading', style: textStyle),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return WillPopScope(
      onWillPop: () => _goToLogin(context),
      child: SafeArea(
        child: Scaffold(
          appBar: _buildAppBar(theme),
          body: Container(
            width: double.infinity,
            height: double.infinity,
            color: theme.primaryColor.withOpacity(.1),
            child: Stack(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    SizedBox(height: 140),
                    Expanded(
                      flex: 8,
                      child: ShaderMask(
                        // blendMode: BlendMode.srcOver,
                        shaderCallback: (Rect bounds) {
                          return LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            tileMode: TileMode.clamp,
                            colors: <Color>[
                              Colors.deepPurpleAccent.shade100,
                              Colors.deepPurple.shade100,
                              Colors.deepPurple.shade100,
                              Colors.deepPurple.shade100,
                              // Colors.red,
                              // Colors.yellow,
                            ],
                          ).createShader(bounds);
                        },
                        child: _buildDashboardGrid(),
                      ),
                    ),
                  ],
                ),
                if (!kReleaseMode) _buildDebugButtons(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
