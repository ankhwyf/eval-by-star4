package star4.eval.bean;

import java.util.List;

import com.mongodb.ReflectionDBObject;

public class SupportingMaterial extends ReflectionDBObject {
	private String teacher_id;
	private String teacher_name;
	private String academic_year;
	private List<Doc> docs;

	public String getTeacher_id() {
		return teacher_id;
	}

	public void setTeacher_id(String teacher_id) {
		this.teacher_id = teacher_id;
	}

	public String getTeacher_name() {
		return teacher_name;
	}

	public void setTeacher_name(String teacher_name) {
		this.teacher_name = teacher_name;
	}

	public String getAcademic_year() {
		return academic_year;
	}

	public void setAcademic_year(String academic_year) {
		this.academic_year = academic_year;
	}

	public List<Doc> getDocs() {
		return docs;
	}

	public void setDocs(List<Doc> docs) {
		this.docs = docs;
	}

	public class Doc {
		public String doc_name;
		public String doc_address;
	}

}
