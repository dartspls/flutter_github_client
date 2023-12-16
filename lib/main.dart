import 'package:flutter/material.dart';
import 'github_oauth_credentials.dart';
import 'src/github_login.dart';
import 'package:github/github.dart';
import 'src/github_summary.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GitHub Client',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        useMaterial3: false,
      ),
      home: const MyHomePage(title: 'GitHub Client'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return GithubLoginWidget(
        githubClientId: githubClientId,
        githubClientSecret: githubClientSecret,
        githubScopes: githubScopes,
        builder: (context, httpClient) {
          return Scaffold(
            appBar: AppBar(
              title: Text(title),
              elevation: 2,
            ),
            body: GitHubSummary(
                gitHub: _getGithub(httpClient.credentials.accessToken)),
          );
        });
  }
}

GitHub _getGithub(String accessToken) {
  return GitHub(auth: Authentication.withToken(accessToken));
}
