package star4.eval.service;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;

public class EvalTableServiceTest {

    private EvalTableService evalTableService;

    @Before
    public void before() {
        evalTableService = new EvalTableService();
    }

    @Test
    public void updateTest() {
//        EvalTable table = evalTableService.findByAcademicYear("2016");
        String first_indicator = "hehe";
//        table.getTables().get(0).first_indicator = first_indicator;
//        evalTableService.update(table);
//        EvalTable expectedTable = evalTableService.findByAcademicYear("2016");
//        assertEquals("修改 第一栏信息为 \"hehe\"?", first_indicator, expectedTable.getTables().get(0).first_indicator);
    }

    @After
    public void after() {
//        EvalTable table = evalTableService.findByAcademicYear("2016");
//        table.getTables().get(0).first_indicator = "教学工作量";
//        evalTableService.update(table);
    }

}
