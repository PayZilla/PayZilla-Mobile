enum Status { idle, loading, success, error }

class ApiResult<T> {
  ApiResult({
    this.message = 'Unknown error occurred',
    this.data,
    this.status,
  });

  ApiResult.idle() : status = Status.idle;
  ApiResult.loading(this.message) : status = Status.loading;
  ApiResult.success(this.data) : status = Status.success;
  ApiResult.error(this.message) : status = Status.error;

  Status? status;
  T? data;
  String message = '';

  bool isInitialState() => !(status == Status.success && data != null);

  @override
  String toString() {
    return 'Status : $status \n Message : $message \n Data : $data';
  }

  bool get isIdle => status == Status.idle;
  bool get isLoading => status == Status.loading;
  bool get isSuccess => status == Status.success;
  bool get isError => status == Status.error;
}
