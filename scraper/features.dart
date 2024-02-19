import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

class GitHubRepository {
  String name;
  String description;
  String link;
  String? gif;
  String? image;
  String? figmaDesign;
  String? figmaPrototype;

  GitHubRepository({
    required this.name,
    required this.description,
    required this.link,
    this.gif,
    this.image,
    this.figmaDesign,
    this.figmaPrototype,
  });
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

  // add the header
  output +=
      '| Package | Description | Link | Gif | Image | Figma Design | Clickable prototype |\n';
  output +=
      '| ------- | ----------- | ---- | --- | ----- | ------------ | ------------------ |\n';

  while (!isEmpty) {
    page++;
    String url =
        'https://api.github.com/orgs/Iconica-Development/repos?page=$page&per_page=100';
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
    String link = repo['html_url'];
    var gifUrl = await _getGifUrlInRepo(repoName, headers);
    var imageUrl = await _getImagePathsInRepo(repoName, headers);
    var description = await _getDescriptionOfRepo(repoName, headers);
    var figmaProtoLink = await _checkFigmaProtoLinkInReadme(repoName, headers);
    var figmaDesignLink = await _checkFigmaLinkInReadme(repoName, headers);

    githubRepositories.add(GitHubRepository(
      name: repoName,
      description: description,
      link: link,
      gif: gifUrl,
      image: imageUrl,
      figmaDesign: figmaDesignLink,
      figmaPrototype: figmaProtoLink,
    ));
  }
  githubRepositories.sort((a, b) => a.name.compareTo(b.name));

  for (var repo in githubRepositories) {
    if (repo.gif == null && repo.image == null) {
      return;
    }
    var gif =
        repo.gif == null ? 'No gif' : '![Example GIF of package](${repo.gif})';
    var image = repo.image == null
        ? 'No image'
        : '![Example Image of package](${repo.image})';
    var figmaDesign = repo.figmaDesign == null
        ? 'No Figma Design'
        : '[Figma Design](${repo.figmaDesign})';
    var figmaPrototype = repo.figmaPrototype == null
        ? 'No Clickable Prototype'
        : '[Clickable Prototype](${repo.figmaPrototype})';

    output +=
        '| ${repo.name} | ${repo.description} | [code](${repo.link}) | $gif | $image | $figmaDesign | $figmaPrototype |\n';
  }

  var file = File('../profile/FEATURES.md');
  var contents = file.readAsStringSync();
  contents = contents.split('List of Flutter Packages').first;
  output = contents + 'List of Flutter Packages\n\n' + output;

  File('../profile/FEATURES.md').writeAsStringSync(output);
}

Future<String?> _getGifUrlInRepo(
    String repoName, Map<String, String> headers) async {
  var apiUrl =
      'https://api.github.com/repos/Iconica-Development/$repoName/contents';
  var response = await http.get(Uri.parse(apiUrl), headers: headers);

  if (response.statusCode == 200) {
    List<dynamic> contents = json.decode(response.body);

    for (var content in contents) {
      var name = content['name'];
      if (name.endsWith('.gif')) {
        return content['html_url'];
      }
    }
  } else {
    print('Failed to load contents of $repoName: ${response.reasonPhrase}');
  }
  return null;
}

Future<String?> _getImagePathsInRepo(
    String repoName, Map<String, String> headers) async {
  var apiUrl =
      'https://api.github.com/repos/Iconica-Development/$repoName/contents';
  var response = await http.get(Uri.parse(apiUrl), headers: headers);
  var imageExtensions = ['.jpg', '.jpeg', '.png', '.svg'];

  if (response.statusCode == 200) {
    List<dynamic> contents = json.decode(response.body);

    for (var content in contents) {
      var name = content['name'];
      if (imageExtensions
          .any((extension) => name.toLowerCase().endsWith(extension))) {
        return content['html_url'];
      }
    }
  } else {
    print('Failed to load contents of $repoName: ${response.reasonPhrase}');
  }
  return null;
}

Future<String> _getDescriptionOfRepo(
    String repoName, Map<String, String> headers) async {
  var apiUrl = 'https://api.github.com/repos/Iconica-Development/$repoName';
  var response = await http.get(Uri.parse(apiUrl), headers: headers);

  if (response.statusCode == 200) {
    var repoDetails = json.decode(response.body);
    return repoDetails['description'] ?? 'No description';
  } else {
    print(
        'Failed to load repository details for $repoName: ${response.reasonPhrase}');
    return 'No description';
  }
}

Future<String?> _checkFigmaProtoLinkInReadme(
    String repoName, Map<String, String> headers) async {
  var apiUrl =
      'https://api.github.com/repos/Iconica-Development/$repoName/contents/README.md';
  var response = await http.get(Uri.parse(apiUrl), headers: headers);

  if (response.statusCode == 200) {
    var readmeDownloadUrl = json.decode(response.body)['download_url'];
    var readme = await http.get(Uri.parse(readmeDownloadUrl), headers: headers);

    var figmaProtoLinkRegex = RegExp(r'https://www\.figma\.com/proto[^)\s]*');
    var matches = figmaProtoLinkRegex.allMatches(readme.body);
    if (matches.isNotEmpty) {
      return matches.first.group(0);
    }
  } else {
    print('Failed to load README.md for $repoName: ${response.reasonPhrase}');
  }
  return null;
}

Future<String?> _checkFigmaLinkInReadme(
    String repoName, Map<String, String> headers) async {
  var apiUrl =
      'https://api.github.com/repos/Iconica-Development/$repoName/contents/README.md';
  var response = await http.get(Uri.parse(apiUrl), headers: headers);

  if (response.statusCode == 200) {
    var readmeDownloadUrl = json.decode(response.body)['download_url'];
    var readme = await http.get(Uri.parse(readmeDownloadUrl), headers: headers);

    var figmaLinkRegex = RegExp(r'https://www\.figma\.com/(?!proto)[^)\s]*');
    var matches = figmaLinkRegex.allMatches(readme.body);
    if (matches.isNotEmpty) {
      return matches.first.group(0);
    }
  } else {
    print('Failed to load README.md for $repoName: ${response.reasonPhrase}');
  }
  return null;
}
