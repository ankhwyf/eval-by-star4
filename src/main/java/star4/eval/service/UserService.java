/*
 * Copyright (C) 2017 star4
 */
package star4.eval.service;

import com.google.gson.Gson;
import com.mongodb.client.FindIterable;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoCursor;
import com.mongodb.client.MongoDatabase;
import static com.mongodb.client.model.Filters.eq;
import java.util.ArrayList;
import java.util.List;
import org.bson.Document;
import star4.eval.bean.User;
import star4.eval.utils.MongoDB;

public class UserService {

    public static final String COLLECTIONT = "teacher";
    public static final String COLLECTIONA = "auditor";
    public static final String COLLECTIONC = "college_admin";
    public static final String CNCOLLECTIONT = "教师";
    public static final String CNCOLLECTIONA = "审核员";
    public static final String CNCOLLECTIONC = "管理员";
    public static final String COLLECTIONUSER="user";

    public User checkLoginUser(String name, String pwd) {
        String cname;
        cname=COLLECTIONUSER;
//        switch (type) {
//            case CNCOLLECTIONT:
//                cname = COLLECTIONT;
//                break;
//            case CNCOLLECTIONA:
//                cname = COLLECTIONA;
//                break;
//            default:
//                cname = COLLECTIONC;
//                break;
//        }
        User user;
        if (name.contains("@")) {
            user = this.findByEmail(name,cname);
        } else {
            user = this.findByCardID(name,cname);
        }
        if (user != null && user.getPassword().equals(pwd)) {
//            user.setType(type);
            return user;
        }
        return null;
    }

    public User findByCardID(String cardId,String cname) {
        MongoDatabase database = MongoDB.INSTANCE.getDatabase();
        MongoCollection<Document> collection = database.getCollection(cname);
        Document document = collection.find(eq("cardID", cardId)).first();
        if (document != null) {
            return parse(document);
        }
        return null;
    }

    public User findByEmail(String email,String cname) {
        MongoDatabase database = MongoDB.INSTANCE.getDatabase();
        MongoCollection<Document> collection = database.getCollection(cname);
        Document document = collection.find(eq("email", email)).first();
        if (!document.isEmpty()) {
            return parse(document);
        }
        return null;
    }
    
    public User findByName(String name,String cname) {
        MongoDatabase database = MongoDB.INSTANCE.getDatabase();
        MongoCollection<Document> collection = database.getCollection(cname);
        Document document = collection.find(eq("name", name)).first();
        if (!document.isEmpty()) {
            return parse(document);
        }
        return null;
    }
    
    public List<User> findAll(){
        MongoCollection<Document> collection
                = MongoDB.INSTANCE.getDatabase().getCollection(COLLECTIONUSER);
        FindIterable<Document> findIterable = collection.find();
        MongoCursor<Document> mongoCursor = findIterable.iterator();
        
        List<User> usersList = new ArrayList<>();
        while (mongoCursor.hasNext()) {
            Document doc = mongoCursor.next();
            User user = parse(doc);
            List<String> userIden = user.getIdentity();
            if (!usersList.contains(user)) {
                for(int i = 0;i < userIden.size(); i++){
                    if(userIden.get(i).equals(COLLECTIONT)){
                        usersList.add(user);
                        break;
                    }
                }
            }
        }
        return usersList;
    }
    
//    public User parseByDocument(Document document) {
//        User user = new User();
//        user.setCardID(document.getString("cardID"));
//        user.setName(document.getString("name"));
//        user.setEmail(document.getString("email"));
//        user.setPassword(document.getString("password"));
//        return user;
//    }
    public User parse(Document doc) {
        String jsonStr = doc.toJson();
        Gson gson = new Gson();
        return gson.fromJson(jsonStr, User.class);
    }
    
    public List<String> enToCn(List<String> en){
        List<String> cn = new ArrayList();
        for(int i=0;i<en.size();i++){
            if(en.get(i).equals(UserService.COLLECTIONC)){
                cn.add(UserService.CNCOLLECTIONC);//管理员
            } else if(en.get(i).equals(UserService.COLLECTIONA)){
                cn.add(UserService.CNCOLLECTIONA);//审核员
            } else {
                cn.add(UserService.CNCOLLECTIONT);// 教师
            }
        }
        return cn;
    }
}