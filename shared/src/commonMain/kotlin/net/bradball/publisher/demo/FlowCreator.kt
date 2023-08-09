package net.bradball.publisher.demo

import com.rickclephas.kmp.nativecoroutines.NativeCoroutines
import kotlinx.coroutines.delay
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.flow

class FlowCreator {

    @NativeCoroutines
    fun getFlow(input: String): Flow<Int> = flow {
        var i = 0
        while (i < Int.MAX_VALUE) {
            i += 1
            emit(i)
        }
    }

}