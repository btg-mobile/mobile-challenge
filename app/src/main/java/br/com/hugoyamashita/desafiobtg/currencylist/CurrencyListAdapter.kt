package br.com.hugoyamashita.desafiobtg.currencylist

import android.view.LayoutInflater
import android.view.ViewGroup
import androidx.appcompat.widget.AppCompatTextView
import androidx.recyclerview.widget.RecyclerView
import br.com.hugoyamashita.desafiobtg.R
import br.com.hugoyamashita.desafiobtg.currencylist.CurrencyListAdapter.ViewHolder
import br.com.hugoyamashita.desafiobtg.model.Currency

class CurrencyListAdapter(private val currencies: MutableList<Currency>) :
    RecyclerView.Adapter<ViewHolder>() {

    class ViewHolder(itemView: ViewGroup) : RecyclerView.ViewHolder(itemView) {
        val symbol: AppCompatTextView = itemView.findViewById(R.id.symbol)
        val name: AppCompatTextView = itemView.findViewById(R.id.name)
    }

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ViewHolder {
        val item = LayoutInflater.from(parent.context)
            .inflate(R.layout.currency_list_item, parent, false) as ViewGroup

        return ViewHolder(
            item
        )
    }

    override fun onBindViewHolder(holder: ViewHolder, position: Int) {
        val item = currencies[position]
        holder.symbol.text = item.symbol
        holder.name.text = item.name
    }

    override fun getItemCount(): Int = currencies.size

    fun updateItems(items: List<Currency>) {
        currencies.apply {
            clear()
            addAll(items)
        }
    }

}
