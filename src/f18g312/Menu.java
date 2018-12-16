package f18g312;

import java.util.Map;

import javax.annotation.PostConstruct;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.SessionScoped;
import javax.faces.context.FacesContext;

@ManagedBean(name = "menu")
@SessionScoped
public class Menu {
	private DbAccess dbAccess;

	@PostConstruct
	public void init() {
		FacesContext context = FacesContext.getCurrentInstance();
		Map<String, Object> m = context.getExternalContext().getSessionMap();
		dbAccess = (DbAccess) m.get("dbAccess");
	}

	public DbAccess getDbAccess() {
		return dbAccess;
	}

	public void setDbAccess(DbAccess dbAccess) {
		this.dbAccess = dbAccess;
	}

	// public Menu() {
	// }

	public String processLogin() {
		// String status = dbAccess.connect();
		System.out.println("Hi");
		System.out.println(dbAccess.getUsername());
		// if (status.equalsIgnoreCase("SUCCESS")) {
		// System.out.println("Connection Done");
		// return "SUCCESS";
		// } else
		// return "FAIL";
		// }
		return "FAIL";
	}
}