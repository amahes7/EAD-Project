package f18g312;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;

import javax.annotation.ManagedBean;
import javax.faces.bean.SessionScoped;
import javax.faces.context.FacesContext;

import org.apache.myfaces.custom.fileupload.UploadedFile;
@ManagedBean("fileImport")
@SessionScoped
public class FileImport {
	private UploadedFile uploadedFile;
	private String uploadedFileContents;
	private String fileName;
	private long fileSize;
	private String fileContentType;

	public String processFileUpload() {
		uploadedFileContents = null;
		FacesContext context = FacesContext.getCurrentInstance();
		// assumes folder temp exists in WebContent
		String path = context.getExternalContext().getRealPath("/temp");
		File tempFile = null;
		FileOutputStream fos = null;
		// set codes, counts
		try {
			fileName = uploadedFile.getName();
			fileSize = uploadedFile.getSize();
			fileContentType = uploadedFile.getContentType();
			// next line if want upload in String for memory processing
			// uploadedFileContents =
			// new String(uploadedFile.getBytes());
			tempFile = new File(path + "/" + fileName);
			fos = new FileOutputStream(tempFile);
			// next line if want file uploaded to disk
			fos.write(uploadedFile.getBytes());
			fos.close();
			// process file contents
		} // end try
		catch (IOException e) {
		} // end catch
		if (uploadedFileContents != null)
			; // do something
		return "SUCCESS"; // as appropriate
	}
}
