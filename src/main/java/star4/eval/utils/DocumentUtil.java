package star4.eval.utils;

import com.google.gson.Gson;
import org.bson.Document;
import star4.eval.bean.DetailTable;
import star4.eval.bean.EvalTable;
import star4.eval.bean.SupportingMaterial;
import star4.eval.bean.User;

public class DocumentUtil {

    private static DocumentUtil mInstance;
    
    public static final int PARSE_DETAIL_TABLE = 0x01;
    public static final int PARSE_EVAL_TABLE = 0x02;
    public static final int PARSE_SUPPORTING_MATERIAL = 0x03;
    public static final int PARSE_USER = 0x04;
    
    public static DocumentUtil getInstance() {
        if (mInstance == null) {
            synchronized(DocumentUtil.class) {
                if (mInstance == null) {
                    mInstance = new DocumentUtil();
                }
            }
        }
        return mInstance;
    }
    
    private DocumentUtil() {}
            
    public Object parse(Document doc, int type) {
        String jsonStr = doc.toJson();
        Gson gson = new Gson();
        switch(type) {
            case PARSE_DETAIL_TABLE:
                return gson.fromJson(jsonStr, DetailTable.class);
            case PARSE_EVAL_TABLE:
                return gson.fromJson(jsonStr, EvalTable.class);
            case PARSE_SUPPORTING_MATERIAL:
                return gson.fromJson(jsonStr, SupportingMaterial.class);
            case PARSE_USER:
                return gson.fromJson(jsonStr, User.class);
        }
        return null;
    }
	
}
