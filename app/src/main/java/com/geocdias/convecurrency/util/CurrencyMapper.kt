package com.geocdias.convecurrency.util

import com.geocdias.convecurrency.data.database.entities.CurrencyEntity
import com.geocdias.convecurrency.model.CurrencyModel

abstract class Mapper<T,I> {
    abstract fun map(origin: T): I

    fun mapList(origin: List<T>) : List<I> = origin.map { map(it) }
}

data class CurrencyMapper(
    //val remoteToDbMapper: RemoteToDbImpl,
    val dbToDomainMapper: DbToModelImpl
)

class DbToModelImpl: Mapper<CurrencyEntity, CurrencyModel>() {
    override fun map(origin: CurrencyEntity): CurrencyModel {
        return CurrencyModel(
            code = origin.code,
            name = origin.name
        )
    }
}
