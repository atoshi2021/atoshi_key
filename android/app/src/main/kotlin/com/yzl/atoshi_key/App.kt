package com.yzl.atoshi_key

import android.app.Application
import android.util.Log
import com.umeng.commonsdk.UMConfigure

class App : Application() {
    var appKey = "63a94a1fba6a5259c4da019f"
    override fun onCreate() {
        super.onCreate()
        //设置LOG开关，默认为false
        //设置LOG开关，默认为false
        Log.e("QiuF", "appKey:63a94a1fba6a5259c4da019f")
        UMConfigure.preInit(this, "63a94a1fba6a5259c4da019f", "atoshi_key")
        UMConfigure.setLogEnabled(true)
        UMConfigure.init(this, appKey, "atoshi_key", UMConfigure.DEVICE_TYPE_PHONE, "")

        //友盟预初始化
        /**
         * 打开app首次隐私协议授权，以及sdk初始化，判断逻辑请查看SplashTestActivity
         */
        //判断是否同意隐私协议，uminit为1时为已经同意，直接初始化umsdk
        /**
         * 打开app首次隐私协议授权，以及sdk初始化，判断逻辑请查看SplashTestActivity
         */
        //判断是否同意隐私协议，uminit为1时为已经同意，直接初始化umsdk
//        UMConfigure.init(
//            applicationContext,
//            "63a94a1fba6a5259c4da019f",
//            "atoshi_key",
//            UMConfigure.DEVICE_TYPE_PHONE,""
//        )
//
    }
}