package f18g312;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.ArrayList;

import javax.faces.bean.ManagedBean;
import javax.faces.bean.SessionScoped;
import javax.faces.context.ExternalContext;
import javax.faces.context.FacesContext;

@ManagedBean(name = "fileDownloadBean")
@SessionScoped
public class FileDownloadBean {

	private String errorMessage = "";

	public String getErrorMessage() {
		return errorMessage;
	}

	public void setErrorMessage(String errorMessage) {
		this.errorMessage = errorMessage;
	}

	public String downloadColumnData(String[] columnNames, ArrayList<String[]> result, String name) {

		errorMessage = "";
		FacesContext facesContext = FacesContext.getCurrentInstance();
		ExternalContext externalContext = facesContext.getExternalContext();
		FileOutputStream fileOutputStream = null;
		FileInputStream fileInputStream = null;
		String path = externalContext.getRealPath("/files");
		File tempFile = new File(path);
		if (!tempFile.exists()) {
			new File(path).mkdirs();
		}
		String fileName = path + "/" + name;
		File file = new File(fileName);
		StringBuffer stringBuffer = new StringBuffer();

		String[] dataRow = new String[columnNames.length];
		try {
			fileOutputStream = new FileOutputStream(fileName);
			for (int i = 0; i < columnNames.length; i++) {
				stringBuffer.append(columnNames[i] + ",");
			}
			stringBuffer.append("\n");

			fileOutputStream.write(stringBuffer.toString().getBytes());
			stringBuffer = new StringBuffer();
			for (int i = 0; i < result.size(); i++) {

				dataRow = result.get(i);
				for (int j = 0; j < columnNames.length; j++) {
					stringBuffer.append(dataRow[j] + ",");
				}
				stringBuffer.append("\n");

			}

			fileOutputStream.write(stringBuffer.toString().getBytes());
			fileOutputStream.flush();
			fileOutputStream.close();
			String mimeType = externalContext.getMimeType(fileName);
			byte b;
			externalContext.responseReset();
			externalContext.setResponseContentType(mimeType);
			externalContext.setResponseContentLength((int) file.length());
			externalContext.setResponseHeader("Content-Disposition", "attachment; filename=\"" + fileName + "\"");

			fileInputStream = new FileInputStream(file);

			OutputStream output = externalContext.getResponseOutputStream();
			while (true) {
				b = (byte) fileInputStream.read();
				if (b < 0)
					break;
				output.write(b);
			}
			facesContext.responseComplete();
			return "success";
		} catch (IOException e) {
			errorMessage = e.getMessage();
			return "fail";
		} catch (Exception e) {
			errorMessage = e.getMessage();
			return "fail";
		}
	}

	public String downloadStatsData(String[] columnNames,
			ArrayList<DescStatistics> descriptiveStatisticsBeanList, String name) {

		errorMessage = "";
		FacesContext facesContext = FacesContext.getCurrentInstance();
		ExternalContext externalContext = facesContext.getExternalContext();
		FileOutputStream fileOutputStream = null;
		FileInputStream fileInputStream = null;
		String path = externalContext.getRealPath("/files");
		File tempFile = new File(path);
		DescStatistics descriptiveStatisticsBean = new DescStatistics();
		if (!tempFile.exists()) {
			new File(path).mkdirs();
		}
		String fileName = path + "/" + name;
		File file = new File(fileName);
		StringBuffer stringBuffer = new StringBuffer();
		try {
			fileOutputStream = new FileOutputStream(fileName);
			for (int i = 0; i < columnNames.length; i++) {
				stringBuffer.append(columnNames[i] + ",");
			}
			stringBuffer.append("\n");
			fileOutputStream.write(stringBuffer.toString().getBytes());
			stringBuffer = new StringBuffer();
			for (int i = 0; i < descriptiveStatisticsBeanList.size(); i++) {
				descriptiveStatisticsBean = descriptiveStatisticsBeanList.get(i);
				stringBuffer.append(descriptiveStatisticsBean.getColumnSelected() + ",");
				stringBuffer.append(descriptiveStatisticsBean.getMean() + ",");
				stringBuffer.append(descriptiveStatisticsBean.getMinValue() + ",");
				stringBuffer.append(descriptiveStatisticsBean.getMaxValue() + ",");
				stringBuffer.append(descriptiveStatisticsBean.getMedian() + ",");
				stringBuffer.append(descriptiveStatisticsBean.getVariance() + ",");
				stringBuffer.append(descriptiveStatisticsBean.getStd() + ",");
				stringBuffer.append(descriptiveStatisticsBean.getRange() + ",");
				stringBuffer.append(descriptiveStatisticsBean.getQ1() + ",");
				stringBuffer.append(descriptiveStatisticsBean.getQ3() + ",");
				stringBuffer.append(descriptiveStatisticsBean.getIqr() + ",");
				stringBuffer.append("\n");
			}

			fileOutputStream.write(stringBuffer.toString().getBytes());
			fileOutputStream.flush();
			fileOutputStream.close();
			String mimeType = externalContext.getMimeType(fileName);
			byte b;
			externalContext.responseReset();
			externalContext.setResponseContentType(mimeType);
			externalContext.setResponseContentLength((int) file.length());
			externalContext.setResponseHeader("Content-Disposition", "attachment; filename=\"" + fileName + "\"");

			fileInputStream = new FileInputStream(file);
			OutputStream output = externalContext.getResponseOutputStream();
			while (true) {
				b = (byte) fileInputStream.read();
				if (b < 0)
					break;
				output.write(b);
			}
			facesContext.responseComplete();
			return "success";
		} catch (IOException e) {
			errorMessage = e.getMessage();
			return "fail";
		} catch (Exception e) {
			errorMessage = e.getMessage();
			return "fail";
		}
	}
}
