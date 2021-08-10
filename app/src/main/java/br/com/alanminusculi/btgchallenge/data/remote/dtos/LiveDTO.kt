package br.com.alanminusculi.btgchallenge.data.remote.dtos

import java.io.Serializable

/**
 * Created by Alan Minusculi on 10/08/2021.
 */

class LiveDTO : Serializable {

    var success = false
    var source: String? = null
    var quotes: Map<String, Double>? = null

}