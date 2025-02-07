package com.yzl.atoshi_key

import android.os.Bundle
import android.util.Log
import com.umeng.commonsdk.UMConfigure
import io.flutter.embedding.android.FlutterFragmentActivity

class MainActivity: FlutterFragmentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        Log.e("QiuF","appKey:63a94a1fba6a5259c4da019f")
        UMConfigure.preInit(this, "63a94a1fba6a5259c4da019f", "atoshi_key")
        UMConfigure.setLogEnabled(true)
//        com.umeng.umeng_common_sdk.UmengCommonSdkPlugin.setContext(this)
        Log.i("UMLog", "onCreate@MainActivity")
    }
}
