package star4.eval.bean;

import java.util.List;

public class User {
	private String name;
	private String password;
	private String cardID;
	private String email;
        private List<String> identity;
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getCardID() {
		return cardID;
	}
	public void setCardID(String cardID) {
		this.cardID = cardID;
	}
        public List<String> getIdentity() {
		return identity;
	}
	public void setIdentity(List<String> identity) {
		this.identity =identity;
	}
	
}
