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
	
	
	//유저 집합 리스트
    static List<Session> sessionUsers = Collections.synchronizedList(new ArrayList<>());
     
    /**
     * 웹 소켓이 접속되면 유저리스트에 세션을 넣는다.
     * @param userSession 웹 소켓 세션
     */
    @OnOpen
    public void handleOpen(Session userSession){
        sessionUsers.add(userSession);
        System.out.println(sessionUsers.size());
    }
    /**
     * 웹 소켓으로부터 메시지가 오면 호출한다.
     * @param message 메시지
     * @param userSession
     * @throws IOException
     */
    @OnMessage
    public void handleMessage(String message,Session userSession) throws IOException{
        String username = (String)userSession.getUserProperties().get("username");
        //세션 프로퍼티에 username이 없으면 username을 선언하고 해당 세션을으로 메시지를 보낸다.(json 형식이다.)
        //최초 메시지는 username설정
        if(username == null){
        	if(message.equals("#")){ // 접속한 사용자가 관리자 라면
        		userSession.getUserProperties().put("username", "admin");
                userSession.getBasicRemote().sendText(buildJsonData("System", "you are now connected as admin"));
                
        	}else{
        		userSession.getUserProperties().put("username", message); // user의 Id로 저장한다.
                userSession.getBasicRemote().sendText(buildJsonData("System", "you are now connected as user"));
        	}
            return;
        }
        //username이 있으면 전체에게 메시지를 보낸다.
        Iterator<Session> iterator = sessionUsers.iterator();
        while(iterator.hasNext()){
        	Session session = iterator.next();
        	session.getBasicRemote().sendText(buildJsonData(username,message));
        }
    }
    /**
     * 웹소켓을 닫으면 해당 유저를 유저리스트에서 뺀다.
     * @param userSession
     */
    @OnClose
    public void handleClose(Session userSession){
        sessionUsers.remove(userSession);
    }
    /**
     * json타입의 메시지 만들기
     * @param username
     * @param message
     * @return
     */
    public String buildJsonData(String username,String message){
        JsonObject jsonObject = Json.createObjectBuilder().add("message", username+" : "+message).build();
        StringWriter stringwriter =  new StringWriter();
        try(JsonWriter jsonWriter = Json.createWriter(stringwriter)){
                jsonWriter.write(jsonObject);
        };
        return stringwriter.toString();
    }
}
