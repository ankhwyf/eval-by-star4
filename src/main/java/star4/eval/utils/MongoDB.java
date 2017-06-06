package star4.eval.utils;

import com.mongodb.MongoClient;
import com.mongodb.client.MongoDatabase;

public enum MongoDB {
    INSTANCE;

    private static final String DBNAME = "eval";
    private MongoClient mongoClient;
    private MongoDatabase mongoDatabase;

    private MongoDB() {
        mongoClient = new MongoClient();
        mongoDatabase = mongoClient.getDatabase(DBNAME);
    }

    public MongoDatabase getDatabase() {
        return mongoDatabase;
    }

    public void close() {
        mongoClient.close();
    }
}
