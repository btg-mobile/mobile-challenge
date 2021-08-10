package br.com.alanminusculi.btgchallenge.ui.splash

import android.content.Intent
import android.os.Bundle
import br.com.alanminusculi.btgchallenge.R
import br.com.alanminusculi.btgchallenge.services.CurrencyService
import br.com.alanminusculi.btgchallenge.services.CurrencyValueService
import br.com.alanminusculi.btgchallenge.ui.ActivityBase
import br.com.alanminusculi.btgchallenge.ui.converter.ConverterActivity

class SplashActivity : ActivityBase() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_splash)
        addFlagKeepScreenOn()
        sync()
    }

    private fun sync() {
        Thread {
            try {
                if (isNetworkConnected()) {
                    CurrencyService(applicationContext).sync()
                    CurrencyValueService(applicationContext).sync()
                }
                runOnUiThread { startActivity(Intent(this@SplashActivity, ConverterActivity::class.java)) }
            } catch (exception: Exception) {
                showAlertDialog(
                    getString(R.string.dialog_title_atencao),
                    exception.message
                ) { _, _ -> startActivity(Intent(this@SplashActivity, ConverterActivity::class.java)) }
            }
        }.start()
    }
}