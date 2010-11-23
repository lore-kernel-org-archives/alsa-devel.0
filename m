From: Denis Kup <dener.kup@gmail.com>
Subject: Re: [PATCH] Acer 7730G support update.
Date: Tue, 23 Nov 2010 11:29:44 +0300
Message-ID: <AANLkTimV28hkDpB3R48=nFSQqnh4YD_HNYp--Ha22LH1@mail.gmail.com>
References: <AANLkTimmcm6OcsPrB59ovYFonv5g=yrOu3_aW31UHHrO@mail.gmail.com>
	<s5hr5edrgim.wl%tiwai@suse.de>
	<AANLkTinXrkHOfmsuCmv3xTx8nG5sogY75=w399F=tZmP@mail.gmail.com>
	<s5h39qtva6e.wl%tiwai@suse.de>
	<AANLkTin71oqTOe6Wi-DgzAhgonafvt=_RyAzpuxAagwt@mail.gmail.com>
	<s5hsjyttuho.wl%tiwai@suse.de>
	<AANLkTi=MxLsPOrNmR7agJGnzbWE11kMyR5+n+MT5dtzW@mail.gmail.com>
	<s5hmxp1tsm9.wl%tiwai@suse.de>
	<AANLkTikHStk=zY8SXHGasRupa-xfnD2Qaq74_5cDBhfQ@mail.gmail.com>
	<s5h39qttnwg.wl%tiwai@suse.de>
	<AANLkTinYhR6eKgdt7aqPTdAhbHb3srdwrmFt=gBV51Xb@mail.gmail.com>
	<s5hk4k5qslj.wl%tiwai@suse.de>
	<AANLkTim8Xpf8+PMatXZ0o04JL+-axVdUJj4P60OWB+wV@mail.gmail.com>
	<s5h1v6cr0oe.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001636c5b237c50d740495b42c18
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51]) by alsa0.perex.cz (Postfix) with ESMTP id 0F1022440E
	for <alsa-devel@alsa-project.org>; Tue, 23 Nov 2010 09:29:44 +0100 (CET)
Received: by fxm10 with SMTP id 10so878986fxm.38
	for <alsa-devel@alsa-project.org>; Tue, 23 Nov 2010 00:29:44 -0800 (PST)
In-Reply-To: <s5h1v6cr0oe.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Alsa Developers Maillist <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

--001636c5b237c50d740495b42c18
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

That is it:

Acer 7730G support patch.

Changes:
1) Fixes automatic EAPD configuration on Acer 7730G laptop.

Signed-off-by: Denis Kuplyakov <dener.kup@gmail.com>
23.11.10 08:29

2010/11/23 Takashi Iwai <tiwai@suse.de>:
> At Mon, 22 Nov 2010 19:09:32 +0300,
> Denis Kup wrote:
>>
>> I have downloaded file normally. I found that all tabs was converted
>> to spaces in patch file. So I am sending new version.
>
> Thanks. =A0Could you give a proper changelog and your sign-off?
> Otherwise it can't be applied to the upstream.
>
> The change itself looks fine to me.
>
>
> Takashi
>

--001636c5b237c50d740495b42c18
Content-Type: application/octet-stream; name=patch
Content-Disposition: attachment; filename=patch
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gguiwgwu0

