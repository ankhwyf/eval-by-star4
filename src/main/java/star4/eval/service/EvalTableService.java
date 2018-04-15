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
import star4.eval.bean.EvalTable.SecondIndicator;
import star4.eval.bean.EvalTable.SubTable;
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

    public String[] findAllYears() {
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

    public String changeYear(String year) {
        
        int yeatInt = Integer.parseInt(year);
        yeatInt += 1;
        return yeatInt + "";
    }

    public String outputScore(SubTable tab) {
        List<SecondIndicator> list = tab.second_indicator;
        String output = "";
        for (int i = 0; i < list.size(); i++) {
            if (i == 0) {
                output += list.get(i).score;
            } else {
                output += "+" + list.get(i).score;
            }
        }
        return output + "分";
    }

    public boolean updateEval(EvalTable table) {
        if (table != null) {
            String year = table.getAcademic_year();
            MongoCollection<Document> collection
                    = MongoDB.INSTANCE.getDatabase().getCollection(COLLECTIONET);
            Document document = Document.parse(new Gson().toJson(table));
            collection.updateOne(eq(ACADEMICYEAR, year), new Document("$set", document));
            return true;
        }
        return false;
    }

    public boolean insertEval(EvalTable table) {
        if (table != null) {
            MongoCollection<Document> collection
                    = MongoDB.INSTANCE.getDatabase().getCollection(COLLECTIONET);
            Document document = Document.parse(new Gson().toJson(table));
            collection.insertOne(document);
            return true;
        }
        return false;
    }

    public EvalTable parseEval(Document doc) {
        String jsonStr = doc.toJson();
        return new Gson().fromJson(jsonStr, EvalTable.class);
    }

}
