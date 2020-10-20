package com.helano.converter.adapters

import android.view.LayoutInflater
import android.view.ViewGroup
import androidx.databinding.DataBindingUtil
import androidx.recyclerview.widget.RecyclerView
import com.helano.converter.R
import com.helano.converter.databinding.ItemCurrencyBinding
import com.helano.converter.model.Currency

class CurrencyAdapter(
    private var currencies: ArrayList<Currency>
) : RecyclerView.Adapter<CurrencyAdapter.ViewHolder>() {

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ViewHolder {
        return ViewHolder(
            DataBindingUtil.inflate(
                LayoutInflater.from(parent.context),
                R.layout.item_currency,
                parent, false
            )
        )
    }

    override fun getItemCount() = currencies.size

    override fun onBindViewHolder(holder: ViewHolder, position: Int) {
        holder.binding.currency = currencies[position]
    }

    class ViewHolder(var binding: ItemCurrencyBinding) : RecyclerView.ViewHolder(binding.root)
}