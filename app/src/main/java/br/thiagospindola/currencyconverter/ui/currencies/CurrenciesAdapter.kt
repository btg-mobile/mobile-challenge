package br.thiagospindola.currencyconverter.ui.currencies

import android.view.LayoutInflater
import android.view.ViewGroup
import androidx.databinding.DataBindingUtil
import androidx.recyclerview.widget.RecyclerView
import br.thiagospindola.currencyconverter.databinding.CurrenciesItemBinding
import br.thiagospindola.currencyconverter.domain.models.Currency

class CurrenciesAdapter(val clickListener: CurrencyListener)
    : RecyclerView.Adapter<CurrenciesViewHolder>(){

    var currencies: List<Currency> = emptyList()

    set(value){
        field = value
        notifyDataSetChanged()
    }
    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): CurrenciesViewHolder {
        val withDataBinding: CurrenciesItemBinding = DataBindingUtil.inflate(
            LayoutInflater.from(parent.context),
            CurrenciesViewHolder.LAYOUT,
            parent,
            false
        )
        return CurrenciesViewHolder(withDataBinding)
    }

    override fun getItemCount(): Int {
        return currencies.size
    }

    override fun onBindViewHolder(holder: CurrenciesViewHolder, position: Int) {
        holder.viewBinding.also{
            it.currency = currencies[position]
            it.clickListener = clickListener
        }
    }
}

class CurrencyListener(val clickListener: (currency: Currency) -> Unit){
    fun onClick(currency:Currency) = clickListener(currency)
}