package com.example.alesefsapps.conversordemoedas.presentation.selectorScreen

import android.support.v7.widget.RecyclerView
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import com.example.alesefsapps.conversordemoedas.R
import com.example.alesefsapps.conversordemoedas.data.model.Values
import kotlinx.android.synthetic.main.currency_item.view.*

class SelectorAdapter(
    //private val currencies: List<Currency>,
    private val currency: List<Values>,
    private val onItemClickListener: ((currency: Values) -> Unit)
) : RecyclerView.Adapter<SelectorAdapter.SelectorViewHolder>() {

    override fun onCreateViewHolder(parent: ViewGroup, view: Int): SelectorViewHolder {
        val itemView = LayoutInflater.from(parent.context).inflate(R.layout.currency_item, parent, false)
        return SelectorViewHolder(itemView, onItemClickListener)
    }

    override fun getItemCount() = currency.count()

    override fun onBindViewHolder(viewHolder: SelectorViewHolder, position: Int) {
        viewHolder.bindView(currency[position])
    }

    class SelectorViewHolder(itemView: View,
                             private val onItemClickListener: ((currency: Values) -> Unit)) : RecyclerView.ViewHolder(itemView) {

        private val code = itemView.label_coin_code
        private val name = itemView.label_coin_name
        private val quote = itemView.label_quote_name

        fun bindView(currency: Values) {
            code.text = currency.code
            name.text = currency.name
            quote.text = currency.value.toString()

            itemView.setOnClickListener {
                onItemClickListener.invoke(currency)
            }
        }
    }
}