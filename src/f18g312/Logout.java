package f18g312;

import javax.faces.bean.ManagedBean;
import javax.faces.bean.SessionScoped;
import javax.faces.context.ExternalContext;
import javax.faces.context.FacesContext;
import javax.servlet.http.HttpSession;

@ManagedBean(name = "logout")
@SessionScoped
public class Logout {
	private DbOperations dbOperations;
	private Graphics graphics;
	private StatisticsBean statisticsBean;
	private DbAccess dbAccess;
	private String message;
	// private DataImport dataImport;

	public Logout() {
		FacesContext context = FacesContext.getCurrentInstance();
		if (context != null) {
			HttpSession session = (HttpSession) context.getExternalContext().getSession(true);
			dbAccess = (DbAccess) session.getAttribute("dbAccess");
			statisticsBean = (StatisticsBean) session.getAttribute("statisticsBean");
			dbOperations = (DbOperations) session.getAttribute("dbOperations");
			graphics = (Graphics) session.getAttribute("graphics");
			// dataImport = (DataImport) session.getAttribute("dataImport");
		}
	}

	public String processLogout() {
		try {
			System.out.println("I'm here!!! 1");
			ExternalContext ec = FacesContext.getCurrentInstance().getExternalContext();
			ec.invalidateSession();
			dbAccess.getActionScript().append("/r/n Logout");
			return "LOGOUT";
		} catch (Exception e) {
			System.out.println("I'm here!!! 2");
			message = e.getMessage();
			dbOperations.setMessage(message);
			dbOperations.setRenderMessage(true);
			statisticsBean.setMessage(message);
			statisticsBean.setRenderMessage(true);
			graphics.setMessage(message);
			graphics.setRenderMessage(true);
			dbOperations.setMessage(message);
			return "FAIL";
		}
	}

	public String processLogin() {
		String status = dbAccess.connect();
		if (status.equalsIgnoreCase("SUCCESS")) {
			return "SUCCESS";
		} else
			return "FAIL";
	}

	public DbOperations getDbOperations() {
		return dbOperations;
	}

	public void setDbOperations(DbOperations dbOperations) {
		this.dbOperations = dbOperations;
	}

	public Graphics getGraphics() {
		return graphics;
	}

	public void setGraphics(Graphics graphics) {
		this.graphics = graphics;
	}

	public StatisticsBean getStatisticsBean() {
		return statisticsBean;
	}

	public void setStatisticsBean(StatisticsBean statisticsBean) {
		this.statisticsBean = statisticsBean;
	}

	public DbAccess getDbAccess() {
		return dbAccess;
	}

	public void setDbAccess(DbAccess dbAccess) {
		this.dbAccess = dbAccess;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

}