LS0tIC4vYS9wYXRjaF9yZWFsdGVrLmMJMjAxMC0xMS0yMiAwMjoxODo1Ni4wMDAwMDAwMDAgKzAz
MDAKKysrIC4vYi9wYXRjaF9yZWFsdGVrLmMJMjAxMC0xMS0wNyAwMTozNjoxOS4wMDAwMDAwMDAg
KzAzMDAKQEAgLTIwMTQsNiArMjAxNCwzNiBAQCBzdGF0aWMgc3RydWN0IGhkYV92ZXJiIGFsYzg4
OF9hY2VyX2FzcGlyCiB9OwogCiAvKgorICpBTEM4ODggQWNlciBBc3BpcmUgNzczMEcgbW9kZWwK
KyAqLworCitzdGF0aWMgc3RydWN0IGhkYV92ZXJiIGFsYzg4OF9hY2VyX2FzcGlyZV83NzMwR192
ZXJic1tdID0geworLyogQmlhcyB2b2x0YWdlIG9uIGZvciBleHRlcm5hbCBtaWMgcG9ydCAqLwor
CXsweDE4LCBBQ19WRVJCX1NFVF9QSU5fV0lER0VUX0NPTlRST0wsIFBJTl9JTiB8IFBJTl9WUkVG
ODB9LAorLyogRnJvbnQgTWljOiBzZXQgdG8gUElOX0lOIChlbXB0eSBieSBkZWZhdWx0KSAqLwor
CXsweDEyLCBBQ19WRVJCX1NFVF9QSU5fV0lER0VUX0NPTlRST0wsIFBJTl9JTn0sCisvKiBVbnNl
bGVjdCBGcm9udCBNaWMgYnkgZGVmYXVsdCBpbiBpbnB1dCBtaXhlciAzICovCisJezB4MjIsIEFD
X1ZFUkJfU0VUX0FNUF9HQUlOX01VVEUsIEFNUF9JTl9NVVRFKDB4Yil9LAorLyogRW5hYmxlIHVu
c29saWNpdGVkIGV2ZW50IGZvciBIUCBqYWNrICovCisJezB4MTUsIEFDX1ZFUkJfU0VUX1VOU09M
SUNJVEVEX0VOQUJMRSwgQUxDODgwX0hQX0VWRU5UIHwgQUNfVVNSU1BfRU59LAorLyogRW5hYmxl
IHNwZWFrZXIgb3V0cHV0ICovCisJezB4MTQsIEFDX1ZFUkJfU0VUX1BJTl9XSURHRVRfQ09OVFJP
TCwgUElOX09VVH0sCisJezB4MTQsIEFDX1ZFUkJfU0VUX0FNUF9HQUlOX01VVEUsIEFNUF9PVVRf
VU5NVVRFfSwKKwl7MHgxNCwgQUNfVkVSQl9TRVRfRUFQRF9CVExFTkFCTEUsIDJ9LAorLyogRW5h
YmxlIGhlYWRwaG9uZSBvdXRwdXQgKi8KKwl7MHgxNSwgQUNfVkVSQl9TRVRfUElOX1dJREdFVF9D
T05UUk9MLCBQSU5fT1VUIHwgUElOX0hQfSwKKwl7MHgxNSwgQUNfVkVSQl9TRVRfQU1QX0dBSU5f
TVVURSwgQU1QX09VVF9VTk1VVEV9LAorCXsweDE1LCBBQ19WRVJCX1NFVF9DT05ORUNUX1NFTCwg
MHgwMH0sCisJezB4MTUsIEFDX1ZFUkJfU0VUX0VBUERfQlRMRU5BQkxFLCAyfSwKKy8qRW5hYmxl
IGludGVybmFsIHN1Yndvb2ZlciAqLworCXsweDE3LCBBQ19WRVJCX1NFVF9QSU5fV0lER0VUX0NP
TlRST0wsIFBJTl9PVVR9LAorCXsweDE3LCBBQ19WRVJCX1NFVF9BTVBfR0FJTl9NVVRFLCBBTVBf
T1VUX1VOTVVURX0sCisJezB4MTcsIEFDX1ZFUkJfU0VUX0NPTk5FQ1RfU0VMLCAweDAyfSwKKwl7
MHgxNywgQUNfVkVSQl9TRVRfRUFQRF9CVExFTkFCTEUsIDJ9LAorCXsgfQorfTsKKworLyoKICAq
IEFMQzg4OSBBY2VyIEFzcGlyZSA4OTMwRyBtb2RlbAogICovCiAKQEAgLTIyMDAsNiArMjIzMCwx
NiBAQCBzdGF0aWMgdm9pZCBhbGM4ODhfYWNlcl9hc3BpcmVfNjUzMGdfc2V0CiAJc3BlYy0+YXV0
b2NmZy5zcGVha2VyX3BpbnNbMl0gPSAweDE3OwogfQogCitzdGF0aWMgdm9pZCBhbGM4ODhfYWNl
cl9hc3BpcmVfNzczMGdfc2V0dXAoc3RydWN0IGhkYV9jb2RlYyAqY29kZWMpCit7CisJc3RydWN0
IGFsY19zcGVjICpzcGVjID0gY29kZWMtPnNwZWM7CisKKwlzcGVjLT5hdXRvY2ZnLmhwX3BpbnNb
MF0gPSAweDE1OworCXNwZWMtPmF1dG9jZmcuc3BlYWtlcl9waW5zWzBdID0gMHgxNDsKKwlzcGVj
LT5hdXRvY2ZnLnNwZWFrZXJfcGluc1sxXSA9IDB4MTY7CisJc3BlYy0+YXV0b2NmZy5zcGVha2Vy
X3BpbnNbMl0gPSAweDE3OworfQorCiBzdGF0aWMgdm9pZCBhbGM4ODlfYWNlcl9hc3BpcmVfODkz
MGdfc2V0dXAoc3RydWN0IGhkYV9jb2RlYyAqY29kZWMpCiB7CiAJc3RydWN0IGFsY19zcGVjICpz
cGVjID0gY29kZWMtPnNwZWM7CkBAIC05NTI0LDEzICs5NTY0LDYgQEAgc3RhdGljIHN0cnVjdCBo
ZGFfdmVyYiBhbGM4ODNfYWNlcl9lYXBkXwogCXsgfQogfTsKIAotc3RhdGljIHN0cnVjdCBoZGFf
dmVyYiBhbGM4ODhfYWNlcl9hc3BpcmVfNzczMEdfdmVyYnNbXSA9IHsKLQl7MHgxNSwgQUNfVkVS
Ql9TRVRfQ09OTkVDVF9TRUwsIDB4MDB9LAotCXsweDE3LCBBQ19WRVJCX1NFVF9DT05ORUNUX1NF
TCwgMHgwMn0sCi0JezB4MTUsIEFDX1ZFUkJfU0VUX1VOU09MSUNJVEVEX0VOQUJMRSwgQUxDODgw
X0hQX0VWRU5UIHwgQUNfVVNSU1BfRU59LAotCXsgfSAvKiBlbmQgKi8KLX07Ci0KIHN0YXRpYyB2
b2lkIGFsYzg4OF82c3RfZGVsbF9zZXR1cChzdHJ1Y3QgaGRhX2NvZGVjICpjb2RlYykKIHsKIAlz
dHJ1Y3QgYWxjX3NwZWMgKnNwZWMgPSBjb2RlYy0+c3BlYzsKQEAgLTEwMzI4LDcgKzEwMzYxLDcg
QEAgc3RhdGljIHN0cnVjdCBhbGNfY29uZmlnX3ByZXNldCBhbGM4ODJfcAogCQkuY29uc3RfY2hh
bm5lbF9jb3VudCA9IDYsCiAJCS5pbnB1dF9tdXggPSAmYWxjODgzX2NhcHR1cmVfc291cmNlLAog
CQkudW5zb2xfZXZlbnQgPSBhbGNfYXV0b211dGVfYW1wX3Vuc29sX2V2ZW50LAotCQkuc2V0dXAg
PSBhbGM4ODhfYWNlcl9hc3BpcmVfNjUzMGdfc2V0dXAsCisJCS5zZXR1cCA9IGFsYzg4OF9hY2Vy
X2FzcGlyZV83NzMwZ19zZXR1cCwKIAkJLmluaXRfaG9vayA9IGFsY19hdXRvbXV0ZV9hbXAsCiAJ
fSwKIAlbQUxDODgzX01FRElPTl0gPSB7Cg==
--001636c5b237c50d740495b42c18
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--001636c5b237c50d740495b42c18--
