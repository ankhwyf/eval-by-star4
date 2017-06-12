/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package star4.eval.bean;

import java.util.List;

/**
 *
 * @author ankhyfw
 */
public class EvalTable {
    private String academic_year;
    private List<SubTable> tables;
    private List<Remark> remark;
    private boolean is_publish;

    public String getAcademic_year() {
        return academic_year;
    }

    public void setAcademic_year(String academic_year) {
        this.academic_year = academic_year;
    }

    public List<SubTable> getTables() {
        return tables;
    }

    public void setTables(List<SubTable> tables) {
        this.tables = tables;
    }

    public List<Remark> getRemark() {
        return remark;
    }

    public void setRemark(List<Remark> remark) {
        this.remark = remark;
    }

    public boolean isIs_publish() {
        return is_publish;
    }

    public void setIs_publish(boolean is_publish) {
        this.is_publish = is_publish;
    }

    public class SubTable {
        public String first_indicator;
        public List<SecondIndicator> second_indicator;
        public List<String> effort_table;
    }
    
    public class SecondIndicator {
        public String title;
        public int score;
        public String remark;
        public List<ThirdIndicator> third_indicator;
    }
    
    public class ThirdIndicator {
        public String content;
        public String score;
    }
    
    public class Remark {
        
        public Remark() {}
        public String keypoint;
        public String content;
    }
}
