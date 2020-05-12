package com.lucasnav.desafiobtg.modules.currencyConverter.view

import android.app.Activity
import android.content.Intent
import android.os.Bundle
import android.text.Editable
import android.text.TextWatcher
import android.view.WindowManager
import androidx.appcompat.app.AppCompatActivity
import androidx.lifecycle.Observer
import androidx.lifecycle.ViewModelProvider
import com.lucasnav.desafiobtg.R
import com.lucasnav.desafiobtg.modules.currencyConverter.interactor.CurrencyInteractor
import com.lucasnav.desafiobtg.modules.currencyConverter.repository.CurrencyRepository
import com.lucasnav.desafiobtg.modules.currencyConverter.util.CURRENCY_INPUT
import com.lucasnav.desafiobtg.modules.currencyConverter.util.SELECT_I_HAVE_CURRENCY
import com.lucasnav.desafiobtg.modules.currencyConverter.util.SELECT_I_WANT_CURRENCY
import com.lucasnav.desafiobtg.modules.currencyConverter.viewmodel.I_HAVE_FOCUSED
import com.lucasnav.desafiobtg.modules.currencyConverter.viewmodel.I_WANT_FOCUSED
import com.lucasnav.desafiobtg.modules.currencyConverter.viewmodel.QuotesViewmodel
import com.lucasnav.desafiobtg.modules.currencyConverter.viewmodel.QuotesViewmodelFactory
import kotlinx.android.synthetic.main.activity_main.*

class MainActivity : AppCompatActivity() {

    private lateinit var quotesViewmodel: QuotesViewmodel

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        configClicks()

        setupViewmodel()

        subscribeUI()

        configTexts()
    }

    private fun configTexts() {
        editTextIHave.addTextChangedListener(object : TextWatcher {
            override fun afterTextChanged(p0: Editable?) {
            }

            override fun beforeTextChanged(p0: CharSequence?, p1: Int, p2: Int, p3: Int) {
            }

            override fun onTextChanged(textValue: CharSequence?, p1: Int, p2: Int, p3: Int) {
                if (textValue?.isNotEmpty()!!) {
                    if (quotesViewmodel.currentFocused == I_HAVE_FOCUSED) {
                        quotesViewmodel.getQuotesAndCalculateAmount(
                            editTextIHave.text.toString(),
                            buttonCurrencyIHave.text.toString(),
                            buttonCurrencyIWant.text.toString()
                        )
                    }
                }
            }
        })

        editTextIwant.addTextChangedListener(object : TextWatcher {
            override fun afterTextChanged(p0: Editable?) {
            }

            override fun beforeTextChanged(p0: CharSequence?, p1: Int, p2: Int, p3: Int) {
            }

            override fun onTextChanged(textValue: CharSequence?, p1: Int, p2: Int, p3: Int) {
                if (quotesViewmodel.currentFocused == I_WANT_FOCUSED) {
                    if (textValue?.isNotEmpty()!!) {
                        quotesViewmodel.getQuotesAndCalculateAmount(
                            editTextIwant.text.toString(),
                            buttonCurrencyIWant.text.toString(),
                            buttonCurrencyIHave.text.toString()
                        )
                    }
                }
            }
        })

        editTextIHave.setOnFocusChangeListener { _, hasFocus ->
            if (hasFocus) quotesViewmodel.currentFocused = I_HAVE_FOCUSED
        }

        editTextIwant.setOnFocusChangeListener { _, hasFocus ->
            if (hasFocus) quotesViewmodel.currentFocused = I_WANT_FOCUSED
        }
    }

    private fun setupViewmodel() {
        quotesViewmodel = ViewModelProvider(
            this,
            QuotesViewmodelFactory(
                CurrencyInteractor(CurrencyRepository())
            )
        ).get(QuotesViewmodel::class.java)
    }

    private fun subscribeUI() {
        with(quotesViewmodel) {

            onLoadFinished.observe(this@MainActivity, Observer {
            })

            onError.observe(this@MainActivity, Observer { errorMessage ->
                android.widget.Toast.makeText(
                    applicationContext,
                    "Nao foi possivel carregar",
                    android.widget.Toast.LENGTH_SHORT
                )
                    .show()

                android.util.Log.e("GET-QUOTES-ERROR", "error: $errorMessage")
            })

            amount.observe(this@MainActivity, Observer { newAmount ->
                if(quotesViewmodel.currentFocused == I_HAVE_FOCUSED) {
                    editTextIwant.setText(newAmount)
                } else {
                    editTextIHave.setText(newAmount)
                }
            })
        }
    }

    private fun configClicks() {

        buttonCurrencyIWant.setOnClickListener {
            startActivityForResult(
                Intent(this@MainActivity, CurrenciesActivity::class.java),
                SELECT_I_WANT_CURRENCY
            )
        }

        buttonCurrencyIHave.setOnClickListener {
            startActivityForResult(
                Intent(this@MainActivity, CurrenciesActivity::class.java),
                SELECT_I_HAVE_CURRENCY
            )
        }
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)

        when (requestCode) {
            SELECT_I_WANT_CURRENCY -> {
                if (resultCode == Activity.RESULT_OK) {
                    buttonCurrencyIWant.text = data?.getStringExtra(CURRENCY_INPUT)
                }
            }
            SELECT_I_HAVE_CURRENCY -> {
                if (resultCode == Activity.RESULT_OK) {
                    buttonCurrencyIHave.text = data?.getStringExtra(CURRENCY_INPUT)
                }
            }
        }
    }
}
