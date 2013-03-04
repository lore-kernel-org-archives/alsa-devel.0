From: Yegor Yefremov <yegorslists@googlemail.com>
Subject: Re: am335x: mcasp in DIT mode
Date: Mon, 4 Mar 2013 16:56:25 +0100
Message-ID: <CAGm1_kvC7qzx3khq_JA37YzVRUOCVZd1GuEMFveanmQsyWXwLQ@mail.gmail.com>
References: <CAGm1_kt83A2i-ew_gUaySRZpMeuQPEpTvEH_xX9BvfpUKob_Ug@mail.gmail.com>
 <B5906170F1614E41A8A28DE3B8D121433ED3B63C@DBDE01.ent.ti.com>
 <51345389.2030502@gmail.com>
 <CAGm1_kuZ1XL9ubfQf4SePK9DNEWXeB1e5Cpc_rzU+6ki57KMXQ@mail.gmail.com>
 <B5906170F1614E41A8A28DE3B8D121433ED3B924@DBDE01.ent.ti.com>
 <CAGm1_ksJiVZVLLp_B==fyS0K6iMg1gVoxBvh7PynaME7SphprQ@mail.gmail.com>
 <B5906170F1614E41A8A28DE3B8D121433ED3BA43@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f54.google.com (mail-pa0-f54.google.com
 [209.85.220.54])
 by alsa0.perex.cz (Postfix) with ESMTP id 4838E265116
 for <alsa-devel@alsa-project.org>; Mon,  4 Mar 2013 16:56:48 +0100 (CET)
Received: by mail-pa0-f54.google.com with SMTP id fa10so3222515pad.41
 for <alsa-devel@alsa-project.org>; Mon, 04 Mar 2013 07:56:47 -0800 (PST)
In-Reply-To: <B5906170F1614E41A8A28DE3B8D121433ED3BA43@DBDE01.ent.ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Bedia, Vaibhav" <vaibhav.bedia@ti.com>
Cc: "Porter, Matt" <mporter@ti.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Fernandes,
 Joel A" <joelagnel@ti.com>, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

