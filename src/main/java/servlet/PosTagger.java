package servlet; /**
* sending request to a web Service and getting resposes.
*/
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;

public class PosTagger {
    public String callPosTaggerPost(String myMessage) {
        
		String serviceUrl = "{Add Service URL, e.g. http://www.abc.cn/}";
		
		//Suppose the service uses variable "message" to receive message.
        String myRequest = "message=" + myMessage;
        try {
            URL url = new URL(serviceUrl);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			
			//Setting service request mode to Post.
            conn.setRequestMethod("POST");
            conn.setDoOutput(true);
			
			//Send my request
            conn.getOutputStream().write(myRequest.getBytes("UTF-8"));
			
			//Get reply from the sevice
            conn.getInputStream();
            InputStream content = conn.getInputStream();

			//
            byte[] buf = new byte[1024];
            ByteArrayOutputStream sb = new ByteArrayOutputStream();
            int i = 0;
            while ((i = content.read(buf)) != -1) {
                sb.write(buf, 0, i);
            }
            content.close();
			
			//Convert the byte data into String
			String responseFromServer = sb.toString();

            return responseFromServer;

        } catch (IOException ex) {
            return null;
        }

    }
}
