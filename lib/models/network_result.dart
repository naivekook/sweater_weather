class NetworkResult<S, E> {
  final S successValue;
  final E errorValue;

  // ignore: avoid_init_to_null
  NetworkResult({this.successValue = null, this.errorValue = null});

  bool isSuccess() => successValue != null;

  bool isError() => errorValue != null;
}
