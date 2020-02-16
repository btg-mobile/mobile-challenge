package io.felipeandrade.currencylayertest.ui.currency.selection

import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.annotation.LayoutRes
import androidx.recyclerview.widget.RecyclerView
import io.felipeandrade.currencylayertest.R
import io.felipeandrade.domain.CurrencyModel

class CurrencyListAdapter : RecyclerView.Adapter<CurrencyListAdapter.ViewHolder>() {


    private var elements: List<CurrencyModel> = listOf()

    var onItemClicked: (CurrencyModel) -> Unit = {}

    override fun getItemCount(): Int = elements.size
    override fun getItemViewType(position: Int): Int = R.layout.currency_list_item

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int) =
        ViewHolder(parent.inflate(viewType))

    override fun onBindViewHolder(holder: ViewHolder, position: Int) =
        holder.bind(elements[position], onItemClicked)

    fun setData(newElements: List<CurrencyModel>?) {
        elements = newElements ?: listOf()
        notifyDataSetChanged()
    }


    class ViewHolder(itemView: View) : RecyclerView.ViewHolder(itemView) {

        fun bind(
            currency: CurrencyModel,
            onCharacterClicked: (CurrencyModel) -> Unit
        ) {
            itemView.apply {

                setOnClickListener { onCharacterClicked(currency) }
            }
        }
    }
}

fun ViewGroup.inflate(@LayoutRes layoutRes: Int, attachToRoot: Boolean = false): View {
    return LayoutInflater.from(context).inflate(layoutRes, this, attachToRoot)
}