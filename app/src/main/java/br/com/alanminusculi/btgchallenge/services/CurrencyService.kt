package br.com.alanminusculi.btgchallenge.services

import android.content.Context
import br.com.alanminusculi.btgchallenge.data.converters.CurrencyConverter
import br.com.alanminusculi.btgchallenge.data.local.DatabaseHelper
import br.com.alanminusculi.btgchallenge.data.local.daos.CurrencyDao
import br.com.alanminusculi.btgchallenge.data.local.models.Currency
import br.com.alanminusculi.btgchallenge.data.remote.api.Api
import br.com.alanminusculi.btgchallenge.data.remote.api.ApiHelper
import br.com.alanminusculi.btgchallenge.data.remote.dtos.ListDTO
import br.com.alanminusculi.btgchallenge.exceptions.ApiException
import java.io.IOException

/**
 * Created by Alan Minusculi on 10/08/2021.
 */

class CurrencyService(applicationContext: Context) {

    private var dao: CurrencyDao? = null
    private var api: Api? = null

    init {
        dao = DatabaseHelper.getAppDatabase(applicationContext).getCurrencyDao()
        api = ApiHelper.getApi()
    }

    @Throws(ApiException::class)
    fun sync() {
        try {
            val listDTO: ListDTO? = api!!.list()!!.execute().body()
            if (listDTO?.currencies != null) {
                val currencies: List<Currency> = CurrencyConverter().dtoToModel(listDTO)
                dao!!.replaceAll(*currencies.toTypedArray())
            }
        } catch (e: IOException) {
            throw ApiException("Não foi possível atualizar a cotação das moedas.")
        }
    }

    fun findOne(usd: String): Currency {
        return dao!!.findOne(usd)
    }

    fun findAll(): List<Currency> {
        return dao!!.findAll()
    }

    fun findById(id: Int): Currency {
        return dao!!.findById(id)
    }

    fun find(query: String): List<Currency> {
        return dao!!.find(query)
    }
}