import 'dart:io';

import 'package:web_scraper/web_scraper.dart';

void main() async {
  var webScraper = WebScraper('https://github.com');
  var output = '';

  // add the header
  output += '| Package | Description | Link | Preview |\n';
  output += '| ------- | ----------- | ---- | ------- |\n';
  var pageIndex = 1;
  var lastPageReached = false;
  List elements = [];
  // first retrieve all elements
  while (!lastPageReached) {
    if (await webScraper.loadWebPage(
      '/orgs/Iconica-Development/repositories?page=$pageIndex',
    )) {
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
      var pageLink = 'https://github.com/Iconica-Development/$name';

      // check the master branch to search for .gif files
      if (await webScraper.loadWebPage('/Iconica-Development/$name')) {
        var gifs = <String>[];
        var mp4s = <String>[];
        var descriptionElement = webScraper.getElement('p.f4%20my-3', []);

        // strip leading and ending whitespace from the string
        var description = (descriptionElement.isNotEmpty)
            ? descriptionElement.first['title'].toString().trim()
            : 'No description';
        var fileLinks = webScraper.getElement('a.Link--primary', ['href']);
        for (var fileLink in fileLinks) {
          var href = fileLink['attributes']['href'].toString();
          if (href.endsWith('.gif')) {
            gifs.add('https://github.com$href');
          } else if (href.endsWith('.mp4')) {
            mp4s.add('https://github.com$href');
          }
        }

        await Future.delayed(Duration(milliseconds: 100));
        // look in the readme.md file for a gif or mp4 reference
        if (await webScraper
            .loadWebPage('/Iconica-Development/$name/blob/master/README.md')) {
          var images = webScraper.getElement('img', ['src']);
          for (var element in images) {
            var src = element['attributes']['src'].toString();
            if (src.endsWith('.gif')) {
              gifs.add((src.startsWith('https://'))
                  ? src
                  : 'https://github.com$src');
            }
          }

          var videos = webScraper.getElement('video', ['src']);
          for (var element in videos) {
            var src = element['attributes']['src'].toString();
            if (src.endsWith('.mp4')) {
              mp4s.add((src.startsWith('https://'))
                  ? src
                  : 'https://github.com$src');
            }
          }
        }
        if (gifs.isNotEmpty || mp4s.isNotEmpty) {
          // combine all the links into one string
          var chosenGif =
              gifs.isNotEmpty ? '![Example GIF of package](${gifs.first})' : '';
          var chosenMp4 =
              mp4s.isNotEmpty ? '![Example MP4 of package](${mp4s.first})' : '';
          output +=
              '| $name | $description | [code]($pageLink) | $chosenGif $chosenMp4 |\n ';
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
