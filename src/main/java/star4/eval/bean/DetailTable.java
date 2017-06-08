/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package star4.eval.bean;

import com.mongodb.ReflectionDBObject;
import java.util.List;

/**
 *
 * @author ankhyfw
 */
public class DetailTable extends ReflectionDBObject {
    private String cardID;
    private String academic_year;
    private boolean is_submit;
    private boolean is_audit;
    private String audit_level;
    private String grade_proof;
    private String teacher_total_sco;
    private String auditor_total_sco;
    private String college_admin_sco;
    private List<SubTable> tables;
    

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

    public String getCardID() {
        return cardID;
    }

    public void setCardID(String cardID) {
        this.cardID = cardID;
    }

    public boolean isIs_submit() {
        return is_submit;
    }

    public void setIs_submit(boolean is_submit) {
        this.is_submit = is_submit;
    }

    public boolean isIs_audit() {
        return is_audit;
    }

    public void setIs_audit(boolean is_audit) {
        this.is_audit = is_audit;
    }

    public String getAudit_level() {
        return audit_level;
    }

    public void setAudit_level(String audit_level) {
        this.audit_level = audit_level;
    }

    public String getGrade_proof() {
        return grade_proof;
    }

    public void setGrade_proof(String grade_proof) {
        this.grade_proof = grade_proof;
    }

    public String getTeacher_total_sco() {
        return teacher_total_sco;
    }

    public void setTeacher_total_sco(String teacher_total_sco) {
        this.teacher_total_sco = teacher_total_sco;
    }

    public String getAuditor_total_sco() {
        return auditor_total_sco;
    }

    public void setAuditor_total_sco(String auditor_total_sco) {
        this.auditor_total_sco = auditor_total_sco;
    }

    public String getCollege_admin_sco() {
        return college_admin_sco;
    }

    public void setCollege_admin_sco(String college_admin_sco) {
        this.college_admin_sco = college_admin_sco;
    }

   
    public class SubTable {
        public String first_indicator;
        public List<SecondIndicator> second_indicator;
        public List<String> effort_table;
    }
    
    public class SecondIndicator {
        public String title;
        public String auditor_score;
        public List<ThirdIndicator> third_indicator;
    }
    
    public class ThirdIndicator {
        public String teacher_score;
        public String proof;
    }
}
