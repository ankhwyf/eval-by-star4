/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package star4.eval.service;

import com.google.gson.Gson;
import com.mongodb.client.FindIterable;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoCursor;
import static com.mongodb.client.model.Filters.and;
import static com.mongodb.client.model.Filters.eq;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import org.bson.Document;
import star4.eval.bean.DetailTable;
import star4.eval.utils.MongoDB;

/**
 *
 * @author ankhyfw
 */
public class DetailService {

    private static final String COLLECTIONED = "detail_table";
    private static final String ACADEMICYEAR = "academic_year";
    private static final String CARDID = "cardID";

    public List<DetailTable> findAllTablesByYear(String year) {
        MongoCollection<Document> collection
                = MongoDB.INSTANCE.getDatabase().getCollection(COLLECTIONED);
        //创建List
        List<DetailTable> details = new ArrayList<>();
        //遍历 生成Gson
        for (Document cur : collection.find()) {

            DetailTable temp = new Gson().fromJson(cur.toJson(), DetailTable.class);
            if (temp.getAcademic_year().equals(year) && temp.isIs_submit()) {
                details.add(temp);
            }
        }
        return details;
    }

    public String[] findAllYearsDe() {
        MongoCollection<Document> collection
                = MongoDB.INSTANCE.getDatabase().getCollection(COLLECTIONED);
        FindIterable<Document> findIterable = collection.find();
        MongoCursor<Document> mongoCursor = findIterable.iterator();

        List<String> yearList = new ArrayList<>();
        while (mongoCursor.hasNext()) {
            Document doc = mongoCursor.next();
            DetailTable table = parseDetail(doc);
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

    public String[] findYearsByCardID(String id) {
        MongoCollection<Document> collection
                = MongoDB.INSTANCE.getDatabase().getCollection(COLLECTIONED);
        FindIterable<Document> findIterable = collection.find();
        MongoCursor<Document> mongoCursor = findIterable.iterator();

        List<String> yearList = new ArrayList<>();
        while (mongoCursor.hasNext()) {
            Document doc = mongoCursor.next();
            DetailTable table = parseDetail(doc);
            if (table.getCardID().equals(id)) {
                String year = table.getAcademic_year();
                if (!yearList.contains(year)) {
                    yearList.add(year);
                }
            }
        }

        Collections.sort(yearList);

        String[] years = new String[yearList.size()];

        yearList.toArray(years);
        return years;
    }

    public DetailTable findDetailTable(String academicYear, String cardID) {
        MongoCollection<Document> collection
                = MongoDB.INSTANCE.getDatabase().getCollection(COLLECTIONED);
        Document document = collection.find(and(eq(CARDID, cardID), eq(ACADEMICYEAR, academicYear))).first();
        if (document != null) {
            return new Gson().fromJson(document.toJson(), DetailTable.class);
        }
        return null;
    }

    public boolean updateDetail(DetailTable table) {
        if (table != null) {
            String year = table.getAcademic_year();
            String cardID = table.getCardID();
            MongoCollection<Document> collection
                    = MongoDB.INSTANCE.getDatabase().getCollection(COLLECTIONED);
            //筛选工号
            Document document = collection.find(and(eq(CARDID, cardID), eq(ACADEMICYEAR, year))).first();
            Document doc = Document.parse(new Gson().toJson(table));
            collection.updateOne(document, new Document("$set", doc));
            return true;
        }
        return false;
    }

    public void insertDetail(DetailTable table) {
        if (table != null) {
            MongoCollection<Document> collection
                    = MongoDB.INSTANCE.getDatabase().getCollection(COLLECTIONED);
            Document document = Document.parse(new Gson().toJson(table));
            collection.insertOne(document);
        }
    }

    public DetailTable parseDetail(Document doc) {
        String jsonStr = doc.toJson();
        return new Gson().fromJson(jsonStr, DetailTable.class);
    }

    /**
     * 判断是否含有数字
     *
     * @param str
     * @return true为包含，false为不包含
     */
    public boolean isContainNumber(String str) {
        String regEx = "[0-9]";
        Pattern p = Pattern.compile(regEx);
        Matcher m = p.matcher(str);
        return m.find();
    }
    public boolean isContainRe(String str) {
        String regEx = "-";
        Pattern p = Pattern.compile(regEx);
        Matcher m = p.matcher(str);
        return m.find();
    }

}
