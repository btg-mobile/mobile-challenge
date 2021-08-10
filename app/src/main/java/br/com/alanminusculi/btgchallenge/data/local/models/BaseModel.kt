package br.com.alanminusculi.btgchallenge.data.local.models

import androidx.room.PrimaryKey
import java.io.Serializable

/**
 * Created by Alan Minusculi on 10/08/2021.
 */

open class BaseModel(@PrimaryKey(autoGenerate = true) var id: Int) : Serializable