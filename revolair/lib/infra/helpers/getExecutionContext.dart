String getExecutionContext() {
  final stackTrace = StackTrace.current;
  final frames = stackTrace.toString().split('\n');

  if (frames.length > 1) {
    final relevantFrame = frames[1];

    // Extract class and method or function name
    final match = RegExp(r'(#\d+\s+)(\S+)\s+(\S+)').firstMatch(relevantFrame);

    if (match != null && match.groupCount >= 3) {
      final classNameOrFunction =
          match.group(2); // This could be a class name or function name
      final methodName = match
          .group(3); // This would be the method name if it's a class method

      // If there's no method name (it's a function), return the function name
      if (classNameOrFunction != null && methodName != null) {
        return '$classNameOrFunction.$methodName';
      } else {
        return classNameOrFunction ?? 'Unknown function';
      }
    }
  }

  return 'Unknown function';
}
