/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package star4.eval.service;

import com.google.gson.Gson;
import com.mongodb.client.MongoCollection;
import static com.mongodb.client.model.Filters.eq;
import java.util.ArrayList;
import java.util.List;
import org.bson.Document;
import star4.eval.bean.DetailTable;
import star4.eval.utils.MongoDB;

/**
 *
 * @author ankhyfw
 */
public class DetailService {
    
    private static final String COLLECTIONED = "eval_detail";
    private static final String ACADEMICYEAR = "academic_year";
    
        public List<DetailTable> findAll() {
        MongoCollection<Document> collection
                = MongoDB.INSTANCE.getDatabase().getCollection("eval_detail");
        //创建List
        List<DetailTable> details = new ArrayList<>();
        //遍历 生成Gson
        for(Document cur:collection.find()){
            DetailTable temp=new Gson().fromJson(cur.toJson(), DetailTable.class);
            details.add(temp);
        }
        return details;
    }
        
        public DetailTable findDetailByAcademicYear(String academicYear) {
        MongoCollection<Document> collection
                = MongoDB.INSTANCE.getDatabase().getCollection(COLLECTIONED);
        Document document = collection.find(eq(ACADEMICYEAR, academicYear)).first();
        if (document != null) {
            return new Gson().fromJson(document.toJson(), DetailTable.class);
        }
        return null;
    }
        
        public void updateDetail(DetailTable table) {
        if (table != null) {
            String year = table.getAcademic_year();
            MongoCollection<Document> collection
                    = MongoDB.INSTANCE.getDatabase().getCollection(COLLECTIONED);
            Document document = Document.parse(new Gson().toJson(table));
//            collection.updateOne(eq(ACADEMICYEAR, year), new Document("$set", document));
        }
    }
       
        public void insertDetail(DetailTable table) {
            if(table != null) {
                MongoCollection<Document> collection
                    = MongoDB.INSTANCE.getDatabase().getCollection(COLLECTIONED);
                Document document = Document.parse(new Gson().toJson(table));
                collection.insertOne(document);
            }
        }
}
