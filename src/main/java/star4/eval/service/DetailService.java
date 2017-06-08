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
import star4.eval.bean.DetailTable;
import star4.eval.utils.MongoDB;

/**
 *
 * @author ankhyfw
 */
public class DetailService {
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
}
