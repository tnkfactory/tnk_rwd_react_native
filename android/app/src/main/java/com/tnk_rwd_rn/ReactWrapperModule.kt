package com.tnk_rwd_rn

import android.util.Log
import android.widget.Toast
import androidx.fragment.app.FragmentActivity
import com.facebook.react.ReactActivity
import com.facebook.react.bridge.ReactApplicationContext
import com.facebook.react.bridge.ReactContextBaseJavaModule
import com.facebook.react.bridge.ReactMethod
import com.tnkfactory.ad.TnkOfferwall
import com.tnkfactory.ad.TnkSession

class ReactWrapperModule internal constructor(private val reactContext: ReactApplicationContext) :
    ReactContextBaseJavaModule(reactContext) {

    private val offerwall: TnkOfferwall
        get() = TnkOfferwall(currentActivity as FragmentActivity)

    override fun getName(): String {
        return "ReactWrapperModule"
    }

    @ReactMethod
    fun showToast(message: String, number: Int) {
        Toast.makeText(reactContext, "MSG: $message / $number", Toast.LENGTH_SHORT).show()
    }

    @ReactMethod
    fun setUserName(userName: String) {
        offerwall.setUserName(userName)
    }

    @ReactMethod
    fun setCoppa(coppa: Int) {
        if (coppa == 0) {
            offerwall.setCOPPA(false)
        } else {
            offerwall.setCOPPA(true)
        }
    }

    @ReactMethod
    fun showAttPopup() {
        Log.d("tnk_ad", "need only ios")
    }
    @ReactMethod
    fun showOfferwallWithAtt() {
        showOfferwall()
    }

    @ReactMethod
    fun showOfferwall() {
        TnkSession.runOnMainThread {
            offerwall.startOfferwallActivity(reactContext.currentActivity as ReactActivity)
        }
    }
}
