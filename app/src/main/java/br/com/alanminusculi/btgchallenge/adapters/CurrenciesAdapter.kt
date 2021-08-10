package br.com.alanminusculi.btgchallenge.adapters

import android.content.Context
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.BaseAdapter
import androidx.databinding.DataBindingUtil
import br.com.alanminusculi.btgchallenge.R
import br.com.alanminusculi.btgchallenge.data.local.models.Currency
import br.com.alanminusculi.btgchallenge.databinding.CurrencyListItemBinding

/**
 * Created by Alan Minusculi on 10/08/2021.
 */

class CurrenciesAdapter(context: Context, private val currencies: List<Currency>) : BaseAdapter() {

    private val layoutInflater: LayoutInflater = LayoutInflater.from(context)

    override fun getCount(): Int {
        return currencies.size
    }

    override fun getItem(position: Int): Any {
        return currencies[position]
    }

    override fun getItemId(position: Int): Long {
        return position.toLong()
    }

    override fun getView(position: Int, convertView: View?, parent: ViewGroup?): View {
        val binding: CurrencyListItemBinding?
        val view: View
        if (convertView == null) {
            view = layoutInflater.inflate(R.layout.currency_list_item, null)
            binding = DataBindingUtil.bind(view)
            view.tag = binding
        } else {
            view = convertView
            binding = convertView.tag as CurrencyListItemBinding
        }

        return if (binding != null) {
            val currency: Currency = currencies[position]
            binding.currency = currency
            binding.root.id = currency.id
            binding.root
        } else {
            view
        }
    }
}