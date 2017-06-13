package com.test.web.Websocket.Controller;

import java.io.IOException;
import java.io.StringWriter;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Iterator;
import java.util.List;

import javax.json.Json;
import javax.json.JsonObject;
import javax.json.JsonWriter;
import javax.websocket.OnClose;
import javax.websocket.OnError;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;
  
@ServerEndpoint("/websocket")
public class WebSocketController {
	
	
    static List<Session> sessionUsers = Collections.synchronizedList(new ArrayList<>());
    static Session AdminSession; 
     
    @OnOpen
    public void handleOpen(Session userSession){
        sessionUsers.add(userSession);
    }
    
    @OnMessage
    public void handleMessage(String message,Session userSession) throws IOException{
        String username = (String)userSession.getUserProperties().get("username");
        if(username == null){
        	if(message.equals("#")){ 
        		userSession.getUserProperties().put("username", "admin");
                AdminSession = userSession;
                sessionUsers.remove(userSession);
        	}else{
        		userSession.getUserProperties().put("username", message); // user�� Id�� �����Ѵ�.
        	}
            return;
        }
        
        if(userSession == AdminSession){ // 보낸이가 관리자라면
        	
        	String [] messages = message.split("/");
        	Iterator<Session> iterator = sessionUsers.iterator();
        	
        	while(iterator.hasNext()){
        		Session session = iterator.next();
        		if(session.getId().equals(messages[1])){ // 해당 사용자에게 메시지 보내기.
        			session.getBasicRemote().sendText(buildJsonData(username,messages[0]));
        		}
        	}
        	
        }else{  // 회원이 보낸 거라면
        	try{
        	AdminSession.getBasicRemote().sendText(buildJsonData(username,message+"/" + userSession.getId()));
        	}catch(NullPointerException e){
        		userSession.getBasicRemote().sendText(buildJsonData(username, "현재 관리자가 접속해 있지 않습니다."));
        	}
        }
    }
    
    @OnClose
    public void handleClose(Session userSession){
        sessionUsers.remove(userSession);
    }
    
    public String buildJsonData(String username,String message){
        JsonObject jsonObject = Json.createObjectBuilder().add("message", message).build();
        StringWriter stringwriter =  new StringWriter();
        try(JsonWriter jsonWriter = Json.createWriter(stringwriter)){
                jsonWriter.write(jsonObject);
        };
        return stringwriter.toString();
    }
}
