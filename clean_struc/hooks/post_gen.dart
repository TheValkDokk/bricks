import 'dart:io';
import 'package:mason/mason.dart';

Future<void> run(HookContext context) async {
  final progress = context.logger.progress('Installing packages');

  // add dio
  await Process.run('flutter', ['pub', 'add', 'dio']);
  // add flutter_dotenv
  await Process.run('flutter', ['pub', 'add', 'flutter_dotenv']);
  // add get_it
  await Process.run('flutter', ['pub', 'add', 'get_it']);
  // add injectable
  await Process.run('flutter', ['pub', 'add', 'injectable']);
  await Process.run('flutter', ['pub', 'add', 'dev:injectable_generator']);
  // add shared_preferences
  await Process.run('flutter', ['pub', 'add', 'shared_preferences']);
  // add nanoid2
  await Process.run('flutter', ['pub', 'add', 'nanoid2']);
  // add freezed
  await Process.run('flutter', ['pub', 'add', 'freezed_annotation']);
  await Process.run('flutter', ['pub', 'add', 'dev:build_runner']);
  await Process.run('flutter', ['pub', 'add', 'dev:freezed']);
  await Process.run('flutter', ['pub', 'add', 'json_annotation']);
  await Process.run('flutter', ['pub', 'add', 'dev:json_serializable']);

  // run code generation
  await Process.run(
    'flutter',
    ['pub', 'run', 'build_runner', 'build', '--delete-conflicting-outputs'],
  );

  progress.complete();
}
