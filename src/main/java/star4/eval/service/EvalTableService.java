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
                = MongoDB.INSTANCE.getDatabase().getCollection("eval_table");
        Document document = collection.find(eq("academic_year", academicYear)).first();
        if (document != null) {
            return new Gson().fromJson(document.toJson(), EvalTable.class);
        }
        return null;
    }

    public void update(EvalTable table) {
        if (table != null) {
            String year = table.getAcademic_year();
            MongoCollection<Document> collection
                    = MongoDB.INSTANCE.getDatabase().getCollection("eval_table");
            Document document = Document.parse(new Gson().toJson(table));
            collection.updateOne(eq("academic_year", year), new Document("$set", document));
        }
    }
}
