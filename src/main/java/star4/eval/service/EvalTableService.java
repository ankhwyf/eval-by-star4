/*
 * Copyright (C) 2017 star4
 */
package star4.eval.service;

import com.google.gson.Gson;
import com.mongodb.client.MongoCollection;
import static com.mongodb.client.model.Filters.eq;
import org.bson.Document;
import star4.eval.bean.EvalTable;
import star4.eval.utils.MongoDB;

public class EvalTableService {

    public EvalTable findByAcademicYear(String academicYear) {
        MongoCollection<Document> collection
                = MongoDB.INSTANCE.getDatabase().getCollection("eval_admin");
        Document document = collection.find(eq("academic_year", academicYear)).first();
        if (document != null) {
            return new Gson().fromJson(document.toJson(), EvalTable.class);
        }
        return null;
    }
    
    public void update(EvalTable table) {
        String year = table.getAcademic_year();
        MongoCollection<Document> collection
                = MongoDB.INSTANCE.getDatabase().getCollection("eval_admin");
        Document queryObject = new Document("academic_year", year);
//        Document updateObject = new Document("$set", new Document("remark",
//                new BsonArray(Arrays.asList(table.getRemark()))));
//        String remarkStr = new Gson().toJson(table.getRemark());
//        remarkStr = remarkStr.replace("\\\"", "\"");
//        Document remarkDoc = Document.parse(remarkStr);
//        String jsonStr = new Gson().toJson(table);
//        Document document = Document.parse(jsonStr);
//        BasicDBObject searchQuery = new BasicDBObject().append("academic_year", year);
//        collection.updateOne(searchQuery, document);
//        collection.updateOne(queryObject, updateObject);
        
    }
}
