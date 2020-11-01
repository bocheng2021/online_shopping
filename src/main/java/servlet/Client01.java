package servlet;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.HttpURLConnection;
import java.net.URL;
/**
 * Sample code for accessing RESTful Web Service
 * *
 */
public class Client01 {

    public String connectService(String webURL) {

		String myMessage = "Scott's Message";
        
        //Suppose the service uses variable "message" to receive message.
        String myRequest = "message=" + myMessage;

        try {

            //Create URL instance with Web Service Address
            URL url = new URL(webURL);

            //Connect to the Web Service
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();

            //Setting service request mode to Post.
            conn.setRequestMethod("POST");
            conn.setDoOutput(true);

            //Send my request
            conn.getOutputStream().write(myRequest.getBytes("UTF-8"));

            //Get reply from the sevice
            conn.getInputStream();
            InputStream content = conn.getInputStream();

            //Convert input string into byte array
            byte[] buf = new byte[1024];
            ByteArrayOutputStream sb = new ByteArrayOutputStream();
            int i = 0;
            while ((i = content.read(buf)) != -1) {
                sb.write(buf, 0, i);
            }
            
            //Close the Web Serive connection
            content.close();

            //Convert the byte data into String
            String responseFromServer = sb.toString();

            return responseFromServer;

        } catch (IOException ex) {
            return null;
        }

    }
    
    public static void main(String[] args) {
        
        Client01 client01 = new Client01();
        
        //Local Host Address of service
        String myURL1 = "http://localhost:8080/online_shopping-1.0-SNAPSHOT/";
        String response1 = client01.connectService(myURL1);
        System.out.println(myURL1 + "\n");
        System.out.println(response1);
        
        //Formal IP Address of service
        String myURL2 = "http://10.129.58.172:8080/online_shopping-1.0-SNAPSHOT/";
        String response2 = client01.connectService(myURL2);
        System.out.println(myURL2 + "\n");
        System.out.println(response2);
    }
}
