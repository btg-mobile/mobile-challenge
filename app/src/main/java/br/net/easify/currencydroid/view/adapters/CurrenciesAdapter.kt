package br.net.easify.currencydroid.view.adapters

import android.view.LayoutInflater
import android.view.ViewGroup
import androidx.databinding.DataBindingUtil
import androidx.recyclerview.widget.RecyclerView
import br.net.easify.currencydroid.R
import br.net.easify.currencydroid.database.model.Currency
import br.net.easify.currencydroid.databinding.HolderCurrencyBinding

class CurrenciesAdapter(private var listener: OnItemClick,
                        private var currencies: ArrayList<Currency>)
    : RecyclerView.Adapter<CurrenciesAdapter.CurrencyViewHolder>() {

    class CurrencyViewHolder(var view: HolderCurrencyBinding) :
        RecyclerView.ViewHolder(view.root)

    interface OnItemClick {
        fun onItemClick(currency: Currency)
    }

    fun updateData(newData: List<Currency>) {
        currencies.clear()
        currencies.addAll(newData)
        notifyDataSetChanged()
    }

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): CurrencyViewHolder {
        val inflater = LayoutInflater.from(parent.context)
        val view = DataBindingUtil.inflate<HolderCurrencyBinding>(
            inflater,
            R.layout.holder_currency,
            parent,
            false
        )
        return CurrencyViewHolder(view)
    }

    override fun onBindViewHolder(holder: CurrencyViewHolder, position: Int) {
        val currency = currencies[position]

        holder.itemView.setOnClickListener {
            listener.onItemClick(currency)
        }

        holder.view.currency = currency
    }

    override fun getItemCount() = currencies.size
}