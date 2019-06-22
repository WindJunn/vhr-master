package org.sang;

public class Test {

    public static void main(String[] args) {

        String htmlContent = "<p>12</p>\n" +
                "<p><img src=\"http://localhost:8082/img/virtual/2a4721a6a3f8479f82ea8314065a7bd4.png\" alt=\"炉石.png\" /></p>\n" +
                "<p>12</p>\n";
//<div align="center">
        if (htmlContent.contains("<img")){
        }
        int width= 400;
        int height= 300;

        String img = "<div align=\"center\"><img width=\""+width+"\" height=\""+height+"\"";
        String replace = htmlContent.replace("<img", img);
         replace = replace.replace("/>", "/></div>");


        System.out.println(replace);
    }
}
