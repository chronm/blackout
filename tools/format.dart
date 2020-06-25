import 'dart:io';

void main(List<String> arguments) async {
  final setExit = arguments.contains("--set-exit-if-changed") ? "--set-exit-if-changed" : "";
  final files = [...Directory("${Directory.current.path}/lib").listSync(recursive: true), ...Directory("${Directory.current.path}/test").listSync(recursive: true)];
  files.removeWhere((element) => element.path.contains("g.dart"));
  files.removeWhere((element) => element.path.contains("generated"));
  print("Checking ${files.length} files");
  const maxLength = 3072;
  final filesInBatch = <String>[];
  var currentLength = 0;

  var exitCode = 0;

  var processes = <Future>[];

  var i = 0;
  for (i; i < files.length; ++i) {
    final filePath = files[i].absolute.path;

    if (currentLength == 0 || (currentLength + filePath.length + 1) <= maxLength) {
      filesInBatch.add(filePath);
      currentLength += filePath.length + 1;
    } else {
      processes.add(Process.run('flutter', ["format", "-l", "300", setExit, ...filesInBatch]).then((value) {
        if (value.stdout.toString().contains("Formatted")) {
          exitCode = 1;
        }
      }));

      filesInBatch.clear();
      currentLength = 0;
    }
  }

  if (filesInBatch.isNotEmpty) {
    processes.add(Process.run('flutter', ["format", "-l", "300", setExit, ...filesInBatch]).then((value) {
      if (value.stdout.toString().contains("Formatted")) {
        exitCode = 1;
      }
    }));
  }

  await Future.wait(processes);

  if (exitCode == 1) {
    print("Go and look for formatting errors");
  }
  exit(exitCode);
}
