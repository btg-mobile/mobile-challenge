package com.example.currencyconverter.presentation.converter

import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.view.View
import android.widget.Button
import android.widget.EditText
import android.widget.TextView
import android.widget.Toast
import com.example.currencyconverter.R
import com.example.currencyconverter.logic.ConverterInteractor
import com.example.currencyconverter.presentation.currencies.CurrenciesActivity

class ConverterActivity : AppCompatActivity(), ConverterView, ErrorTreatmentView {

    private var converterInteractor : ConverterInteractor? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_converter)
        converterInteractor = ConverterInteractor(this as ConverterView, this as ErrorTreatmentView)
    }

    override fun onOriginalCurrencyButtonClick(view: View) {
        converterInteractor?.selectOriginalCurrency()
    }

    override fun onConvertedCurrencyButtonClick(view: View) {
        converterInteractor?.selectTargetCurrency()
    }

    override fun onConvertButtonClick(view: View) {
        converterInteractor?.convert()
    }

    override fun setOriginalCurrencyButtonText() {

    }

    override fun setTargetCurrencyButtonText() {

    }

    override fun setTargetValueText() {

    }

    override fun showCurrencyList() {
        startActivity(Intent(this, CurrenciesActivity::class.java))
    }

    override fun showErrorMessage(message: String) {
        Toast.makeText(this, message, Toast.LENGTH_SHORT).show()
    }
}
