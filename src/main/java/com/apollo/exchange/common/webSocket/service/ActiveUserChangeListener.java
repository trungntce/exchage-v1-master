package com.apollo.exchange.common.webSocket.service;

public interface ActiveUserChangeListener {
	 
    /**
     * call when Observable's internal state is changed.
     */
    void notifyActiveUserChange();
}
