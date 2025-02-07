import 'package:atoshi_key/common/model/feedback_list_model.dart';
import 'package:atoshi_key/common/model/request_params.dart';
import 'package:atoshi_key/common/net/z_net.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class SystemMyFeedbackLogic extends GetxController {
  List<FeedbackInfo> feedbackList = <FeedbackInfo>[].obs;
  final RefreshController refreshController =
      RefreshController(initialRefresh: false);
  int pageNum = 1;

  @override
  void onReady() {
    getFeedbackList();
    super.onReady();
  }

  Future<void> getFeedbackList() async {
    BaseRequest.postResponse(Api.feedbackList,
        RequestParams.queryFeedbackList(pageSize: 10, pageNum: pageNum),
        onSuccess: (entity) {
      FeedbackListInfo info = FeedbackListModel.fromJson(entity).data!;
      if (pageNum == 1) {
        feedbackList.clear();
      }
      if (feedbackList.length < info.total!) {
        var list = FeedbackListModel.fromJson(entity).data?.rows;
        feedbackList.addAll(list as Iterable<FeedbackInfo>);
        if (pageNum == 1) {
          refreshController.refreshCompleted(resetFooterState: true);
        } else {
          refreshController.loadComplete();
        }
      } else {
        refreshController.loadNoData();
      }
    }, onFailed: ((code, msg) {
      refreshController.loadFailed();
    }));
  }

  void onRefresh() async {
    pageNum = 1;
    getFeedbackList();
  }

  void onLoading() {
    pageNum++;
    getFeedbackList();
  }
}
