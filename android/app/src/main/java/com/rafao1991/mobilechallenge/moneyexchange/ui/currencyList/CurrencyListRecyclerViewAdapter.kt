package com.rafao1991.mobilechallenge.moneyexchange.ui.currencyList

import androidx.recyclerview.widget.RecyclerView
import android.view.LayoutInflater
import android.view.ViewGroup
import android.widget.TextView

import com.rafao1991.mobilechallenge.moneyexchange.databinding.FragmentCurrencyListBinding
import com.rafao1991.mobilechallenge.moneyexchange.domain.Currency

class CurrencyListRecyclerViewAdapter(
    var values: Map<String, String>,
    private val currency: Currency,
    private val onClickListener: OnClickListener
) : RecyclerView.Adapter<CurrencyListRecyclerViewAdapter.ViewHolder>() {

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ViewHolder {
        return ViewHolder(
            FragmentCurrencyListBinding.inflate(
                LayoutInflater.from(parent.context),
                parent,
                false
            )
        )
    }

    override fun onBindViewHolder(holder: ViewHolder, position: Int) {
        val key = values.keys.toTypedArray()[position]
        if (values.containsKey(key)) {
            values[key]?.let { value ->
                holder.bind(key, value)
                holder.itemView.setOnClickListener {
                    onClickListener.onClick(currency, key)
                }
            }
        }
    }

    override fun getItemCount(): Int = values.size

    class ViewHolder(binding: FragmentCurrencyListBinding) :
        RecyclerView.ViewHolder(binding.root) {
        private val textViewCurrencyKey: TextView = binding.textViewCurrencyKey
        private val textViewCurrencyValue: TextView = binding.textViewCurrencyValue

        fun bind(key: String, value: String) {
            textViewCurrencyKey.text = key
            textViewCurrencyValue.text = value
        }
    }

    class OnClickListener(val clickListener: (currency: Currency, key: String) -> Unit) {
        fun onClick(currency: Currency, key: String) = clickListener(currency, key)
    }
}