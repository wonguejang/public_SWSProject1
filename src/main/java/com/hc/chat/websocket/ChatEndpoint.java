package com.hc.chat.websocket;

import java.io.IOException;
import java.util.Collections;
import java.util.HashSet;
import java.util.Set;

import javax.websocket.OnClose;
import javax.websocket.OnError;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;


@ServerEndpoint("/chat")
public class ChatEndpoint {
    private static Set<Session> sessions = Collections.synchronizedSet(new HashSet<>());
    @OnOpen
    public void onOpen(Session session) {
        sessions.add(session);
    }

    @OnMessage
    public void onMessage(String message, Session session) throws IOException {
        synchronized (sessions) {
            for (Session s : sessions) {
                if (s.isOpen()) {
                    s.getBasicRemote().sendText(message);
                }
            }
        }
    }
    @OnClose
    public void onClose(Session session) {
        sessions.remove(session);
    }
    @OnError
    public void onError(Session session, Throwable thr) {
        thr.printStackTrace();
    }
}