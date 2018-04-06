/*
 * Copyright (C) 2017 star4
 */
package star4.eval.service;

import com.google.gson.Gson;
import com.mongodb.client.FindIterable;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoCursor;
import static com.mongodb.client.model.Filters.eq;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import org.bson.Document;
import star4.eval.bean.EvalTable;
import star4.eval.utils.MongoDB;

public class EvalTableService {
    
    private static final String COLLECTIONET = "eval_table";
    private static final String ACADEMICYEAR = "academic_year";
    
    public EvalTable findEvalByAcademicYear(String academicYear) {
        MongoCollection<Document> collection
                = MongoDB.INSTANCE.getDatabase().getCollection(COLLECTIONET);
        Document document = collection.find(eq(ACADEMICYEAR, academicYear)).first();
        if (document != null) {
            return new Gson().fromJson(document.toJson(), EvalTable.class);
        }
        return null;
    }
    
    public String[] findAll() {
        MongoCollection<Document> collection
                = MongoDB.INSTANCE.getDatabase().getCollection(COLLECTIONET);
        FindIterable<Document> findIterable = collection.find();
        MongoCursor<Document> mongoCursor = findIterable.iterator();
        
        List<String> yearList = new ArrayList<>();
        while (mongoCursor.hasNext()) {
            Document doc = mongoCursor.next();
            EvalTable table = parseEval(doc);
            String year = table.getAcademic_year();
            if (!yearList.contains(year)) {
                yearList.add(year);
            }
        }
        
        Collections.sort(yearList);
        
        String[] years = new String[yearList.size()];
        
        yearList.toArray(years);
        return years;
    }

    public void updateEval(EvalTable table) {
        if (table != null) {
            String year = table.getAcademic_year();
            MongoCollection<Document> collection
                    = MongoDB.INSTANCE.getDatabase().getCollection(COLLECTIONET);
            Document document = Document.parse(new Gson().toJson(table));
            collection.updateOne(eq(ACADEMICYEAR, year), new Document("$set", document));
        }
    }
    
    public void insertEval(EvalTable table) {
     if (table != null) {
            MongoCollection<Document> collection
                    = MongoDB.INSTANCE.getDatabase().getCollection(COLLECTIONET);
            Document document = Document.parse(new Gson().toJson(table));
            collection.insertOne(document);
        }
    }
    
    
    
    public EvalTable parseEval(Document doc) {
        String jsonStr = doc.toJson();
        return new Gson().fromJson(jsonStr, EvalTable.class);
    }
    
}
