import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

class GitHubRepository {
  String name;
  DateTime lastUpdated;
  String latestTag;
  String repoUrl;
  bool hasMelosYaml;
  bool hasUserStoryTopic;
  String? exampleUrl;
  String? docsUrl;

  GitHubRepository({
    required this.name,
    required this.lastUpdated,
    required this.latestTag,
    required this.repoUrl,
    this.hasMelosYaml = false,
    this.hasUserStoryTopic = false,
    this.exampleUrl,
    this.docsUrl,
  });

  factory GitHubRepository.fromJson(Map<String, dynamic> json) {
    return GitHubRepository(
      name: json['name'],
      lastUpdated: json['last_updated'],
      latestTag: json['latest_tag'],
      hasMelosYaml: json['has_melos_yaml'],
      hasUserStoryTopic: json['has_user_story_topic'],
      repoUrl: json['repo_url'],
      exampleUrl: json['example_url'],
      docsUrl: json['docs_url'],
    );
  }
}

void main() async {
  var secret = Platform.environment['DOC_PAT_UNLIMITED'] ??
      'fallback_token'; // Replace with your own token
  var output = '';
  var headers = {
    'Authorization': 'token ${secret}',
  };
  bool isEmpty = false;
  int page = 0;
  List<dynamic> repositories = [];
  List<GitHubRepository> githubRepositories = [];

  output +=
      '| Package | Latest Tag | Last Updated | Melos | UserStory | Link | Example | Docs |\n';
  output +=
      '| ------- | ---------- | ------------ | ----- | --------- | ---- | ------- | ---- |\n';

  while (!isEmpty) {
    page++;
    String url =
        'https://api.github.com/orgs/Iconica-Development/repos?type=public&page=$page&per_page=100';
    var response = await http.get(Uri.parse(url), headers: headers);
    if (response.statusCode != 200) {
      print('Error: ${response.statusCode}');
      return;
    }
    if (json.decode(response.body).isEmpty) {
      isEmpty = true;
      break;
    }
    repositories.addAll(json.decode(response.body));
  }

  for (var repo in repositories
      .where((element) => element['name'].toString().startsWith('flutter_'))) {
    String repoName = repo['name'];
    String repoUrl = repo['url'];
    String codeUrl = 'https://github.com/Iconica-Development/$repoName';

    var tagResponse =
        await http.get(Uri.parse('$repoUrl/releases/latest'), headers: headers);
    String latestTag = '';
    if (tagResponse.statusCode == 200) {
      Map<String, dynamic> tagInfo = json.decode(tagResponse.body);
      latestTag = tagInfo['tag_name'];
    }

    var melosYamlResponse = await http
        .get(Uri.parse('$repoUrl/contents/melos.yaml'), headers: headers);
    bool hasMelosYaml = melosYamlResponse.statusCode == 200;

    var topicsResponse =
        await http.get(Uri.parse('$repoUrl/topics'), headers: headers);
    List<dynamic> topics = json.decode(topicsResponse.body)['names'];
    bool hasUserStoryTopic = topics.contains('user-story');

    var exampleResponse = await http.get(Uri.parse('$repoUrl/contents/example'),
        headers: headers);
    String? exampleUrl;
    if (exampleResponse.statusCode == 200) {
      exampleUrl = '$repoUrl/tree/master/example';
    } else {
      var filesResponse =
          await http.get(Uri.parse('$repoUrl/contents'), headers: headers);
      List<dynamic> files = json.decode(filesResponse.body);
      for (var file in files) {
        if (file['name'] == 'example.dart') {
          exampleUrl = file['html_url'];
          break;
        }
      }
    }

    var docsUrl = '';
    docsUrl =
        'https://iconica-development.github.io/iconica_component_documentation/${repoName}/index.html';

    var hasDocs = await http.get(Uri.parse(docsUrl), headers: headers);
    if (hasDocs.statusCode != 200) {
      docsUrl =
          'https://iconica-development.github.io/iconica_component_documentation/Iconica-Development-${repoName}/index.html';

      hasDocs = await http.get(Uri.parse(docsUrl), headers: headers);
    }

    githubRepositories.add(GitHubRepository(
      name: repoName,
      lastUpdated: await DateTime.parse(repo['pushed_at']),
      latestTag: latestTag,
      hasMelosYaml: hasMelosYaml,
      hasUserStoryTopic: hasUserStoryTopic,
      repoUrl: codeUrl,
      exampleUrl: exampleUrl,
      docsUrl: hasDocs.statusCode == 200 ? docsUrl : null,
    ));
  }
  githubRepositories.sort((a, b) => a.name.compareTo(b.name));
  for (var repo in githubRepositories) {
    var melos = repo.hasMelosYaml ? 'Yes' : 'No';
    var userStory = repo.hasUserStoryTopic ? 'Yes' : 'No';
    var exampleUrl =
        repo.exampleUrl != null ? '[example](${repo.exampleUrl})' : '';
    var hasDocs = repo.docsUrl != null ? '[docs](${repo.docsUrl})' : '';
    output +=
        '| ${repo.name} | ${repo.latestTag} | ${repo.lastUpdated.year}-${repo.lastUpdated.month}-${repo.lastUpdated.day} | ${melos} | $userStory | [code](${repo.repoUrl}) | $exampleUrl | $hasDocs |\n';
  }
  print(output);

  var file = File('../profile/README.md');
  var contents = file.readAsStringSync();
  contents = contents
      .split(
          'A list of all the Gifs of the packages can be found [here](./profile/FEATURES.md)')
      .first;
  output = contents +
      'A list of all the Gifs of the packages can be found [here](./profile/FEATURES.md)\n\n' +
      output;

  File('../profile/README.md').writeAsStringSync(output);
}
