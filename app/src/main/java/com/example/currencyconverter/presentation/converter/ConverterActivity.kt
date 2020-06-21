package com.example.currencyconverter.presentation.converter

import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.view.View
import android.widget.Toast
import com.example.currencyconverter.R
import com.example.currencyconverter.infrastructure.CurrencyRepository
import com.example.currencyconverter.infrastructure.getDatabase
import com.example.currencyconverter.infrastructure.isOnline
import com.example.currencyconverter.logic.ConverterInteractor
import com.example.currencyconverter.presentation.currencies.CurrenciesActivity
import io.reactivex.disposables.CompositeDisposable
import kotlinx.android.synthetic.main.activity_converter.*

class ConverterActivity : AppCompatActivity(), ConverterView, ErrorTreatmentView {

    private var converterInteractor : ConverterInteractor? = null
    private var currencyRepository : CurrencyRepository? = null
    private val compositeDisposable = CompositeDisposable()

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_converter)

        //Scene setup and Dependency injection
        val database = getDatabase(application)
        converterInteractor = ConverterInteractor(this as ConverterView, this as ErrorTreatmentView, database, compositeDisposable)
        currencyRepository = CurrencyRepository(database)
    }

    override fun onStart() {
        super.onStart()
        if(isOnline(this)) {
            converterInteractor?.refreshCurrencies()
        }
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)
        converterInteractor?.treatActivityResult(requestCode, resultCode, data)
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

    override fun setOriginalCurrencyButtonText(text: String) {
        originalCurrencyButton.text = text
    }

    override fun setConvertedCurrencyButtonText(text: String) {
        convertedCurrencyButton.text = text
    }

    override fun setConvertedValueText(text : String) {
        convertedValueTextView.text = text
    }

    override fun showCurrencyList(requestCode: Int) {
        startActivityForResult(Intent(this, CurrenciesActivity::class.java), requestCode)
    }

    override fun showErrorMessage(message: String) {
        Toast.makeText(this, message, Toast.LENGTH_SHORT).show()
    }

    override fun onDestroy() {
        compositeDisposable.dispose()
        super.onDestroy()
    }
}
