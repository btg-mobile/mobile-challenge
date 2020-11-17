package com.br.mpc.desafiobtg.adapter

import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.TextView
import androidx.recyclerview.widget.RecyclerView
import com.br.mpc.desafiobtg.R

class CurrenciesAdapter(private val onClick: (currency: Pair<String, String>) -> Unit) : RecyclerView.Adapter<CurrenciesAdapter.CurrenciesViewHolder>() {
    private var currencies: ArrayList<Pair<String, String>> = arrayListOf()

    fun updateList(data: List<Pair<String, String>>) {
        currencies.clear()
        currencies.addAll(data)
        notifyDataSetChanged()
    }

    override fun onCreateViewHolder(parent: ViewGroup, p1: Int): CurrenciesViewHolder {
        val view = LayoutInflater.from(parent.context).inflate(R.layout.layout_currency_item, parent, false)
        return CurrenciesViewHolder(view)
    }

    override fun onBindViewHolder(viewHolder: CurrenciesViewHolder, position: Int) {
        viewHolder.bindView(currencies[position], onClick)
    }

    override fun getItemCount() = currencies.size

    class CurrenciesViewHolder(itemView: View): RecyclerView.ViewHolder(itemView) {
        fun bindView(currency: Pair<String, String>, onClick: (currency: Pair<String, String>) -> Unit){
            itemView.setOnClickListener { onClick(currency) }
            itemView.findViewById<TextView>(R.id.currencyInitialsTextView).text = currency.first
            itemView.findViewById<TextView>(R.id.currencyDescriptionTextView).text = currency.second
        }
    }
}