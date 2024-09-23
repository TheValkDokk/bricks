T? safe<T>(T? Function() fn, {T? fallback}) {
  try {
    return fn();
  } catch (_) {
    return fallback;
  }
}
