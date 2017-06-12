/*
 * Copyright (C) 2017 star4
 */
package star4.eval.service;

import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import static com.mongodb.client.model.Filters.eq;
import org.bson.Document;
import star4.eval.bean.User;
import star4.eval.utils.MongoDB;

public class UserService {

    private static final String COLLECTIONT = "teacher";
    private static final String COLLECTIONA = "auditor";
    private static final String COLLECTIONC = "college_admin";
    public static final String CNCOLLECTIONT = "教师";
    public static final String CNCOLLECTIONA = "审核员";
    public static final String CNCOLLECTIONC = "管理员";

    public User checkLoginUser(String name, String pwd, String type) {

        String cname;
        switch (type) {
            case CNCOLLECTIONT:
                cname = COLLECTIONT;
                break;
            case CNCOLLECTIONA:
                cname = COLLECTIONA;
                break;
            default:
                cname = COLLECTIONC;
                break;
        }
        User user;
        if (name.contains("@")) {
            user = this.findByEmail(name, cname);
        } else {
            user = this.findByCardID(name, cname);
        }
        if (user != null && user.getPassword().equals(pwd)) {
            user.setType(type);
            return user;
        }
        return null;
    }

    public User findByCardID(String cardId, String cname) {
        MongoDatabase database = MongoDB.INSTANCE.getDatabase();
        MongoCollection<Document> collection = database.getCollection(cname);
        Document document = collection.find(eq("cardID", cardId)).first();
        if (document != null) {
            return parseByDocument(document);
        }
        return null;
    }

    public User findByEmail(String email, String cname) {
        MongoDatabase database = MongoDB.INSTANCE.getDatabase();
        MongoCollection<Document> collection = database.getCollection(cname);
        Document document = collection.find(eq("email", email)).first();
        if (!document.isEmpty()) {
            return parseByDocument(document);
        }
        return null;
    }
    
    public User findByName(String name, String cname) {
        MongoDatabase database = MongoDB.INSTANCE.getDatabase();
        MongoCollection<Document> collection = database.getCollection(cname);
        Document document = collection.find(eq("name", name)).first();
        if (!document.isEmpty()) {
            return parseByDocument(document);
        }
        return null;
    }
    
    public User parseByDocument(Document document) {
        User user = new User();
        user.setCardID(document.getString("cardID"));
        user.setName(document.getString("name"));
        user.setEmail(document.getString("email"));
        user.setPassword(document.getString("pwd"));
        return user;
    }
}
