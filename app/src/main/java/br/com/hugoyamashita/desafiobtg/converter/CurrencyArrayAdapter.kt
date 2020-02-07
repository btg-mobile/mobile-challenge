package br.com.hugoyamashita.desafiobtg.converter

import android.content.Context
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.ArrayAdapter
import android.widget.TextView
import androidx.annotation.LayoutRes
import br.com.hugoyamashita.desafiobtg.model.Currency

class CurrencyArrayAdapter(context: Context, @LayoutRes private val itemLayout: Int, items: List<Currency>) :
    ArrayAdapter<Currency>(context, itemLayout, items) {

    override fun getView(position: Int, convertView: View?, parent: ViewGroup): View {
        var listItem = convertView ?: LayoutInflater.from(context).inflate(itemLayout, parent, false)

        (listItem as TextView).text = getItem(position)?.symbol

        return listItem
    }

    override fun getDropDownView(position: Int, convertView: View?, parent: ViewGroup): View {
        var listItem = convertView ?: LayoutInflater.from(context).inflate(itemLayout, parent, false)

        (listItem as TextView).text = getItem(position)?.symbol

        return listItem
    }

}