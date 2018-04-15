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
public class DetailTable {
    private String cardID;
    private String name;
    private String academic_year;
    private boolean is_submit;
    private boolean is_audit;
    private String audit_level;
    private String grade_proof;
    private String teacher_total_sco;
    private String auditor_total_sco;
    private String college_admin_sco;
    private List<SubTableDe> scores;
    private List<String> effort_tables;
    

    public String getAcademic_year() {
        return academic_year;
    }

    public void setAcademic_year(String academic_year) {
        this.academic_year = academic_year;
    }

    public List<SubTableDe> getTables() {
        return scores;
    }

    public void setTables(List<SubTableDe> tables) {
        this.scores = tables;
    }
    
    public List<String> getEffortTable() {
        return effort_tables;
    }
    
    public void setEffortTable(List<String> table) {
        this.effort_tables = table;
    }

    public String getCardID() {
        return cardID;
    }

    public void setCardID(String cardID) {
        this.cardID = cardID;
    }

    public String getName(){
        return name;
    }
    
    public void setName(String name){
        this.name = name;
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
   
    public class SubTableDe {
//        public SubTableDe() {}
//        public String first_indicator;
        public List<SecondIndicatorDe> second_indicator;
//        public List<String> effort_table;
    }
    
    
    public class SecondIndicatorDe {
//        public SecondIndicatorDe(){}
//        public String title;
//        public String score;
//        public String remark;
        public String auditor_score;
        public List<ThirdIndicatorDe> third_indicator;
    }
    
    public class ThirdIndicatorDe {
        public String teacher_score;
        public String proof;
    }
    
}
