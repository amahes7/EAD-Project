package f18g312;

import java.io.IOException;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;
import java.util.regex.Pattern;

import javax.faces.bean.ManagedBean;
import javax.faces.bean.SessionScoped;
import javax.faces.context.FacesContext;
import javax.servlet.http.HttpSession;

import org.apache.myfaces.custom.fileupload.UploadedFile;

@ManagedBean(name = "actionBeanFile")
@SessionScoped
public class ActionBeanFile implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 4437317197603085355L;
	private UploadedFile uploadedFile;
	private String uploadedFileContents;
	private String fileName;
	private long fileSize;
	private String fileContentType;
	private String fileLabel;
	private String filePath;
	private DbAccess dbAccess;
	private DescStatistics descStatistics;
	private DbOperations dbOperations;
	private Scanner scan;
	private String message;
	private boolean renderTablename;
	private boolean renderTabledata;
	private String tableNameValue;
	private boolean renderColumnNames;
	private boolean renderTableDetails;
	private List<String> columnSelected;
	private Regression regression;
	private Graphics graphics;
	private StatisticsBean statisticsBean;
	private boolean renderHistChart;
	private String predictorValue;
	private String responseValue;
	private boolean renderSPChart;
	private boolean renderRegressionResults;
	private boolean renderCorrResults;
	private boolean renderDescStatsResults;
	private boolean renderTextArea;
	private boolean renderErrorMessage;
	
	private String input;
	String status;
	
	public ActionBeanFile() {
		FacesContext context = FacesContext.getCurrentInstance();
		if (context != null) {
			HttpSession session = (HttpSession) context.getExternalContext().getSession(true);
			dbAccess = (DbAccess) session.getAttribute("dbAccess");
			descStatistics = (DescStatistics) session.getAttribute("descStatistics");
			dbOperations = (DbOperations) session.getAttribute("dbOperations");
			regression = (Regression) session.getAttribute("regression");
			graphics = (Graphics) session.getAttribute("graphics");
			statisticsBean = (StatisticsBean) session.getAttribute("statisticsBean");
		}
		columnSelected = new ArrayList<String>();
		status = new String();
		input= new String();
		renderTextArea=false;
		renderSPChart=false;
		renderRegressionResults=false;
		renderCorrResults=false;
		renderTextArea=false;
		renderDescStatsResults=false;
		renderColumnNames=false;
	}

	public String processFileUpload() {
		if (uploadedFileContents != null) {
			return "Fail";
		} else

		{
			resetAction();
			uploadedFileContents = null;
			FacesContext context = FacesContext.getCurrentInstance();
			filePath = context.getExternalContext().getRealPath("/temp");
			// FileOutputStream fos = null;
			try {
				fileName = uploadedFile.getName();
				fileSize = uploadedFile.getSize();
				fileContentType = uploadedFile.getContentType();
				uploadedFileContents = new String(uploadedFile.getBytes());
				String lines[] = uploadedFileContents.split("\\r?\\n");
				scan = new Scanner(uploadedFileContents);
//				while (scan.hasNext()) {
					reset();
					input = scan.nextLine();
					if(!input.isEmpty()){
						renderTextArea=true;
					}
//				}
				return "Upload Done";
			} catch (IOException e) {
				message = e.getMessage();
				return "Fail";

			}
		}
	}

	private void resetAction() {
		// TODO Auto-generated method stub
		renderTablename=false;
		renderTableDetails=false;
		renderTabledata=false;
		renderColumnNames=false;
		renderHistChart=false;
		renderSPChart=false;
		renderRegressionResults=false;
		renderCorrResults=false;
		renderDescStatsResults=false;
		renderTextArea=false;
		
	}

	public String nextInputAction() {
		if (scan.hasNext()) {
			input = scan.nextLine();
			renderTextArea = true;
			return "Success";
		} else {
			input = "End of File";
			return "Fail";
		}
	}
	/**
	 * @param input
	 */
	public String processInputAction() {
		try{
			reset();
		if (input.toLowerCase().contains("tablelist")) {
			status = dbOperations.getTables();
			if (status == "SUCCESS") {
				renderTablename = true;
				return "SUCCESS";
			}
		}else if (input.toLowerCase().contains("use")) {
			String[] result = input.split("\t", 2);
			tableNameValue = result[1];
			String temp = dbOperations.getTables();
			if (temp == "SUCCESS") {
				renderTablename = true;
				renderTableDetails = true;
			}
			dbOperations.setTableSelected(tableNameValue);
			status = dbOperations.getTableData();
			if (status == "SUCCESS") {
				renderTabledata = true;
				return "SUCCESS";
			}
		}else if (input.toLowerCase().contains("columnlist")) {
			status = dbOperations.getColumnNames();
			if (status == "SUCCESS") {
				renderColumnNames = true;
				return "SUCCESS";
			}
		}else if (input.toLowerCase().contains("select")) {
			String[] result = input.split("\t");
			for (int i = 1; i < result.length; i++) {
				columnSelected.add(result[i]);
			}
			dbOperations.setColumnSelected(columnSelected);
			status = dbOperations.getColumnDataForScript();
			if (status == "SUCCESS") {
				renderTableDetails = true;
				renderTabledata = true;
				return "SUCCESS";
			}
		}else if (input.toLowerCase().contains("hist")) {
			String[] result = input.split("\t");
				if (result.length != 2) {
					renderErrorMessage = true;
					message = "Enter only one Numeric Variable";
				} else if (checkForNumeric(result[1])) {
					renderErrorMessage = true;
					message = "Kindly enter a numeric variable not a number";
				} else {
					String columnSelected = result[1];
					graphics.setTableSelected(tableNameValue);// add when the// whole script// is running
					statisticsBean.getTables();
					// graphics.setTableSelected("country");//remove when the
					// whole script is running.
					graphics.setChartType("5");
					graphics.setChartColumnSelected(columnSelected);
					status = graphics.generateChart();
					if (status == "SUCCESS") {
						renderTableDetails = false;
						renderHistChart = true;
						return "SUCCESS";
					} else {
						renderErrorMessage = true;
						message = "Enter Numeric Variables";
					}
				}
			} else if (input.toLowerCase().contains("scatterplot")) {
				String[] result = input.split("\t");
				if (result.length != 3) {
					renderErrorMessage = true;
					message = "Enter only two Numeric Variable";
				} else if (checkForNumeric(result[1])) {
					renderErrorMessage = true;
					message = "Kindly enter a numeric variable not a number in the place of variable 1";
				} else if (checkForNumeric(result[2])) {
					renderErrorMessage = true;
					message = "Kindly enter a numeric variable not a number in the place of variable 2";
				}else{
						graphics.setTableSelected(tableNameValue);//add when the whole script is running
//			graphics.setTableSelected("country");
						statisticsBean.setTableSelected(tableNameValue);//add when the whole script is running
//			statisticsBean.setTableSelected("country");
//			graphics.setTableSelected("country");//remove when the whole script is running.
			predictorValue=result[1];
			responseValue=result[2];
			graphics.setChartType("3");
			statisticsBean.getTables();
			graphics.setResponseValue(responseValue);
			graphics.setPredictorValue(predictorValue);
			status=graphics.generateChart();
			if (status == "SUCCESS") {
				renderTableDetails=false;
				renderSPChart = true;
				return "SUCCESS";
			}else{
				renderErrorMessage=true;
				message="Enter Numeric Variables";
			}
		}}else if (input.toLowerCase().contains("regress")) {
			String[] result = input.split("\t");
			if (result.length != 3) {
				renderErrorMessage = true;
				message = "Enter only two Numeric Variable";
			} else if (checkForNumeric(result[1])) {
				renderErrorMessage = true;
				message = "Kindly enter a numeric variable not a number in the place of variable 1";
			} else if (checkForNumeric(result[2])) {
				renderErrorMessage = true;
				message = "Kindly enter a numeric variable not a number in the place of variable 2";
			}else{
			predictorValue=result[1];
			responseValue=result[2];
			statisticsBean.getTables();
						statisticsBean.setTableSelected(tableNameValue);//add when the whole script is running
//			statisticsBean.setTableSelected("country");//remove when the whole script is running.
			statisticsBean.setPredictorValue(predictorValue);
			statisticsBean.setResponseValue(responseValue);
			status=statisticsBean.generateRegressionReport();
			if (status == "SUCCESS") {
				renderTableDetails=false;
				renderRegressionResults = true;
				return "SUCCESS";
			}else{
				renderErrorMessage=true;
				message="Enter Numeric Variables";
			}
		}}else if (input.toLowerCase().contains("corr")) {
			String[] result = input.split("\t");
			if (result.length != 3) {
				renderErrorMessage = true;
				message = "Enter only two Numeric Variable";
			} else if (checkForNumeric(result[1])) {
				renderErrorMessage = true;
				message = "Kindly enter a numeric variable not a number in the place of variable 1";
			} else if (checkForNumeric(result[2])) {
				renderErrorMessage = true;
				message = "Kindly enter a numeric variable not a number in the place of variable 2";
			}else{
			predictorValue=result[1];
			responseValue=result[2];
			statisticsBean.getTables();
			statisticsBean.setTableSelected(tableNameValue);//add when the whole script is running
			statisticsBean.setPredictorValue(predictorValue);
			statisticsBean.setResponseValue(responseValue);
			status=statisticsBean.correlateVariables();
			if (status == "SUCCESS") {
				renderTableDetails=false;
				renderCorrResults = true;
				return "SUCCESS";
			}else{
				renderErrorMessage=true;
				message="Enter Numeric variables";
			}
		}}else if (input.toLowerCase().contains("descriptivestats")) {
			statisticsBean.getTables();
						statisticsBean.setTableSelected(tableNameValue);//add when the whole script is running
//			statisticsBean.setTableSelected("country");//remove when the whole script is running.
			statisticsBean.setColumnSelected(columnSelected);//add when the whole script is running.
			statisticsBean.generateNumericColumnsForScript();
				status = statisticsBean.generateReportForScript();
				if (status == "SUCCESS") {
					if(!statisticsBean.getNumericData().isEmpty()){
						renderTableDetails=false;
						renderDescStatsResults = true;
						return "SUCCESS";	
					}else{
						renderErrorMessage=true;
						message="Please Enter Numeric Variables Only";
					}
					
				}
			} else if (input.toLowerCase().contains("export")) {
				renderTableDetails=false;
				dbAccess.writeToFile();
				return "SUCCESS";
			} else if(input.toLowerCase().contains("exit")){
				renderTableDetails=false;
				input="End of File";
			}else {
				input = "Enter a valid command";
				return "Fail";
			}
		} catch (Exception e) {
			message = e.getMessage();
			return "Fail";
		}
		return "Success";
	}
	
	private boolean checkForNumeric(String msg){
		String regex = "(.)*(\\d)(.)*";      
		Pattern pattern = Pattern.compile(regex);
		boolean containsNumber = pattern.matcher(msg).matches();
		return containsNumber;
	}
	private void reset() {
		// TODO Auto-generated method stub
		renderTablename=false;
		renderTableDetails=false;
		renderTabledata=false;
		renderColumnNames=false;
		renderHistChart=false;
		renderSPChart=false;
		renderRegressionResults=false;
		renderCorrResults=false;
		renderDescStatsResults=false;
		renderErrorMessage=false;
	}

	public UploadedFile getUploadedFile() {
		return uploadedFile;
	}

	public void setUploadedFile(UploadedFile uploadedFile) {
		this.uploadedFile = uploadedFile;
	}

	public String getUploadedFileContents() {
		return uploadedFileContents;
	}

	public void setUploadedFileContents(String uploadedFileContents) {
		this.uploadedFileContents = uploadedFileContents;
	}

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public long getFileSize() {
		return fileSize;
	}

	public void setFileSize(long fileSize) {
		this.fileSize = fileSize;
	}

	public String getFileContentType() {
		return fileContentType;
	}

	public void setFileContentType(String fileContentType) {
		this.fileContentType = fileContentType;
	}

	public String getFileLabel() {
		return fileLabel;
	}

	public void setFileLabel(String fileLabel) {
		this.fileLabel = fileLabel;
	}

	public String getFilePath() {
		return filePath;
	}

	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}

	public DbAccess getDbAccess() {
		return dbAccess;
	}

	public void setDbAccess(DbAccess dbAccess) {
		this.dbAccess = dbAccess;
	}

	public DescStatistics getDescStatistics() {
		return descStatistics;
	}

	public void setDescStatistics(DescStatistics descStatistics) {
		this.descStatistics = descStatistics;
	}

	public DbOperations getDbOperations() {
		return dbOperations;
	}

	public void setDbOperations(DbOperations dbOperations) {
		this.dbOperations = dbOperations;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public boolean isRenderTablename() {
		return renderTablename;
	}

	public void setRenderTablename(boolean renderTablename) {
		this.renderTablename = renderTablename;
	}

	public boolean isRenderTabledata() {
		return renderTabledata;
	}

	public void setRenderTabledata(boolean renderTabledata) {
		this.renderTabledata = renderTabledata;
	}

	public String getTableNameValue() {
		return tableNameValue;
	}

	public void setTableNameValue(String tableNameValue) {
		this.tableNameValue = tableNameValue;
	}

	public boolean isRenderColumnNames() {
		return renderColumnNames;
	}

	public void setRenderColumnNames(boolean renderColumnNames) {
		this.renderColumnNames = renderColumnNames;
	}

	public boolean isRenderTableDetails() {
		return renderTableDetails;
	}

	public void setRenderTableDetails(boolean renderTableDetails) {
		this.renderTableDetails = renderTableDetails;
	}

	public List<String> getColumnSelected() {
		return columnSelected;
	}

	public void setColumnSelected(List<String> columnSelected) {
		this.columnSelected = columnSelected;
	}

	public Regression getRegression() {
		return regression;
	}

	public void setRegression(Regression regression) {
		this.regression = regression;
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

	public boolean isRenderHistChart() {
		return renderHistChart;
	}

	public void setRenderHistChart(boolean renderHistChart) {
		this.renderHistChart = renderHistChart;
	}

	public String getPredictorValue() {
		return predictorValue;
	}

	public void setPredictorValue(String predictorValue) {
		this.predictorValue = predictorValue;
	}

	public String getResponseValue() {
		return responseValue;
	}

	public void setResponseValue(String responseValue) {
		this.responseValue = responseValue;
	}

	public boolean isRenderSPChart() {
		return renderSPChart;
	}

	public void setRenderSPChart(boolean renderSPChart) {
		this.renderSPChart = renderSPChart;
	}

	public boolean isRenderRegressionResults() {
		return renderRegressionResults;
	}

	public void setRenderRegressionResults(boolean renderRegressionResults) {
		this.renderRegressionResults = renderRegressionResults;
	}

	public boolean isRenderCorrResults() {
		return renderCorrResults;
	}

	public void setRenderCorrResults(boolean renderCorrResults) {
		this.renderCorrResults = renderCorrResults;
	}

	public boolean isRenderDescStatsResults() {
		return renderDescStatsResults;
	}

	public void setRenderDescStatsResults(boolean renderDescStatsResults) {
		this.renderDescStatsResults = renderDescStatsResults;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getInput() {
		return input;
	}

	public void setInput(String input) {
		this.input = input;
	}

	public boolean isRenderTextArea() {
		return renderTextArea;
	}

	public void setRenderTextArea(boolean renderTextArea) {
		this.renderTextArea = renderTextArea;
	}

	public boolean isRenderErrorMessage() {
		return renderErrorMessage;
	}

	public void setRenderErrorMessage(boolean renderErrorMessage) {
		this.renderErrorMessage = renderErrorMessage;
	}
	
}
