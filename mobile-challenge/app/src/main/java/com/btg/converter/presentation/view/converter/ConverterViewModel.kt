package com.btg.converter.presentation.view.converter

import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import com.btg.converter.domain.entity.currency.Currency
import com.btg.converter.domain.entity.quote.CurrentQuotes
import com.btg.converter.domain.interactor.GetCurrentQuotes
import com.btg.converter.domain.interactor.PerformConversion
import com.btg.converter.domain.util.form.ConversionForm
import com.btg.converter.presentation.util.base.BaseViewModel

class ConverterViewModel constructor(
    private val getCurrentQuotes: GetCurrentQuotes,
    private val performConversion: PerformConversion
) : BaseViewModel() {

    val conversionPair: LiveData<Pair<Currency?, Double>> get() = _conversionPair

    private val _conversionPair by lazy { MutableLiveData<Pair<Currency?, Double>>() }

    private var currentQuotes: CurrentQuotes? = null
    val conversionForm = ConversionForm()

    init {
        getCurrentQuotes()
    }

    fun performConversion() {
        if (conversionForm.isCurrenciesEmpty()) showEmptyCurrenciesDialog()
        else {
            currentQuotes?.let {
                val convertedValue = performConversion.execute(conversionForm, it)
                checkConversionResult(convertedValue)
            }
        }
    }

    fun setConversionValue(conversionValue: String) {
        conversionForm.conversionValue = conversionValue.toDoubleOrNull()
    }

    private fun checkConversionResult(convertedValue: Double?) {
        if (convertedValue == null) {

        } else {
            _conversionPair.value = conversionForm.destinationCurrency to convertedValue
        }
    }

    private fun showEmptyCurrenciesDialog() {

    }

    private fun getCurrentQuotes() {
        launchDataLoad { currentQuotes = getCurrentQuotes.execute() }
    }
}