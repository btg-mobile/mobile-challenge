package br.com.alanminusculi.btgchallenge.data.remote.dtos

import java.io.Serializable

/**
 * Created by Alan Minusculi on 10/08/2021.
 */

class ListDTO : Serializable {

    var success = false
    var currencies: Map<String, String>? = null

}