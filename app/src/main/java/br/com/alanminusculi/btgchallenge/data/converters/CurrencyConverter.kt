package br.com.alanminusculi.btgchallenge.data.converters

import br.com.alanminusculi.btgchallenge.data.local.models.Currency
import br.com.alanminusculi.btgchallenge.data.remote.dtos.ListDTO
import java.util.ArrayList

/**
 * Created by Alan Minusculi on 10/08/2021.
 */

open class CurrencyConverter {

    fun dtoToModel(listDTO: ListDTO): List<Currency> {
        val result: MutableList<Currency> = ArrayList<Currency>()
        val items: Map<String, String>? = listDTO.currencies
        if (items != null) {
            for (key in items.keys) {
                result.add(Currency(0, key, items[key]!!))
            }
        }
        return result
    }

}