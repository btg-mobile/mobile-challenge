package br.com.alanminusculi.btgchallenge.ui.converter

import android.content.Intent
import android.os.Bundle
import androidx.databinding.DataBindingUtil
import br.com.alanminusculi.btgchallenge.R
import br.com.alanminusculi.btgchallenge.data.local.models.Currency
import br.com.alanminusculi.btgchallenge.data.local.models.CurrencyValue
import br.com.alanminusculi.btgchallenge.databinding.ActivityConverterBinding
import br.com.alanminusculi.btgchallenge.services.CurrencyService
import br.com.alanminusculi.btgchallenge.services.CurrencyValueService
import br.com.alanminusculi.btgchallenge.ui.ActivityBase
import br.com.alanminusculi.btgchallenge.ui.currencies.CurrenciesListActivity
import br.com.alanminusculi.btgchallenge.utils.Constants.Companion.USD_PREFIX

class ConverterActivity : ActivityBase() {

    private var binding: ActivityConverterBinding? = null
    private val sourceRequest = 1
    private val destinationRequest = 2

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = DataBindingUtil.setContentView(this, R.layout.activity_converter)
        binding!!.btnSource.setOnClickListener { startActivityForResult(Intent(this@ConverterActivity, CurrenciesListActivity::class.java), sourceRequest) }
        binding!!.btnDestination.setOnClickListener { startActivityForResult(Intent(this@ConverterActivity, CurrenciesListActivity::class.java), destinationRequest) }

        Thread {
            val usdCurrency: Currency = CurrencyService(applicationContext).findOne(USD_PREFIX)
            val usdPrice: CurrencyValue = CurrencyValueService(applicationContext).findOne(usdCurrency.acronym)
            binding!!.viewModel = ConverterViewModel(usdCurrency, usdPrice)
        }.start()
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)
        if (resultCode == RESULT_OK && data != null) {
            Thread {
                val currency = data.getSerializableExtra(Currency::class.java.name) as Currency
                val price: CurrencyValue = CurrencyValueService(applicationContext).findOne(currency.acronym)
                runOnUiThread {
                    if (requestCode == sourceRequest) {
                        binding!!.viewModel!!.setSource(currency, price)
                    } else if (requestCode == destinationRequest) {
                        binding!!.viewModel!!.setDestination(currency, price)
                    }
                }
            }.start()
        }
    }
}