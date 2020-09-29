package com.spboot.mvcdemo;

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
    @RequestMapping("/convo")
    public @ResponseBody String convo(@RequestParam int paramA ,@RequestParam int paramB) throws MWException {
        Class1 class1=new Class1();
        Object[] a=new Object[150];
        a=class1.convo(1,paramA,paramB);
        MWNumericArray mw=(MWNumericArray)a[0];
        float array[]=mw.getFloatData();
        StringBuffer stringBuffer=new StringBuffer();
        for (float ss:array)
        {
            System.out.print(ss+" ");
            stringBuffer.append(ss);
            stringBuffer.append(",");
        }
        return stringBuffer.toString();
    }

}
