import 'package:flutter/material.dart';
import 'package:test_app/core/app_colors.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        extendBodyBehindAppBar: true,
        extendBody: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              ProfileHeader(
                title: "Noushin",
                subtitle: "Flutter Developer",
                actions: <Widget>[
                  MaterialButton(
                    color: AppColors.lightPrimaryColor,
                    shape: CircleBorder(),
                    elevation: 0,
                    child: Icon(Icons.edit),
                    onPressed: () {},
                  )
                ],
              ),
              const SizedBox(height: 10.0),
              UserInfo(),
            ],
          ),
        ));
  }
}

class UserInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(left: 8.0, bottom: 4.0),
            alignment: Alignment.topLeft,
            child: Text(
              "User Information",
              style: TextStyle(
                color: AppColors.darkPrimaryColor,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Card(
            child: Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.all(15),
              child: Column(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      ...ListTile.divideTiles(
                        color: Colors.grey,
                        tiles: [
                          ListTile(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 12, vertical: 4),
                            leading: Icon(
                              Icons.my_location,
                              color: AppColors.darkPrimaryColor,
                            ),
                            title: Text("Location",
                                style: TextStyle(
                                    color: AppColors.darkPrimaryColor)),
                            subtitle: Text("Kathmandu"),
                          ),
                          ListTile(
                            leading: Icon(
                              Icons.email,
                              color: AppColors.darkPrimaryColor,
                            ),
                            title: Text("Email",
                                style: TextStyle(
                                    color: AppColors.darkPrimaryColor)),
                            subtitle: Text("sudeptech@gmail.com"),
                          ),
                          ListTile(
                            leading: Icon(
                              Icons.phone,
                              color: AppColors.darkPrimaryColor,
                            ),
                            title: Text("Phone",
                                style: TextStyle(
                                    color: AppColors.darkPrimaryColor)),
                            subtitle: Text("99--99876-56"),
                          ),
                          ListTile(
                            leading: Icon(
                              Icons.person,
                              color: AppColors.darkPrimaryColor,
                            ),
                            title: Text("About Me",
                                style: TextStyle(
                                    color: AppColors.darkPrimaryColor)),
                            subtitle: Text(
                                "This is a about me link and you can khow about me in this section."),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class ProfileHeader extends StatelessWidget {
  final ImageProvider<dynamic> avatar;
  final String title;
  final String subtitle;
  final List<Widget> actions;

  const ProfileHeader(
      {Key key,
      @required this.avatar,
      @required this.title,
      this.subtitle,
      this.actions})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Ink(
          height: 200,
        ),
        Ink(
          height: 200,
          decoration: BoxDecoration(
            color: AppColors.primaryColor,
          ),
        ),
        if (actions != null)
          Container(
            width: double.infinity,
            height: 200,
            padding: const EdgeInsets.only(bottom: 0.0, right: 0.0),
            alignment: Alignment.bottomRight,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: actions,
            ),
          ),
        Container(
          width: double.infinity,
          margin: const EdgeInsets.only(top: 160),
          child: Column(
            children: <Widget>[
              Avatar(
                image: avatar,
                radius: 40,
                backgroundColor: AppColors.primaryColor,
                borderColor: AppColors.darkPrimaryColor,
                borderWidth: 4.0,
              ),
              Text(
                title,
                style: Theme.of(context).textTheme.title,
              ),
              if (subtitle != null) ...[
                const SizedBox(height: 5.0),
                Text(
                  subtitle,
                  style: Theme.of(context).textTheme.subtitle,
                ),
              ]
            ],
          ),
        )
      ],
    );
  }
}

class Avatar extends StatelessWidget {
  final ImageProvider<dynamic> image;
  final Color borderColor;
  final Color backgroundColor;
  final double radius;
  final double borderWidth;

  const Avatar(
      {Key key,
      @required this.image,
      this.borderColor = AppColors.lightPrimaryColor,
      this.backgroundColor,
      this.radius = 30,
      this.borderWidth = 5})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius + borderWidth,
      backgroundColor: borderColor,
      child: CircleAvatar(
        radius: radius,
        backgroundColor: backgroundColor != null
            ? backgroundColor
            : Theme.of(context).primaryColor,
        child: CircleAvatar(
          radius: radius - borderWidth,
          backgroundImage: image,
        ),
      ),
    );
  }
}
