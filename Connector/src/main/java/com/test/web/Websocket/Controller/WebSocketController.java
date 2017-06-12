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
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;

  
@ServerEndpoint("/websocket")
public class WebSocketController {
	
	
	//���� ���� ����Ʈ
    static List<Session> sessionUsers = Collections.synchronizedList(new ArrayList<>());
     
    /**
     * �� ������ ���ӵǸ� ��������Ʈ�� ������ �ִ´�.
     * @param userSession �� ���� ����
     */
    @OnOpen
    public void handleOpen(Session userSession){
        sessionUsers.add(userSession);
        System.out.println(sessionUsers.size());
    }
    /**
     * �� �������κ��� �޽����� ���� ȣ���Ѵ�.
     * @param message �޽���
     * @param userSession
     * @throws IOException
     */
    @OnMessage
    public void handleMessage(String message,Session userSession) throws IOException{
        String username = (String)userSession.getUserProperties().get("username");
        //���� ������Ƽ�� username�� ������ username�� �����ϰ� �ش� ���������� �޽����� ������.(json �����̴�.)
        //���� �޽����� username����
        if(username == null){
        	if(message.equals("#")){ // ������ ����ڰ� ������ ���
        		userSession.getUserProperties().put("username", "admin");
                userSession.getBasicRemote().sendText(buildJsonData("System", "you are now connected as admin"));
                
        	}else{
        		userSession.getUserProperties().put("username", message); // user�� Id�� �����Ѵ�.
                userSession.getBasicRemote().sendText(buildJsonData("System", "you are now connected as user"));
        	}
            return;
        }
        //username�� ������ ��ü���� �޽����� ������.
        Iterator<Session> iterator = sessionUsers.iterator();
        while(iterator.hasNext()){
        	Session session = iterator.next();
        	session.getBasicRemote().sendText(buildJsonData(username,message));
        }
    }
    /**
     * �������� ������ �ش� ������ ��������Ʈ���� ����.
     * @param userSession
     */
    @OnClose
    public void handleClose(Session userSession){
        sessionUsers.remove(userSession);
    }
    /**
     * jsonŸ���� �޽��� �����
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
