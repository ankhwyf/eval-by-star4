package star4.eval;

import java.util.Iterator;
import java.util.List;

import org.bson.Document;

import com.mongodb.BasicDBObject;
import com.mongodb.DB;
import com.mongodb.DBCollection;
import com.mongodb.DBCursor;
import com.mongodb.DBObject;
import com.mongodb.MongoClient;
import com.mongodb.QueryOperators;
import com.mongodb.client.MongoCursor;

public class MongoDBInterface {

	private static final String DBNAME = "eval";
	private static final String COLLECTIONT = "teacher";
	private static final String COLLECTIONA = "auditor";
	private static final String COLLECTIONC = "college_admin";
	public static final String CNCOLLECTIONT = "教师";
	public static final String CNCOLLECTIONA = "审核员";
	public static final String CNCOLLECTIONC = "管理员";
	private final MongoClient mongoClient;
	private final DB db;

	public MongoDBInterface() {
		mongoClient = new MongoClient();
		db = mongoClient.getDB(DBNAME);
	}

	/**
	 * 查询用户
	 * 
	 * @param type
	 * @param name
	 * @param pwd
	 * @return
	 */
	public DBObject queryUser(String type, String name, String pwd) {
		DBObject str = null;
		// 判断并获取集合
		DBCollection collection;
		switch (type) {
		case CNCOLLECTIONT:
			collection = db.getCollection(COLLECTIONT);
			break;
		case CNCOLLECTIONA:
			collection = db.getCollection(COLLECTIONA);
			break;
		default:
			collection = db.getCollection(COLLECTIONC);
			break;
		}
		// 判断账号是工号还是邮箱 邮箱中含有“@”
		BasicDBObject query;
		if (name.contains("@")) {
			query = new BasicDBObject("email", new BasicDBObject("$eq", name)).append("pwd",
					new BasicDBObject("$eq", pwd));
		} else {
			query = new BasicDBObject("cardID", new BasicDBObject("$eq", name)).append("pwd",
					new BasicDBObject("$eq", pwd));
		}
		str = collection.findOne(query);

		return str;
	}

	/**
	 * 查询表格
	 * 
	 * @param year
	 * @return
	 */
	public DBObject queryTable(String year) {
		DBObject strTable;
		BasicDBObject query;
		query = new BasicDBObject("academic_year", new BasicDBObject("$eq", year));

		DBCollection collection = db.getCollection("eval_admin");
		strTable = collection.findOne(query);
		return strTable;
	}
	
	/**
	 * 查询所有佐证材料
	 * 
	 * @return
	 */
	public List<DBObject> querySupportingMaterial() {
		DBCollection collection = db.getCollection("doc_manage");
		DBCursor cursor = collection.find();
		List<DBObject> list = cursor.toArray();
		return list;
	}

	/**
	 * 查询佐证材料
	 * 
	 * @param id
	 * @param name
	 * @param year
	 * @return
	 */
	public DBObject querySupportingMaterial(String id, String name, String year) {
		DBObject strTable;
		BasicDBObject query;
		query = new BasicDBObject().append(QueryOperators.AND, new BasicDBObject[]{new BasicDBObject("teacher_id",id),new BasicDBObject("teacher_name",name),new BasicDBObject("academic_year",year)});

		DBCollection collection = db.getCollection("doc_manage");
		strTable = collection.findOne(query);
		return strTable;
	}

	/**
	 * 关闭连接
	 *
	 *
	 */
	public void close() {
		mongoClient.close();
	}
}
