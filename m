From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v3 01/17] mfd: madera: Add register
 definitions for Cirrus Logic Madera codecs
Date: Mon, 3 Jul 2017 12:21:16 +0100
Message-ID: <20170703112116.zgatgnazk24qja4e@dell>
References: <1496415790-19164-1-git-send-email-rf@opensource.wolfsonmicro.com>
 <1496415790-19164-2-git-send-email-rf@opensource.wolfsonmicro.com>
 <20170703103330.uka6otpdes462eym@dell>
 <1499079166.9885.13.camel@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f48.google.com (mail-wm0-f48.google.com [74.125.82.48])
 by alsa0.perex.cz (Postfix) with ESMTP id 35C20266DAB
 for <alsa-devel@alsa-project.org>; Mon,  3 Jul 2017 13:21:19 +0200 (CEST)
Received: by mail-wm0-f48.google.com with SMTP id w126so165155926wme.0
 for <alsa-devel@alsa-project.org>; Mon, 03 Jul 2017 04:21:19 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1499079166.9885.13.camel@perches.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Joe Perches <joe@perches.com>
Cc: gnurou@gmail.com, alsa-devel@alsa-project.org, jason@lakedaemon.net, devicetree@vger.kernel.org, linus.walleij@linaro.org, patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, robh+dt@kernel.org, linux-gpio@vger.kernel.org, broonie@kernel.org, tglx@linutronix.de, Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

T24gTW9uLCAwMyBKdWwgMjAxNywgSm9lIFBlcmNoZXMgd3JvdGU6Cgo+IE9uIE1vbiwgMjAxNy0w
Ny0wMyBhdCAxMTozMyArMDEwMCwgTGVlIEpvbmVzIHdyb3RlOgo+ID4gT24gRnJpLCAwMiBKdW4g
MjAxNywgUmljaGFyZCBGaXR6Z2VyYWxkIHdyb3RlOgo+ID4gCj4gPiA+IFRoaXMgcGF0Y2ggYWRk
cyBhIGhlYWRlciBmaWxlIG9mIHJlZ2lzdGVyIGRlZmluaXRpb25zIGZvciBDaXJydXMKPiA+ID4g
TG9naWMgIk1hZGVyYSIgY2xhc3MgY29kZWNzLiBUaGVzZSBjb2RlY3MgYXJlIGFsbCBiYXNlZCBv
ZmYgYSBjb21tb24KPiA+ID4gc2V0IG9mIGhhcmR3YXJlIElQIHNvIGhhdmUgYSBjb21tb24gcmVn
aXN0ZXIgbWFwICh3aXRoIGEgZmV3IG1pbm9yCj4gPiA+IGRldmljZS10by1kZXZpY2UgdmFyaWF0
aW9ucykuIFRoZXNlIGFyZSBjb21wbGV4IGRldmljZXMgd2l0aCBhIGxhcmdlCj4gPiA+IG51bWJl
ciBvZiBmZWF0dXJlcyBhbmQgc28gaGF2ZSBhIGNvcnJlc3BvbmRpbmdseSBsYXJnZSByZWdpc3Rl
ciBzZXQuCj4gPiA+IFRoZSByZWdpc3RlcnMuaCBmaWxlIGhhcyBiZWVuIGF1dG8tZ2VuZXJhdGVk
IGZyb20gdGhlIGhhcmR3YXJlIHJlZ2lzdGVyCj4gPiA+IGRlZmluaXRpb25zLCBzdHJpcHBlZCBk
b3duIHRvIG9ubHkgcmVnaXN0ZXJzIHdlIG5lZWQgdG8gYWNjZXNzIGZyb20KPiA+ID4gdGhlIGRy
aXZlcgo+ID4gPiAKPiA+ID4gU2lnbmVkLW9mZi1ieTogUmljaGFyZCBGaXR6Z2VyYWxkIDxyZkBv
cGVuc291cmNlLndvbGZzb25taWNyby5jb20+Cj4gPiA+IC0tLQo+ID4gPiBDaGFuZ2VzIHNpbmNl
IFYyOgo+ID4gPiAtIFVzZWQgbmV3IGZpZWxkIG5hbWVzIGZvciBJUlExX1NUQVRVU18zMyByZWdp
c3Rlcgo+ID4gPiAKPiA+ID4gIE1BSU5UQUlORVJTICAgICAgICAgICAgICAgICAgICAgICAgICB8
ICAgMTAgKwo+ID4gPiAgaW5jbHVkZS9saW51eC9tZmQvbWFkZXJhL3JlZ2lzdGVycy5oIHwgODgz
MiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrCj4gPiA+ICAyIGZpbGVzIGNoYW5n
ZWQsIDg4NDIgaW5zZXJ0aW9ucygrKQo+ID4gPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGluY2x1ZGUv
bGludXgvbWZkL21hZGVyYS9yZWdpc3RlcnMuaAo+ID4gCj4gPiBBcHBsaWVkLCB0aGFua3MuCj4g
Cj4gZm9sbG93ZWQgYnkgNDAwayBvZiB1c2VsZXNzIHF1b3RlZCByZXBseSEhIQo+IAo+IExlZS4g
IFNlcmlvdXNseS4gIERvbid0IGJlIGltcG9saXRlIHRvIG90aGVycy4KPiBSZW1lbWJlciB0byB0
cmltICB5b3VyIHJlcGxpZXMuCgoiQXBwbGllZCwgdGhhbmtzIiBpcyAqb2J2aW91c2x5KiB0aGUg
bGFzdCBtZXNzYWdlIGluIG15IHJlcGx5LiAgRGlkCnlvdSB3YXN0ZSBhbnkgdGltZSByZWFkaW5n
IHBhc3QgdGhhdCwgb3IgYXJlIHlvdSBqdXN0IGJlaW5nIHBlZGFudGljPwoKSWYgeW91IGFyZSB0
cnVseSBjb25jZXJuZWQgb3ZlciA0MDBrIG9mIGJhbmR3aWR0aCB5b3UgbmVlZCB0byBzd2l0Y2gK
dG8gYSBuZXcgaW50ZXJuZXQgcHJvdmlkZXIuCgpUaGlzIGlzbid0IHRoZSAxOTgwcy4KCi0tIApM
ZWUgSm9uZXMKTGluYXJvIFNUTWljcm9lbGVjdHJvbmljcyBMYW5kaW5nIFRlYW0gTGVhZApMaW5h
cm8ub3JnIOKUgiBPcGVuIHNvdXJjZSBzb2Z0d2FyZSBmb3IgQVJNIFNvQ3MKRm9sbG93IExpbmFy
bzogRmFjZWJvb2sgfCBUd2l0dGVyIHwgQmxvZwpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNhLWRldmVsQGFs
c2EtcHJvamVjdC5vcmcKaHR0cDovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2Fsc2EtZGV2ZWwK
