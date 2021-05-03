package com.leonardo.convertcoins.adapter

import android.view.View
import android.view.ViewGroup
import android.widget.TextView
import androidx.recyclerview.widget.RecyclerView
import com.leonardo.convertcoins.R
import com.leonardo.convertcoins.config.inflate
import com.leonardo.convertcoins.model.Currency

class CurrencyAdapter(private val currencies: ArrayList<Currency>) : RecyclerView.Adapter<CurrencyAdapter.CurrencyViewHolder>() {
    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): CurrencyViewHolder {
        val inflatedView = parent.inflate(R.layout.currency_recyclerview_item_row, false)
        return CurrencyViewHolder(inflatedView)
    }

    override fun onBindViewHolder(holder: CurrencyViewHolder, position: Int) {
        holder.bindCurrency(currencies[position])
    }

    override fun getItemCount() = currencies.size

    class CurrencyViewHolder(v: View) : RecyclerView.ViewHolder(v), View.OnClickListener {
//        private var view: View = v
        private val coin: TextView = v.findViewById(R.id.recycler_coin)
        private val description: TextView = v.findViewById(R.id.recycler_description)

        init {
            v.setOnClickListener(this)
        }

        override fun onClick(v: View?) {
            println("Recycler view clicked!")
        }

        fun bindCurrency(currency: Currency) {
            this.coin.text = currency.coin
            this.description.text = currency.description
        }

    }
}