T24gTW9uLCBNYXIgNCwgMjAxMyBhdCAxMjoyNSBQTSwgQmVkaWEsIFZhaWJoYXYgPHZhaWJoYXYu
YmVkaWFAdGkuY29tPiB3cm90ZToKPiBPbiBNb24sIE1hciAwNCwgMjAxMyBhdCAxNTo1Njo0Nywg
WWVnb3IgWWVmcmVtb3Ygd3JvdGU6Cj4gWy4uLl0KPj4KPj4gSSBmb3VuZCB0aGlzIHBhc3NhZ2Ug
aW4gMjIuMy44LjMuMiBvZiB0aGUgIkFNMzM1eCBBUk3CriBDb3J0ZXjihKItQTgKPj4gTWljcm9w
cm9jZXNzb3JzIChNUFVzKSBUZWNobmljYWwgUmVmZXJlbmNlIE1hbnVhbCIgTGl0ZXJhdHVyZSBO
dW1iZXI6Cj4+IFNQUlVINzNHCj4+Cj4+IFRoZSBESVQgdHJhbnNtaXR0ZXIgb25seSB3b3JrcyBp
biB0aGUgZm9sbG93aW5nIGNvbmZpZ3VyYXRpb246Cj4+IOKAoiBJbiB0cmFuc21pdCBmcmFtZSBj
b250cm9sIHJlZ2lzdGVyIChBRlNYQ1RMKToKPj4g4oCTIEludGVybmFsbHktZ2VuZXJhdGVkIHRy
YW5zbWl0IGZyYW1lIHN5bmMsIEZTWE0gPSAxLgo+PiDigJMgUmlzaW5nLWVkZ2UgZnJhbWUgc3lu
YywgRlNYUCA9IDAuCj4+IOKAkyBCaXQtd2lkdGggZnJhbWUgc3luYywgRlhXSUQgPSAwLgo+PiDi
gJMgMzg0LXNsb3QgVERNLCBYTU9EID0gMSAxMDAwIDAwMDBiLgo+PiDigKIgSW4gdHJhbnNtaXQg
Y2xvY2sgY29udHJvbCByZWdpc3RlciAoQUNMS1hDVEwpLCBBU1lOQyA9IDEuCj4+IOKAoiBJbiB0
cmFuc21pdCBiaXRzdHJlYW0gZm9ybWF0IHJlZ2lzdGVyIChYRk1UKSwgWFNTWiA9IDExMTEgKDMy
LWJpdCBzbG90IHNpemUpLgo+Pgo+PiBTbyBzbG90IHNpemUgZG9lcyBtYXR0ZXIgZm9yIERJVCBt
b2RlLiBPbiB0aGUgc2FtZSBwYWdlIHlvdSBoYXZlIGZyYW1lCj4+IGZvcm1hdCBkZXNjcmlwdGlv
bi4gSXQgc2F5cyB0aGF0IHR3byBmb2xsb3dpbmcgcm90YXRpb24gc2V0dGluZ3MgYXJlCj4+IHZh
bGlkIGZvciBESVQgWFJPVCA9IDAxMCBhbmQgWFJPVCA9IDAwMCwgYnV0IHRoZSBvbmx5IG9uZSB3
b3JraW5nIHdpdGgKPj4gcmlnaHQtYWxpZ25lZCBkYXRhIGlzIDB4NiBpLmUuIDI0LWJpdCByb3Rh
dGlvbi4gVGhpcyB2YWx1ZSB3YXMgdXNlZCBpbgo+PiB0aGUgZGF2aW5jaS1tY2FzcC5jIGRyaXZl
ciBzb3VyY2UuCj4+Cj4KPiBPay4gU2luY2UgeW91IHNlZW0gdG8gaGF2ZSBhIGgvdyBoYW5keSwg
aWYgeW91IGhhdmUgdGltZSB0byBzcGFyZSwgY291bGQgeW91Cj4gcGxlYXNlIHRyeSBvdXQgYSBj
b25maWcgd2hpY2ggc2V0cyB0aGUgc2xvdCBzaXplIHRvIDE2IGluc3RlYWQgb2YgMzIgYW5kIGxl
dAo+IHVzIGtub3cgd2hldGhlciBpdCB3b3Jrcz8gRGVwZW5kaW5nIG9uIHRoZSB0ZXN0IHJlc3Vs
dCB3ZSdsbCBrbm93IGZvciBzdXJlCj4gd2hldGhlciB0aGUgb3JpZ2luYWwgY29kZSBldmVyIHdv
cmtlZC4KCkkndmUgbWFkZSB0ZXN0IHdpdGggWFNTWiA9PSAweDcgKDE2LWJpdCkgYW5kIEkgaGVh
cmQgc291bmQuIFNvIHRoZQppbml0aWFsIHZlcnNpb24gY291bGQgYmUgZnVuY3Rpb25hbCwgYmVj
YXVzZSBvbmx5IFhTU1ogd2FzIHRvdWNoZWQuCkxhdGVyIGNhbWUgc2V0dGluZ3MgZm9yIG1hc2sg
YW5kIHJvdGF0aW9uLiBJdCBzZWVtcyBsaWtlIHJvdGF0aW9uIGlzCnRoZSBtb3N0IGltcG9ydGFu
dCBzZXR0aW5nIGZvciBESVQuIFNvIHRoZSBUZWNobmljYWwgUmVmZXJlbmNlIE1hbnVhbApzaG91
bGQgYmUgdGhvcm91Z2hseSByZXZpc2VkOgoKMS4gWFNTWiAzMi1iaXQgaXMgbm90IG1hbmRhdG9y
eQoyLiByb3RhdGlvbiBmb3IgcmlnaHQtYWxpZ25lZCBkYXRhIG11c3QgcHJvcGVybHkgc3BlY2lm
aWVkICgweDYgLQoyNC1iaXQgYW5kIG5vdCAweDApCgpZZWdvcgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNh
LWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cDovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
