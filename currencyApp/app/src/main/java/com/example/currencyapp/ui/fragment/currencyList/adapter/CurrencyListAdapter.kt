package com.example.currencyapp.ui.fragment.currencyList.adapter

import android.view.LayoutInflater
import android.view.ViewGroup
import androidx.recyclerview.widget.RecyclerView
import com.example.currencyapp.database.entity.Currency
import com.example.currencyapp.databinding.ItemCurrencyBinding

class CurrencyListAdapter(private val currencies: List<Currency>) :
        RecyclerView.Adapter<CurrencyListAdapter.CurrencyViewHolder>() {

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): CurrencyViewHolder {
        return CurrencyViewHolder(ItemCurrencyBinding.inflate(LayoutInflater.from(parent.context),
                parent, false))
    }

    override fun onBindViewHolder(holder: CurrencyViewHolder, position: Int) {
        val currency = currencies[position]
        (holder as CurrencyViewHolder).bind(currency)
    }

    override fun getItemCount() = currencies.size

    inner class CurrencyViewHolder(private val binding: ItemCurrencyBinding) :
            RecyclerView.ViewHolder(binding.root) {


        fun bind(item: Currency) {
            binding.apply {
                currency = item
                executePendingBindings()
            }
        }
    }
}