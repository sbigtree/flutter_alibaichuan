package com.iyucc.alibaichuan

import android.app.Application

import AliBaichuanHandle
import android.util.Log
import androidx.annotation.NonNull
import com.alibaba.baichuan.android.trade.AlibcTradeSDK
import com.alibaba.baichuan.android.trade.callback.AlibcTradeInitCallback
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.Registrar
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding


/** AlibaichuanPlugin */
public class AlibaichuanPlugin : ActivityAware, FlutterPlugin, MethodCallHandler {

//    private lateinit var handle: AliBaichuanHandle;
//    private lateinit var application: Application;

    init {
        println("0------>>")

//        handle = AliBaichuanHandle();

    }

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        println("1------>>")
        val channel = MethodChannel(flutterPluginBinding.getFlutterEngine().getDartExecutor(), "alibaichuan")
        channel.setMethodCallHandler(AlibaichuanPlugin());


    }

    // This static function is optional and equivalent to onAttachedToEngine. It supports the old
    // pre-Flutter-1.12 Android projects. You are encouraged to continue supporting
    // plugin registration via this function while apps migrate to use the new Android APIs
    // post-flutter-1.12 via https://flutter.dev/go/android-project-migration.
    //
    // It is encouraged to share logic between onAttachedToEngine and registerWith to keep
    // them functionally equivalent. Only one of onAttachedToEngine or registerWith will be called
    // depending on the user's project. onAttachedToEngine or registerWith must both be defined
    // in the same class.
    companion object {
         lateinit var application: Application;
         lateinit var handle: AliBaichuanHandle;


        @JvmStatic
        fun registerWith(registrar: Registrar) {
            println("2------>>")
            handle = AliBaichuanHandle.getInstance(registrar.activity())
            val channel = MethodChannel(registrar.messenger(), "alibaichuan")
            channel.setMethodCallHandler(AlibaichuanPlugin())
        }
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
//        println("插件调用-->>> ${call.method}");
        println("插件调用-->>> ${handle}");
        if (call.method == "getPlatformVersion") {
            result.success("Android ${android.os.Build.VERSION.RELEASE}")
        } else if (call.method == "init") {
            init(call, result);

        } else if (call.method == "login") {
            handle?.login(call, result);

        }else if (call.method == "logout") {
            handle?.logout(call, result);

        }else if (call.method == "openUrl") {
            println("handle----$handle")
            handle?.openUrl(call, result);

        }else {
            result.notImplemented()
        }
    }

    /**
     * 初始化阿里百川
     * @param call
     * @param result
     */
    fun init(call: MethodCall?, result: Result) { //        result.success("初始化成功---");
        Log.e("alibaochuan", "开始初始化")
        println("3------>>")

        AlibcTradeSDK.asyncInit(AlibaichuanPlugin.application, object : AlibcTradeInitCallback {
            override fun onSuccess() {
                Log.e("alibaochuan", "alibichuan初始化成功")
                var resp = hashMapOf("errorCode" to "0","errorMsg" to "success")
                result.success(resp)
            }
            override fun onFailure(code: Int, msg: String) {
                println("alibaochuan--初始化失败--->> code:${code}  msg: ${msg}");
                result.success(hashMapOf("errorCode" to "${code}","errorMsg" to "${msg}"))

//                result.success("alibichuan--->> code:${code} msg: ${msg}");

            }
        })
    }


    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        println("4------>>")

    }

    override fun onDetachedFromActivity() {
        //To change body of created functions use File | Settings | File Templates.
        println("application1-->>$this");
//        println("5------>>")


    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        //To change body of created functions use File | Settings | File Templates.
        println("application2-->>$this");


    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        //To change body of created functions use File | Settings | File Templates.
        application = binding.activity.application;
//        AlibaichuanPlugin.application = binding.activity.application;
        println("application3-->>$this |");
        handle = AliBaichuanHandle.getInstance(binding.activity)



    }

    override fun onDetachedFromActivityForConfigChanges() {
        TODO("not implemented") //To change body of created functions use File | Settings | File Templates.
    }
}
