package com.example.exchange.fragment

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.fragment.app.Fragment
import androidx.recyclerview.widget.LinearLayoutManager
import com.example.exchange.R
import com.example.exchange.model.Coin
import com.example.exchange.utils.CoinAdapter
import kotlinx.android.synthetic.main.fragment_coin.*


class CoinFragment : Fragment() {

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        return inflater.inflate(R.layout.fragment_coin, container, false)
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)

        val listCoin: MutableList<Coin> = mutableListOf()

        listCoin.add(Coin("BGN", "Bulgarian Lev"))
        listCoin.add(Coin("BIF", "Burundian Franc"))
        listCoin.add(Coin("BMD", "Bermudan Dollar"))
        listCoin.add(Coin("BND", "Brunei Dollar"))
        listCoin.add(Coin("BRL", "Brazilian Real"))
        listCoin.add(Coin("BTC", "Bitcoin"))
        listCoin.add(Coin("CLP", "Chilean Peso"))
        listCoin.add(Coin("BYN", "New Belarusian Ruble"))
        listCoin.add(Coin("BYR", "Belarusian Ruble"))
        listCoin.add(Coin("BZD", "Belize Dollar"))
        listCoin.add(Coin("CAD", "Canadian Dollar"))
        listCoin.add(Coin("CDF", "Congolese Franc"))
        listCoin.add(Coin("CHF", "Swiss Franc"))

        with(recyclerview_coin) {
            adapter = CoinAdapter(listCoin)
            layoutManager = LinearLayoutManager(context)
        }
    }
}