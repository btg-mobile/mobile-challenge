package br.com.andreldsr.btgcurrencyconverter.presenter.adapter

import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.TextView
import androidx.recyclerview.widget.RecyclerView
import br.com.andreldsr.btgcurrencyconverter.R
import br.com.andreldsr.btgcurrencyconverter.domain.entities.Currency
import kotlinx.android.synthetic.main.adapter_currency_list_item.view.*


class CurrencyListItemAdapter(
    private val currencyList: List<Currency>
) : RecyclerView.Adapter<CurrencyListItemAdapter.CurrencyViewHolder>() {


    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): CurrencyViewHolder {
        val itemView = LayoutInflater.from(parent.context)
            .inflate(R.layout.adapter_currency_list_item, parent, false)
        return CurrencyViewHolder(itemView)
    }

    override fun onBindViewHolder(holder: CurrencyViewHolder, index: Int) {
        holder.bindView(currencyList[index])
    }

    override fun getItemCount(): Int = currencyList.size

    class CurrencyViewHolder(
        itemView: View
    ) : RecyclerView.ViewHolder(itemView) {
        private val initials = itemView.currency_list_item_initials
        private val name = itemView.currency_list_item_name
        fun bindView(currency: Currency){
            initials.text = currency.initials
            name.text = currency.name
        }
    }
}