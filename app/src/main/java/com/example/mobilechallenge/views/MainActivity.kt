package com.example.mobilechallenge.views

import android.app.Activity
import android.content.Intent
import android.os.Bundle
import android.view.inputmethod.EditorInfo
import android.widget.Toast
import androidx.appcompat.app.AppCompatActivity
import com.example.mobilechallenge.R
import com.example.mobilechallenge.models.CurrenciesResponse
import com.example.mobilechallenge.services.RetrofitInitializer
import com.example.mobilechallenge.utils.Constants
import kotlinx.android.synthetic.main.activity_main.*
import retrofit2.Call
import retrofit2.Callback
import retrofit2.Response

class MainActivity : AppCompatActivity() {

    private var mCurrencyRate = ArrayList<Float>()

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        setListeners()
        getCurrencyRate(getString(R.string.usd))
        getCurrencyRate(getString(R.string.brl))
    }

    private fun setListeners() {
        btn_from_currency.setOnClickListener {
            startActivityForResult(Intent(this@MainActivity, CoinsListActivity::class.java), Constants.FROM_CURRENCY)
        }

        btn_to_currency.setOnClickListener {
            startActivityForResult(Intent(this@MainActivity, CoinsListActivity::class.java), Constants.TO_CURRENCY)
        }

        tiet_from_currency.setOnEditorActionListener { _, actionId, _ ->
            return@setOnEditorActionListener when (actionId) {
                EditorInfo.IME_ACTION_DONE -> {
                    convertCurrency()
                    true
                }
                else -> false
            }
        }
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        when (requestCode) {
            Constants.FROM_CURRENCY -> {
                if (resultCode == Activity.RESULT_OK) {
                    val coinCode = data?.getStringExtra(Constants.COIN_CODE_EXTRA)
                    btn_from_currency.text = coinCode
                    til_from_currency.hint = coinCode
                    getCurrencyRate(coinCode!!)
                } else {
                    btn_from_currency.text = getString(R.string.usd)
                    til_from_currency.hint = getString(R.string.usd)
                }
            }
            Constants.TO_CURRENCY -> {
                if (resultCode == Activity.RESULT_OK) {
                    val coinCode = data?.getStringExtra(Constants.COIN_CODE_EXTRA)
                    btn_to_currency.text = coinCode
                    til_to_currency.hint = coinCode
                    getCurrencyRate(coinCode!!)
                } else {
                    btn_to_currency.text = getString(R.string.brl)
                    til_to_currency.hint = getString(R.string.brl)
                }
            }
            else -> {
                super.onActivityResult(requestCode, resultCode, data)
            }
        }
    }

    private fun getCurrencyRate(currency: String) {
        val service = RetrofitInitializer().getRemoteServices()
        val call = service.convert(
            Constants.ACCESS_KEY,
            currency
        )

        call.enqueue(object : Callback<CurrenciesResponse> {
            override fun onFailure(call: Call<CurrenciesResponse>, t: Throwable) {
                Toast.makeText(this@MainActivity, "Conversão falhou!", Toast.LENGTH_SHORT).show()
            }

            override fun onResponse(
                call: Call<CurrenciesResponse>,
                response: Response<CurrenciesResponse>
            ) {
                if (response.isSuccessful) {
                    response.body()?.let {
                        for (key in it.quotes?.keys!!) {
                            mCurrencyRate.add(it.quotes!![key]!!)
                        }
                    }
                }
            }

        })
    }

    private fun convertCurrency() {
        val valueToConvert = tiet_from_currency.text.toString().toFloat()
        val dollarConversion = getDollarConversion(valueToConvert)
        val convertedValue = dollarConversion * mCurrencyRate[1]

        tiet_to_currency.setText(convertedValue.toString())
    }

    private fun getDollarConversion(valueToConvert: Float): Float {
        return valueToConvert / mCurrencyRate[0]
    }
}
