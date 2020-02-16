package io.felipeandrade.currencylayertest.ui.currency.selection

import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.annotation.LayoutRes
import androidx.recyclerview.widget.RecyclerView
import io.felipeandrade.currencylayertest.R
import io.felipeandrade.domain.CurrencyModel
import kotlinx.android.synthetic.main.currency_list_item.view.*

class CurrencyListAdapter : RecyclerView.Adapter<CurrencyListAdapter.ViewHolder>() {


    private var elements: List<CurrencyModel> = listOf()

    var onItemClicked: (CurrencyModel, Int) -> Unit = { _, _ -> }

    override fun getItemCount(): Int = elements.size
    override fun getItemViewType(position: Int): Int = R.layout.currency_list_item

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int) =
        ViewHolder(parent.inflate(viewType))

    override fun onBindViewHolder(holder: ViewHolder, position: Int) =
        holder.bind(elements[position], position, onItemClicked)

    fun setData(newElements: List<CurrencyModel>?) {
        elements = newElements ?: listOf()
        notifyDataSetChanged()
    }


    class ViewHolder(itemView: View) : RecyclerView.ViewHolder(itemView) {

        fun bind(
            currency: CurrencyModel,
            position: Int,
            onItemClicked: (CurrencyModel, Int) -> Unit
        ) {
            itemView.apply {
                tv_currency_symbol.text = currency.symbol
                tv_currency_name.text = currency.name
                setOnClickListener { onItemClicked(currency, position) }
            }
        }
    }
}

fun ViewGroup.inflate(@LayoutRes layoutRes: Int, attachToRoot: Boolean = false): View {
    return LayoutInflater.from(context).inflate(layoutRes, this, attachToRoot)
}