package com.btg.converter.presentation.view.currency.list

import android.content.Context
import com.btg.converter.presentation.util.navigation.NavData

class ListCurrenciesNavData : NavData {

    override fun navigate(context: Context) {
        context.startActivity(ListCurrenciesActivity.createIntent(context))
    }
}