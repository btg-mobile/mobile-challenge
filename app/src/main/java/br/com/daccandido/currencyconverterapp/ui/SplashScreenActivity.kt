package br.com.daccandido.currencyconverterapp.ui

import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.view.View
import br.com.daccandido.currencyconverterapp.R
import br.com.daccandido.currencyconverterapp.data.repository.CurrencyData
import br.com.daccandido.currencyconverterapp.ui.convertcurrency.ConvertCurresncyActivity
import br.com.daccandido.currencyconverterapp.ui.splashscreen.SplashScreenViewModel
import kotlinx.android.synthetic.main.activity_splash_screen.*
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch

class SplashScreenActivity : AppCompatActivity() {

    private lateinit var viewModel: SplashScreenViewModel

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_splash_screen)

        viewModel = SplashScreenViewModel
            .ViewModelFactory(CurrencyData())
            .create(SplashScreenViewModel::class.java)

        loadingInfo()
    }

    private fun loadingInfo () {

        viewModel.getInfo { error, isSuccess ->
            error?.let {
                progressBar.visibility = View.GONE
                tvError?.text = getString(it)
            } ?: run {
                if (isSuccess) {
                    Intent(this@SplashScreenActivity, ConvertCurresncyActivity::class.java).apply {
                        startActivity(this)
                        finish()
                    }

                }  else {
                    tvError?.text = getString(R.string.error_not_exchange_rates)
                }
            }
        }
    }
}
