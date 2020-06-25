import android.app.Activity;
import android.app.Application;
import android.util.Log;
import android.webkit.WebChromeClient;
import android.webkit.WebViewClient;
import android.widget.Toast;

import com.ali.auth.third.core.model.Session;
import com.alibaba.baichuan.android.trade.AlibcTrade;
import com.alibaba.baichuan.android.trade.AlibcTradeSDK;
import com.alibaba.baichuan.android.trade.callback.AlibcTradeCallback;
import com.alibaba.baichuan.android.trade.callback.AlibcTradeInitCallback;
import com.alibaba.baichuan.android.trade.model.AlibcShowParams;
import com.alibaba.baichuan.android.trade.model.OpenType;
import com.alibaba.baichuan.trade.biz.applink.adapter.AlibcFailModeType;
import com.alibaba.baichuan.trade.biz.context.AlibcTradeResult;
import com.alibaba.baichuan.trade.biz.core.taoke.AlibcTaokeParams;
import com.alibaba.baichuan.trade.biz.login.AlibcLogin;
import com.alibaba.baichuan.trade.biz.login.AlibcLoginCallback;
import com.alibaba.baichuan.trade.common.utils.AlibcLogger;
import com.alibaba.fastjson.JSON;


import java.util.HashMap;
import java.util.Map;

import io.flutter.embedding.engine.plugins.activity.ActivityAware;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.PluginRegistry;

public final class AliBaichuanHandle {

    private static AliBaichuanHandle handle;

    private Application application;
    private ActivityPluginBinding binding;
    private Activity activity;


    //第一次调用getInstance register不能为空
    public static AliBaichuanHandle getInstance(Activity activity){
        if (handle == null){
            synchronized (AliBaichuanHandle.class){
                handle = new AliBaichuanHandle();
                handle.activity = activity;
            }
        }
        return handle;
    }

    /**
     * 登录
     *
     * @param call
     * @param result
     */
    public void login(MethodCall call, final MethodChannel.Result result) {
        // String a = call.argument("task_id");
        AlibcLogin alibcLogin = AlibcLogin.getInstance();
        final Map<String, Object> res = new HashMap<>();

        alibcLogin.showLogin(new AlibcLoginCallback() {
            @Override
            public void onSuccess(int i, String userId, String nick) {

                res.put("errorCode", 0);
                res.put("statusMsg", "success");

                Session session = AlibcLogin.getInstance().getSession();
                Map<String, Object> userInfo = new HashMap<>();
                userInfo.put("nick", session.nick);
                userInfo.put("havanaSsoToken", session.havanaSsoToken);
                userInfo.put("ssoToken", session.ssoToken);
                userInfo.put("avatarUrl", session.avatarUrl);
                userInfo.put("openId", session.openId);
                userInfo.put("openSid", session.openSid);
                userInfo.put("topAccessToken", session.topAccessToken);
                userInfo.put("topAuthCode", session.topAuthCode);
                userInfo.put("topExpireTime", session.topExpireTime);
                userInfo.put("userid", session.userid);
                res.put("data", userInfo);
                Log.e("获取登录信息: ", JSON.toJSONString(res));
                result.success(res);


            }

            @Override
            public void onFailure(int code, String s) {
                res.put("errorCode", code);
                res.put("statusMsg", s);

                result.success(res);
            }
        });
    }


    /**
     * 登出
     *
     * @param call
     * @param result
     */
    public void logout(MethodCall call, final MethodChannel.Result result) {
        AlibcLogin alibcLogin = AlibcLogin.getInstance();
        final Map<String, Object> res = new HashMap<>();
        alibcLogin.logout(new AlibcLoginCallback() {
            @Override
            public void onSuccess(int i, String openId, String userNick) {
                res.put("errorCode", 0);
                res.put("statusMsg", "success");
                Map<String, Object> userInfo = new HashMap<>();

                userInfo.put("openId", openId);
                userInfo.put("userNick", userNick);
                res.put("data", userInfo);
                Log.e("获取信息: ", JSON.toJSONString(res));
//                result.success(JSON.toJSONString(res));
                result.success(res);
            }

            @Override
            public void onFailure(int i, String s) {
                res.put("errorCode", i);
                res.put("statusMsg", s);
                result.success(res);
            }
        });
    }

    /**
     * url打开淘宝
     * @param call
     * @param result
     */
    public void openUrl(MethodCall call, final MethodChannel.Result result) {
        AlibcShowParams showParams = new AlibcShowParams();
        showParams.setOpenType(OpenType.Auto);
        showParams.setClientType("taobao");
        showParams.setBackUrl("");
        showParams.setNativeOpenFailedMode(AlibcFailModeType.AlibcNativeFailModeJumpH5);

        AlibcTaokeParams taokeParams = new AlibcTaokeParams("", "", "");
        taokeParams.setPid("mm_112883640_11584347_72287650277");
//        final String url = "https://uland.taobao.com/coupon/edetail?e=oSSExmvWXYYGQASttHIRqdYQwfcs8zoyxKXGKLqne1Hsx8cAhaH1SiZlT35kVCJr5R4kLBbVNWVsYgQTrXiDpq0TeAL%2BmcF17w9v818T2zNzQzL%2FHTq%2BPBemP0hpIIPvjDppvlX%2Bob8NlNJBuapvQ2MDg9t1zp0RRkY43XGTK8ko1aiZVhb9ykMuxoRQ3C%2BH5vl92ZYH25Cie%2FpBy9wBFg%3D%3D&traceId=0b15099215669559409745730e&union_lens=lensId:0b0b9f56_0c4c_16cd5da2c7f_3b31&xId=PwB9ZSWQxCtEwHxtbQc8iynshj5KEW16KP6OV6MAlpGpKCKmVGQMnjwQNhiGQpRY1gFyQHtqnYiv5wxGKTyCdf&tj1=1&tj2=1&relationId=518419440&activityId=23f4487e169647bd98b0d7fb2645947a";
        String url = call.argument("url");
        Map<String, String> trackParams = new HashMap<>();
        // 通过百川内部的webview打开页面
        AlibcTrade.openByUrl(activity, "", url, null,
                new WebViewClient(), new WebChromeClient(),
                showParams, taokeParams, trackParams, new AlibcTradeCallback() {
                    @Override
                    public void onTradeSuccess(AlibcTradeResult tradeResult) {
                        AlibcLogger.i("MainActivity", "request success");
                    }

                    @Override
                    public void onFailure(int code, String msg) {
                        AlibcLogger.e("MainActivity", "code=" + code + ", msg=" + msg);
                        if (code == -1) {
                            Toast.makeText(binding.getActivity(), msg, Toast.LENGTH_SHORT).show();
                        }
                    }
                });
    }


}
