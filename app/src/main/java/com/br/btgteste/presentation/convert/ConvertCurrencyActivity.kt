package com.br.btgteste.presentation.convert

import android.annotation.SuppressLint
import android.app.Activity
import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.view.View
import android.widget.Button
import android.widget.EditText
import android.widget.ProgressBar
import android.widget.TextView
import androidx.constraintlayout.widget.Group
import androidx.lifecycle.Observer
import com.br.btgteste.R
import com.br.btgteste.domain.model.ApiResult
import com.br.btgteste.domain.model.Currency
import com.br.btgteste.infrastructure.isVisible
import com.br.btgteste.infrastructure.setAllOnClickListener
import com.br.btgteste.presentation.list.ListCurrencyActivity
import org.koin.android.viewmodel.ext.android.viewModel

class ConvertCurrencyActivity : AppCompatActivity() {

    private val btnConvert: Button by lazy { findViewById<Button>(R.id.btnConvert) }
    private val groupFrom: Group by lazy { findViewById<Group>(R.id.groupFrom) }
    private val groupTo: Group by lazy { findViewById<Group>(R.id.groupTo) }
    private val tvCurrencyFrom: TextView by lazy { findViewById<TextView>(R.id.tvCurrencyFrom) }
    private val tvCurrencyTo: TextView by lazy { findViewById<TextView>(R.id.tvCurrencyTo) }
    private val tvFromResult: TextView by lazy { findViewById<TextView>(R.id.tvFromResult) }
    private val tvToResult: TextView by lazy { findViewById<TextView>(R.id.tvToResult) }
    private val edtCurrencyValue: EditText by lazy { findViewById<EditText>(R.id.edtCurrencyValue) }
    private val pbList: ProgressBar by lazy { findViewById<ProgressBar>(R.id.pbList) }

    private val viewModel: ConvertCurrencyViewModel by viewModel()

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)
        setupViews()
        observeLiveResponse()
    }

    private fun observeLiveResponse() {
        viewModel.liveDataResponse.observe(this, Observer {
            pbList.isVisible(false)
            if (it is ApiResult.Success) {
                fillResultText(it.data)
            } else if (it is ApiResult.Error) {

            }
        })
    }

    @SuppressLint("SetTextI18n")
    private fun fillResultText(data: Double) {
        tvFromResult.text = "${edtCurrencyValue.text} ${viewModel.currencyFrom.value?.code} ="
        tvToResult.text = "$data ${viewModel.currencyTo.value?.code}"
    }

    private fun setupViews() {
        groupFrom.setAllOnClickListener(View.OnClickListener {
            startCurrencyActivity(REQUEST_CODE_FROM)
        })

        groupTo.setAllOnClickListener(View.OnClickListener {
            startCurrencyActivity(REQUEST_CODE_TO)
        })

        btnConvert.setOnClickListener {
            pbList.isVisible(true)
            val amount = edtCurrencyValue.text.toString().toDouble()
            viewModel.convertCurrencyAmount(amount)
        }
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)
        if (Activity.RESULT_OK == resultCode){
            val currency: Currency? = data?.extras?.getParcelable(ListCurrencyActivity.CURRENCY)
            currency?.let {
                when(requestCode){
                    REQUEST_CODE_FROM -> {
                        viewModel.currencyFrom.postValue(it)
                        updateCurrency(true, it)
                    }
                    REQUEST_CODE_TO -> {
                        viewModel.currencyTo.postValue(it)
                        updateCurrency(false, it)
                    }
                }
            }
        }

    }

    private fun cleanResults() {
        tvFromResult.text = ""
        tvToResult.text = ""
    }

    @SuppressLint("SetTextI18n")
    private fun updateCurrency(isFrom: Boolean, currency: Currency) {
        cleanResults()
        if (isFrom) { tvCurrencyFrom.text = "${currency.code} ${currency.name}" }
        else { tvCurrencyTo.text = "${currency.code} ${currency.name}" }
    }

    private fun startCurrencyActivity(requestCode: Int) {
        startActivityForResult(Intent(this, ListCurrencyActivity::class.java), requestCode)
    }

    companion object {
        const val REQUEST_CODE_FROM = 551
        const val REQUEST_CODE_TO = 552
    }
}
