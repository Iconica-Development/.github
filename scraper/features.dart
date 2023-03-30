import 'dart:io';

import 'package:web_scraper/web_scraper.dart';

void main() async {
  final webScraper = WebScraper('https://github.com');
  var output = '';

  // add the header
  output += '| Package | Link | Preview |\n';
  output += '| ------- | ---- | ------- |\n';
  var pageIndex = 1;
  var lastPageReached = false;
  List elements = [];
  // first retrieve all elements
  while (!lastPageReached) {
    if (await webScraper.loadWebPage(
        '/orgs/Iconica-Development/repositories?page=$pageIndex')) {
      // add all web elements to the list
      elements += webScraper.getElement('a.d-inline-block', ['href']);
      // check if this is the last page
      if (webScraper.getElement('a.next_page', ['href']).isEmpty) {
        lastPageReached = true;
      } else {
        pageIndex++;
      }
    }
  }
  // sort the elements by name
  elements.sort((a, b) => a['attributes']['href'] == b['attributes']['href']
      ? 0
      : a['attributes']['href']
          .toString()
          .compareTo(b['attributes']['href'].toString()));

  for (var element in elements) {
    var name = element['attributes']['href']
        .toString()
        .split('/Iconica-Development/')
        .last;
    if (name.startsWith('flutter_')) {
      await Future.delayed(Duration(milliseconds: 200));
      // check the master branch to search for .gif files
      if (await webScraper.loadWebPage('/Iconica-Development/$name')) {
        var elements = webScraper.getElement('a.Link--primary', ['href']);
        var gifName = '';
        for (var element in elements) {
          var link = 'https://github.com/Iconica-Development/$name';
          var href = element['attributes']['href'].toString();
          if (href.endsWith('.gif')) {
            gifName = href;
            output +=
                '| $name | [code]($link) | ![Example GIF of package](https://github.com$gifName) |\n';
            break;
          }
        }
      }
    }
  }
  print(output);

  var file = File('../profile/FEATURES.md');
  var contents = file.readAsStringSync();
  contents = contents.split('List of Flutter Packages').first;
  output = contents + 'List of Flutter Packages\n\n' + output;

  File('../profile/FEATURES.md').writeAsStringSync(output);
}
