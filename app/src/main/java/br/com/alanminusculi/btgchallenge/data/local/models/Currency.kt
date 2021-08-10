package br.com.alanminusculi.btgchallenge.data.local.models

import androidx.room.ColumnInfo
import androidx.room.Entity

/**
 * Created by Alan Minusculi on 10/08/2021.
 */

@Entity
class Currency(
    id: Int = 0,
    @ColumnInfo val acronym: String,
    @ColumnInfo val name: String) : BaseModel(id)