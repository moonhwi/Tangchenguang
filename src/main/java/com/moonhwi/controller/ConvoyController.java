package com.moonhwi.controller;

import com.mathworks.toolbox.javabuilder.MWException;
import com.mathworks.toolbox.javabuilder.MWNumericArray;
import convo.Class1;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class ConvoyController {

    @RequestMapping("/welcome")
    public String Hello(){
        return "welcome";
    }
    @RequestMapping("/test")
    public String test(){
        return "test";
    }
    @RequestMapping("/convo")
    public @ResponseBody String convo() throws MWException {
        Class1 class1=new Class1();
        Object[] a=new Object[150];
        a=class1.convo(3);
        MWNumericArray mw=(MWNumericArray)a[0];
        MWNumericArray mw1=(MWNumericArray)a[1];
        MWNumericArray mw2=(MWNumericArray)a[2];
        float array[]=mw.getFloatData();
        StringBuffer stringBuffer=new StringBuffer();
        for (float ss:array)
        {
            System.out.print(ss+" ");
            stringBuffer.append(ss);
            stringBuffer.append(",");
        }
        for (float ss:mw1.getFloatData())
        {
            System.out.print(ss+" ");
            stringBuffer.append(ss);
            stringBuffer.append(",");
        }
        for (float ss:mw2.getFloatData())
        {
            System.out.print(ss+" ");
            stringBuffer.append(ss);
            stringBuffer.append(",");
        }
        return stringBuffer.toString();
    }

}
