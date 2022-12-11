import 'package:blog/controller/user_controller.dart';
import 'package:blog/core/routers.dart';
import 'package:blog/core/size.dart';
import 'package:blog/domain/device/user_session.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

class HomePage extends ConsumerStatefulWidget {
  @override
  ConsumerState createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  var refreshKey = GlobalKey<RefreshIndicatorState>();
  var scaffodKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    Logger().d("homePage 빌드");
    return Scaffold(
      key: scaffodKey,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (scaffodKey.currentState!.isDrawerOpen) {
            scaffodKey.currentState!.openEndDrawer();
          } else {
            scaffodKey.currentState!.openDrawer();
          }
        },
        child: Icon(Icons.code),
      ),
      drawer: _navigation(context),
      appBar: AppBar(
        title: _buildAppBarTitle(),
      ),
      body: RefreshIndicator(
        key: refreshKey,
        onRefresh: () async {},
        child: ListView.separated(
          itemCount: 5,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {},
              child: ListTile(
                leading: Text("아이디"),
                title: Text("제목"),
              ),
            );
          },
          separatorBuilder: (context, index) {
            return Divider();
          },
        ),
      ),
    );
  }

  Widget _buildAppBarTitle() {
    if (UserSession.isLogin) {
      return Text("로그인한 유저 토큰 : ${UserSession.user!.username}");
    } else {
      return const Text("로그인 되지 않은 상태입니다.");
    }
  }

  Widget _navigation(BuildContext context) {
    return Container(
      width: getDrawerWidth(context),
      height: double.infinity,
      color: Colors.white,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, Routers.writeForm);
                },
                child: Text(
                  "글쓰기",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                  ),
                ),
              ),
              Divider(),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, Routers.userInfo);
                },
                child: Text(
                  "회원정보보기",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                  ),
                ),
              ),
              Divider(),
              TextButton(
                onPressed: () async {
                  Navigator.popAndPushNamed(context, Routers.loginForm);
                  await ref.read(userController).logout();
                },
                child: Text(
                  "로그아웃",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                  ),
                ),
              ),
              Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
