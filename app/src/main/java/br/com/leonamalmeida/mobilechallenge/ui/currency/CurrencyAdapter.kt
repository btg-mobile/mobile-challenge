package br.com.leonamalmeida.mobilechallenge.ui.currency

import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.recyclerview.widget.RecyclerView
import br.com.leonamalmeida.mobilechallenge.R
import br.com.leonamalmeida.mobilechallenge.data.Currency
import kotlinx.android.synthetic.main.item_currency.view.*

/**
 * Created by Leo Almeida on 28/06/20.
 */

class CurrencyAdapter(private val onCurrencySelected: ((Currency) -> Unit)) :
    RecyclerView.Adapter<CurrencyAdapter.CurrencyVH>() {

    var currencies = emptyList<Currency>()
        set(value) {
            field = value
            notifyDataSetChanged()
        }

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): CurrencyAdapter.CurrencyVH {
        return CurrencyVH(
            LayoutInflater.from(parent.context).inflate(R.layout.item_currency, parent, false)
        )
    }

    override fun getItemCount(): Int = currencies.size

    override fun onBindViewHolder(holder: CurrencyAdapter.CurrencyVH, position: Int) {
        holder.bind(currencies[position])
    }

    inner class CurrencyVH(itemView: View) : RecyclerView.ViewHolder(itemView) {
        fun bind(currency: Currency) {
            itemView.run {
                itemCurrencyTv.text = currency.toString()
                setOnClickListener { onCurrencySelected.invoke(currency) }
            }
        }
    }
}