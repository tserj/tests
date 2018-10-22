


import java.io.*;
import java.util.Iterator;

import com.quiotix.html.parser.*;
import com.quiotix.html.parser.HtmlDocument.Attribute;
import org.apache.commons.httpclient.HttpMethod;
import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.HttpMethodBase;
import org.apache.commons.httpclient.methods.PostMethod;
import org.apache.commons.httpclient.methods.GetMethod;
import org.apache.commons.io.IOUtils;

/**
 * Example visitor to dump out the links from an HTML document.
 *
 * @author Brian Goetz, Quiotix
 */

public class DumpLinks extends HtmlVisitor {

  protected PrintWriter out;

  /**
   * Constructor.
   *
   * @param os OutputStream to dump to
   */
  public DumpLinks(OutputStream os)     { out = new PrintWriter(os); }

  /**
   * Constructor.
   *
   * @param os OutputStream to dump to
   */
  public DumpLinks(OutputStream os, String encoding)
    throws UnsupportedEncodingException {
    out = new PrintWriter( new OutputStreamWriter(os, encoding) );
  }

  public void finish() {
      out.flush();
  }

  public void visit(HtmlDocument.Tag t) {
    if (t.tagName.equalsIgnoreCase("A")) {
      for (Iterator i=t.attributeList.attributes.iterator(); i.hasNext(); ) {
        Attribute a = (Attribute) i.next();
        if (a.name.equalsIgnoreCase("HREF"))
          out.println(a.getValue());
      }
    }
  }

    private static String runHTTPMethod(String HTTPMethod, String url, String query, String host, String cookie, String userAgent, String acceptLanguage)
    {
        int status;
        String charset;
        String result = "";

        if (!HTTPMethod.equals("GET") && !HTTPMethod.equals("POST")) return "";

        if (url.indexOf("http://") != 0) url = "http://" + url;
        if (host.indexOf("http://") != 0) host = "http://" + host;

        if (userAgent.equals("")) userAgent = "Opera/9.27 (Windows NT 6.0; U; ru)";
        if (acceptLanguage.equals("")) acceptLanguage = "ru-RU,ru";

        HttpMethod method = null;
        if (HTTPMethod.equals("GET")) method = new GetMethod(url);
        if (HTTPMethod.equals("POST")) method = new PostMethod(url);

        if (!host.equals("http://")) method.addRequestHeader("Host", host);
        method.addRequestHeader("User-Agent", userAgent);
        method.addRequestHeader("Accept-Encoding", "deflate");
        method.addRequestHeader("Accept-Language", acceptLanguage);
        method.addRequestHeader("Accept", "text/html");
        if (cookie.length() > 0) {
            method.addRequestHeader("Cookie", cookie);
            method.addRequestHeader("Cookie2", "$Version=1");
        }
        if (query.length() > 0) method.setQueryString(query);

        HttpClient client = new HttpClient();

        try {
            int timeOut = 60000;
            client.getHttpConnectionManager().getParams().setConnectionTimeout(timeOut);

            status = client.executeMethod(method);

            charset = ((HttpMethodBase)method).getResponseCharSet();
            if (charset == null) charset = method.getParams().getContentCharset();
            if (charset == null) charset = client.getParams().getContentCharset();
            if (charset == null) charset = client.getParams().getHttpElementCharset();

            InputStream in = method.getResponseBodyAsStream();

            System.out.println("ok");
            HtmlDocument document;

            document = new HtmlParser(in).HtmlDocument();
            document.accept(new DumpLinks(System.out));
            System.out.println("ok2");
            try {
                result = IOUtils.toString(in, charset);
                System.out.println("result:" + result);
            }
            catch (Exception e) {
                //
            }
            finally {
                IOUtils.closeQuietly(in);
            }

            method.releaseConnection();
        }
        catch (Exception e) {
           //
        }

        return result;
    }

  /**
   * Runnable.
   */
  public static void main (String args[]) throws ParseException, IOException {

    File f = new File("search.htm");
      if (f.exists()) {

      FileInputStream r = new FileInputStream(f);
    HtmlDocument document;

    document = new HtmlParser(r, "utf-8").HtmlDocument();
    document.accept(new HtmlScrubber(HtmlScrubber.DEFAULT_OPTIONS | HtmlScrubber.TRIM_SPACES));
    document.accept(new DumpLinks(System.out));
      }
    //runHTTPMethod("GET", "http://www.google.com/search?q=test&sourceid=opera&num=0&ie=utf-8&oe=utf-8", "", "google.com", "", "", "");
  }
}

