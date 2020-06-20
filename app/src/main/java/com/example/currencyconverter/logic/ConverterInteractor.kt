package com.example.currencyconverter.logic

import com.example.currencyconverter.presentation.converter.ConverterView
import com.example.currencyconverter.presentation.converter.ErrorTreatmentView

class ConverterInteractor (val converterView : ConverterView,
                           val errorTreatmentView : ErrorTreatmentView) {

    fun selectOriginalCurrency() {
        converterView.showCurrencyList()
    }

    fun selectTargetCurrency() {
        converterView.showCurrencyList()
    }

    fun convert() {
        errorTreatmentView.showErrorMessage("Nao implementado!")
    }
}