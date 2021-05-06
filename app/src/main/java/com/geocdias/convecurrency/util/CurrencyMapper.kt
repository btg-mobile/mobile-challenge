package com.geocdias.convecurrency.util

import com.geocdias.convecurrency.data.database.entities.CurrencyEntity
import com.geocdias.convecurrency.data.network.response.CurrencyListResponse
import com.geocdias.convecurrency.model.CurrencyModel

abstract class Mapper<T,I> {
    abstract fun map(origin: T): I

    fun mapList(origin: List<T>) : List<I> = origin.map { map(it) }
}

data class CurrencyMapper(
    val remoteListToDbMapper: RemoteListToDb,
    val dbToDomainMapper: DbToModel
)

class RemoteListToDb: Mapper<CurrencyListResponse, List<CurrencyEntity>>(){
    override fun map(origin: CurrencyListResponse): List<CurrencyEntity> {
        return origin.currencies.entries.map { entry ->
            CurrencyEntity(
                code = entry.key,
                name = entry.value
            )
        }
    }
}

class DbToModel: Mapper<CurrencyEntity, CurrencyModel>() {
    override fun map(origin: CurrencyEntity): CurrencyModel {
        return CurrencyModel(
            code = origin.code,
            name = origin.name
        )
    }
}
