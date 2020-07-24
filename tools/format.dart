import 'dart:io';

void main(List<String> arguments) async {
  final setExit = arguments.contains("--set-exit-if-changed") ? "--set-exit-if-changed" : "";
  final files = [...Directory("${Directory.current.path}${Platform.pathSeparator}lib").listSync(recursive: true), ...Directory("${Directory.current.path}${Platform.pathSeparator}test").listSync(recursive: true)];
  files.removeWhere((element) => element.path.contains("g.dart"));
  files.removeWhere((element) => element.path.contains("generated"));
  files.removeWhere((element) => element.path.contains("json"));
  files.removeWhere((element) => element.path.contains("arb"));
  print("Checking ${files.length} files");
  const maxLength = 3072;
  final filesInBatch = <String>[];
  var currentLength = 0;

  var exitCode = 0;

  var i = 0;
  for (i; i < files.length; ++i) {
    final filePath = files[i].absolute.path;

    if (currentLength == 0 || (currentLength + filePath.length + 1) <= maxLength) {
      filesInBatch.add(filePath);
      currentLength += filePath.length + 1;
    } else {
      await Process.run('/home/kevin/flutter/bin/flutter', ["format", "-l", "300", ...filesInBatch], runInShell: true).then((value) {
        if (value.stdout.toString().contains("Formatted")) {
          var formatted = value.stdout.toString().split("\n").where((element) => element.contains("Formatted")).toList();
          print(formatted.join("\n"));
          exitCode = 1;
        }
      }).catchError((value) {
        print(value);
      });

      filesInBatch.clear();
      currentLength = 0;
    }
  }

  if (filesInBatch.isNotEmpty) {
    Process.run('/home/kevin/flutter/bin/flutter', ["format", "-l", "300", setExit, ...filesInBatch], runInShell: true).then((value) {
      if (value.stdout.toString().contains("Formatted")) {
        var formatted = value.stdout.toString().split("\n").where((element) => element.contains("Formatted")).toList();
        print(formatted.join("\n"));
        exitCode = 1;
      }
    }).catchError((value) {
      print(value);
    });
  }

  if (exitCode == 1) {
    print("Go and look for formatting errors");
  }
  exit(exitCode);
}
