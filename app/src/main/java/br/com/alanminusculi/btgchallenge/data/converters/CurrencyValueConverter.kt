package br.com.alanminusculi.btgchallenge.data.converters

import br.com.alanminusculi.btgchallenge.data.local.models.CurrencyValue
import br.com.alanminusculi.btgchallenge.data.remote.dtos.LiveDTO
import java.util.ArrayList

/**
 * Created by Alan Minusculi on 10/08/2021.
 */

open class CurrencyValueConverter {

    fun dtoToModel(liveDTO: LiveDTO): List<CurrencyValue> {
        val result: MutableList<CurrencyValue> = ArrayList<CurrencyValue>()
        val items: Map<String, Double>? = liveDTO.quotes
        if (items != null) {
            for (key in items.keys) {
                result.add(
                    CurrencyValue(0, key, items[key]!!)
                )
            }
        }
        return result
    }

}