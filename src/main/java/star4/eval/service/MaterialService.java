/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package star4.eval.service;

import com.google.gson.Gson;
import com.mongodb.client.MongoCollection;
import java.util.ArrayList;
import java.util.List;
import org.bson.Document;
import star4.eval.bean.SupportingMaterial;
import star4.eval.utils.MongoDB;

public class MaterialService {
    private static final String COLLECTIONED = "doc_manage";
    
    public List<SupportingMaterial> findAllMS() {
        MongoCollection<Document> collection
                = MongoDB.INSTANCE.getDatabase().getCollection(COLLECTIONED);
        List<SupportingMaterial> materials = new ArrayList<>();
        for(Document cur:collection.find()){
            SupportingMaterial temp=new Gson().fromJson(cur.toJson(), SupportingMaterial.class);
            materials.add(temp);
        }
        return materials;
    }
    public List<SupportingMaterial> findAllMSById(String cardID) {
        MongoCollection<Document> collection
                = MongoDB.INSTANCE.getDatabase().getCollection(COLLECTIONED);
        List<SupportingMaterial> materials = new ArrayList<>();
        for(Document cur:collection.find()){
            SupportingMaterial temp=new Gson().fromJson(cur.toJson(), SupportingMaterial.class);
            if(temp.getTeacher_id().equals(cardID)){
                materials.add(temp);
            }
            
        }
        return materials;
    }
    
}
