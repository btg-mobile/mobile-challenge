package br.thiagospindola.currencyconverter.ui.currencies

import androidx.annotation.LayoutRes
import androidx.recyclerview.widget.RecyclerView
import br.thiagospindola.currencyconverter.R
import br.thiagospindola.currencyconverter.databinding.CurrenciesItemBinding

class CurrenciesViewHolder(val viewBinding: CurrenciesItemBinding)
    : RecyclerView.ViewHolder(viewBinding.root){

    companion object {
        @LayoutRes
        val LAYOUT = R.layout.currencies_item
    }
}