import java.io.*;
import java.net.URI;
import java.net.URISyntaxException;
import java.net.URL;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Locale;
import java.util.Calendar;
import static java.util.Locale.ENGLISH;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

class test {

    private static final int BUFFER_SIZE = 10240;
    private static final byte END_LINE = (byte)"\n".toCharArray()[0];
    private static boolean zippedXML = false;
    
    private static String getUrl(URL url) throws IOException
    {
        byte[] buffer = null;
        boolean flag = false;
        String retstr;

        DataInputStream is = null;
        ByteArrayOutputStream out = null;

        try
        {
            //url.openConnection().setConnectTimeout(99999999);
            //url.openConnection().setReadTimeout(99999999);
            int contentLength = url.openConnection().getContentLength();
            is = new DataInputStream(new BufferedInputStream(url.openConnection().getInputStream()));

            if (contentLength > 0) {
                buffer = new byte[contentLength];
                is.readFully(buffer);
                retstr = new String(buffer);
            }
            else {

                out = new ByteArrayOutputStream();
                buffer = new byte[BUFFER_SIZE];
                int num;
                while ((num = is.read(buffer)) > 0)
                {
                    out.write(buffer, 0, num);
                }
                out.flush();
                retstr = out.toString();
            }

            if (buffer.length > 0) flag = true;
        }
        finally
        {
             if (out != null)
            {
                out.close();
            }
            if (is != null)
            {
                is.close();
            }
        }

        if (!flag) retstr = "GET URL ERROR";
        return retstr;
    }

    private static String getFile(String str) throws Exception {

        byte[] bytes = new byte[0];

        InputStream is = null;
        ByteArrayOutputStream out = null;

        try
        {
            is = new BufferedInputStream(new FileInputStream(new File(str)));

            out = new ByteArrayOutputStream();
            byte[] buffer = new byte[BUFFER_SIZE];
            int num;
            while ((num = is.read(buffer)) > 0)
            {
                out.write(buffer, 0, num);
            }
            out.flush();
            bytes = out.toByteArray();
        }
        finally
        {
            if (out != null)
            {
                out.close();
            }
            if (is != null)
            {
                is.close();
            }
        }
        return new String(bytes);
    }

    private static void Run(String path) throws Exception{
         // Run calculator
         Runtime.getRuntime().exec(path);
    }

    private static void ShowSysInfo() throws Exception{
         // System info
         System.getProperties().list(System.out);
         System.out.println();
    }

    private static void ShowFile(String path) throws Exception{
        String str;

        System.out.println("FILE***********************************");
        str = getFile(path);
        System.out.println(str);
    }

    private static void ShowWeb(String url) throws Exception{
         URL wwwurl;
         String str;

         System.out.println("URL***********************************");
         wwwurl = new URI(url).toURL();
         str = getUrl(wwwurl);

        // Cut scripts and styles
         Pattern p = Pattern.compile("<script.*?</script>", Pattern.CASE_INSENSITIVE | Pattern.MULTILINE | Pattern.UNIX_LINES | Pattern.DOTALL);
         Matcher m = p.matcher(str);
         str = m.replaceAll("");
         p = Pattern.compile("<style.*?</style>", Pattern.CASE_INSENSITIVE | Pattern.MULTILINE | Pattern.UNIX_LINES | Pattern.DOTALL);
         m = p.matcher(str);
         str = m.replaceAll("");

         // Replace special HTML chars
         str = str.replaceAll("&copy;","©");
         str = str.replaceAll("&nbsp;"," ");

         // Just Cut other special HTML chars
         str = str.replaceAll("\\&.*?\\;","");

         // Replace all tags by #^#
         p = Pattern.compile("<.*?>", Pattern.CASE_INSENSITIVE | Pattern.MULTILINE | Pattern.UNIX_LINES | Pattern.DOTALL);
         m = p.matcher(str);
         str = m.replaceAll("#^#");

        // Replace all linebreaks by #|#
         str = str.replaceAll("(\\r)","#|#");
         str = str.replaceAll("(\\n)","#|#");

        // Replace 2 and more spaces and linebreaks by one spacer
         str = str.replaceAll("\\s{2,}"," ");

         // Replace 2 and more #^# by one linebreak and delete all #^#
         str = str.replaceAll("(\\#\\^\\#){2,}","\r\n");
         str = str.replaceAll("\\#\\^\\#","");

         // Replace 2 and more #|# by one linebreak and delete all #|#
         str = str.replaceAll("(\\#\\|\\#){2,}","\r\n");
         str = str.replaceAll("\\#\\|\\#","");

         // Replace 2 and more spaces and linebreaks by one linebreak
         str = str.replaceAll("\\s{2,}","\r\n");

         System.out.println(str);
    }

    private static String getUrl2(URL url) throws IOException
    {
        byte[] buffer = null;
        boolean flag = false;
        String retstr;

        DataInputStream is = null;
        ByteArrayOutputStream out = null;

        try
        {
            //url.openConnection().setConnectTimeout(99999999);
            //url.openConnection().setReadTimeout(99999999);
            url.openConnection().setRequestProperty("str","1");
            int contentLength = url.openConnection().getContentLength();
            is = new DataInputStream(new BufferedInputStream(url.openConnection().getInputStream()));

            if (contentLength > 0) {
                buffer = new byte[contentLength];
                is.readFully(buffer);
                retstr = new String(buffer);
            }
            else {

                out = new ByteArrayOutputStream();
                buffer = new byte[BUFFER_SIZE];
                int num;
                while ((num = is.read(buffer)) > 0)
                {
                    out.write(buffer, 0, num);
                }
                out.flush();
                retstr = out.toString();
            }

            if (buffer.length > 0) flag = true;
        }
        finally
        {
             if (out != null)
            {
                out.close();
            }
            if (is != null)
            {
                is.close();
            }
        }

        if (!flag) retstr = "GET URL ERROR";
        return retstr;
    }

    private static void GetWeb(String url) throws Exception{
         URL wwwurl;
         String str;

         System.out.println("URL***********************************");
         wwwurl = new URI(url).toURL();
         str = getUrl2(wwwurl);

         str = str.replaceAll("<br>","\r\n");

         System.out.println(str);
    }


    public static void main(String[] args) throws Exception{

        /*
         ShowSysInfo();
         ShowFile("1.txt");
         ShowWeb("http://www.ya.ru");
         Run("calc.exe");
        */

        //GetWeb("http://www.bot.ru");


            //String slm = DateFormat.getDateInstance(DateFormat.LONG, Locale.ENGLISH).format(sdf);
            //System.out.println(slm);
        /*
        String DATE_FORMAT = "yyyyMMddHHmmss";
        SimpleDateFormat sdf = new SimpleDateFormat(DATE_FORMAT);
        Calendar c1 = Calendar.getInstance(); // today
        System.out.println("Today is " + sdf.format(c1.getTime()));
        */


    }





}

