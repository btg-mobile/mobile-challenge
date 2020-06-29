package br.com.daccandido.currencyconverterapp.ui.listcurrency

import android.content.Context
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.recyclerview.widget.RecyclerView
import br.com.daccandido.currencyconverterapp.R
import br.com.daccandido.currencyconverterapp.data.model.Currency
import io.realm.OrderedRealmCollection
import io.realm.RealmRecyclerViewAdapter

class ListCurrencyAdapter(private val context: Context, private val auto: Boolean,
                          private val currencies: OrderedRealmCollection<Currency>)

    : RealmRecyclerViewAdapter<Currency, ListCurrencyAdapter.ViewHolder>(currencies, auto) {

    constructor(currencies: OrderedRealmCollection<Currency>, context: Context) : this(context, true, currencies)

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ViewHolder {
        val view = LayoutInflater.from(context).inflate(R.layout.item_list_currencies, parent, false)
        return ViewHolder(view)
    }

    override fun getItemId(index: Int): Long {
        return getItem(index)?.id ?: 0
    }

    override fun getItemCount(): Int {
        return currencies.size
    }

    override fun onBindViewHolder(holder: ViewHolder, position: Int) {
        TODO("Not yet implemented")
    }


    class ViewHolder (itemView: View): RecyclerView.ViewHolder(itemView), View.OnClickListener {
        override fun onClick(view: View?) {
            TODO("Not yet implemented")
        }

    }
}