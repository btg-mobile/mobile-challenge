package com.rafao1991.mobilechallenge.moneyexchange.ui.currencyList

import android.annotation.SuppressLint
import androidx.recyclerview.widget.RecyclerView
import android.view.LayoutInflater
import android.view.ViewGroup
import android.widget.Filter
import android.widget.TextView

import com.rafao1991.mobilechallenge.moneyexchange.databinding.FragmentCurrencyListBinding
import com.rafao1991.mobilechallenge.moneyexchange.util.Currency
import java.util.*
import kotlin.collections.HashMap

class CurrencyListRecyclerViewAdapter(
    private val values: Map<String, String>,
    ascending: Boolean,
    private val currency: Currency,
    private val onClickListener: OnClickListener
) : RecyclerView.Adapter<CurrencyListRecyclerViewAdapter.ViewHolder>() {

    var initialList = if (ascending) {
        values.toSortedMap()
    } else {
        values.toSortedMap(reverseOrder())
    }

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
        val key = initialList.keys.toTypedArray()[position]
        if (initialList.containsKey(key)) {
            initialList[key]?.let { value ->
                holder.bind(key, value)
                holder.itemView.setOnClickListener {
                    onClickListener.onClick(currency, key)
                }
            }
        }
    }

    override fun getItemCount(): Int = initialList.size

    fun getFilter(): Filter {
        return filter
    }

    private val filter = object : Filter() {
        override fun performFiltering(constraint: CharSequence?): FilterResults {
            val filteredList: HashMap<String, String> = HashMap()

            if (constraint == null || constraint.isEmpty()) {
                values.let { filteredList.putAll(it) }
            } else {
                val query = constraint.toString().trim().lowercase()
                values.forEach {
                    if (it.key.lowercase(Locale.ROOT).contains(query) ||
                        it.value.lowercase(Locale.ROOT).contains(query)) {
                        filteredList[it.key] = it.value
                    }
                }
            }

            val results = FilterResults()
            results.values = filteredList
            return results
        }

        @SuppressLint("NotifyDataSetChanged")
        override fun publishResults(constraint: CharSequence?, results: FilterResults?) {
            if (results?.values is HashMap<*, *>) {
                initialList.clear()
                initialList.putAll(results.values as Map<out String, String>)
                notifyDataSetChanged()
            }
        }
    }

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