package com.loocc.domain;

import com.github.pagehelper.PageInfo;

import java.util.HashMap;
import java.util.Map;

/**
 * 通用的返回类
 */
public class Msg {

    //状态码
    private int code;
    //提示信息
    private String msg;
    // 用户给浏览器返回的数据
    private Map<String, Object> listEmp = new HashMap<>();

    public static Msg success(){
        Msg result = new Msg();
        result.setCode(100);
        result.setMsg("处理成功！");
        return result;
    }

    public static Msg fail(){
        Msg result = new Msg();
        result.setCode(200);
        result.setMsg("处理失败！");
        return result;
    }

    //这样就可以进行链式操作了  .add().add().add()
    public Msg add(String key,Object value){
        this.getListEmp().put(key,value);
        return this;
    }

    public int getCode() {
        return code;
    }

    public void setCode(int code) {
        this.code = code;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public Map<String, Object> getListEmp() {
        return listEmp;
    }

    public void setListEmp(Map<String, Object> listEmp) {
        this.listEmp = listEmp;
    }
}
