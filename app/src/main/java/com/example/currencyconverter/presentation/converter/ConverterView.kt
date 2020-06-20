package com.example.currencyconverter.presentation.converter

import android.view.View

interface ConverterView {

    fun onOriginalCurrencyButtonClick(view : View)

    fun onConvertedCurrencyButtonClick(view: View)

    fun onConvertButtonClick(view: View)

    fun setOriginalCurrencyButtonText()

    fun setTargetCurrencyButtonText()

    fun setTargetValueText()

    fun showCurrencyList()

}