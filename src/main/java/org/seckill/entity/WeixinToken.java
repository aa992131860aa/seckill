package org.seckill.entity;

public class WeixinToken {
    //{"errcode":0,"errmsg":"ok","access_token":"mmyBf2M__M_V1740Ubms2-FVvg7sielPJciHGASl5dCXvFWl91cTjtfxj6-1R51QqSif6kTSR4SW2z9y4cy9MEOVWL_gPTKhbASrLTP_E-v6tc5QKri6B4x9SAB0PWC-qoNY30TrBanyyfBjgSMq_hdyyhpMeKlOA9EeYqstkOc5G-vqMtJiowsBD3gU_3YNJU6vQprEkaXW86DIx_nuDA","expires_in":7200}

 private int errcode;
 private String errmsg;
 private String access_token;
 private long expires_in;

    public int getErrcode() {
        return errcode;
    }

    public void setErrcode(int errcode) {
        this.errcode = errcode;
    }

    public String getErrmsg() {
        return errmsg;
    }

    public void setErrmsg(String errmsg) {
        this.errmsg = errmsg;
    }

    public String getAccess_token() {
        return access_token;
    }

    public void setAccess_token(String access_token) {
        this.access_token = access_token;
    }

    public long getExpires_in() {
        return expires_in;
    }

    public void setExpires_in(long expires_in) {
        this.expires_in = expires_in;
    }
}
