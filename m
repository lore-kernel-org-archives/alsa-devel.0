From: =?UTF-8?Q?Giedrius_Trainavi=C4=8Dius?= <giedrius.trainavicius@gmail.com>
Subject: Re: Stream format conversion in SoC driver
Date: Thu, 29 Dec 2016 16:32:26 +0200
Message-ID: <CABpuRUOppLmT+KFSPJOaxo6EtaoTeM9UnHBOVwkn=DbwN0MPDg@mail.gmail.com>
References: <CABpuRUPg8LC_+eFL3UBS-jWkQicpKmorvzhqjZW6p8xQ9P0ppw@mail.gmail.com>
 <089A4555-3272-4E65-8AD6-412B41017ACA@ladisch.de>
 <CABpuRUMfB+VvwpqMz7mc_q1RCYR5RS-FjQ8czVXUYeW70y_V7A@mail.gmail.com>
 <88898566-E09E-49FF-99D7-5EC03120FB87@ladisch.de>
 <CABpuRUM-n9b0NTivk-2zBsuvL5O-f9PXLeQoc6wW=YhrxndABQ@mail.gmail.com>
 <C1F64983-FEE0-4CA8-A623-9315B4D155EF@ladisch.de>
 <CABpuRUM-SHzVrGuoyWKicQdhmDgOFEa0NH6CiAiXFum16BtN2A@mail.gmail.com>
 <16CD146D-B2B1-420B-8680-3A6FCD0B4BA6@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ua0-f193.google.com (mail-ua0-f193.google.com
 [209.85.217.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 85064266539
 for <alsa-devel@alsa-project.org>; Thu, 29 Dec 2016 15:32:28 +0100 (CET)
Received: by mail-ua0-f193.google.com with SMTP id v2so6309920uac.3
 for <alsa-devel@alsa-project.org>; Thu, 29 Dec 2016 06:32:28 -0800 (PST)
In-Reply-To: <16CD146D-B2B1-420B-8680-3A6FCD0B4BA6@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

VGhlIEkyUyBhbmQgRE1BIGZvcm1hdCBhc3ltbWV0cnkgc291bmRzIGxpa2Ugd2hhdCBJJ2QgYmUg
YWZ0ZXIuIERvIHlvdSBoYXZlCmFueSBwb2ludGVycyBmb3IgQVBJcyAvIGtleXdvcmRzIHRvIGxv
b2sgYXJvdW5kIGZvciBpbiB0aGUgY29kZSB0byBzZWUgaG93CnRoaXMgc2hvdWxkIGJlIHNldCB1
cD8gSXMgc3VjaCBmb3JtYXQgY29udmVyc2lvbiBzdXBwb3NlZCB0byBiZSBoYXBwZW5pbmcKaW4g
aGFyZHdhcmUgaXRzZWxmLCBvciB0aGUgQ1BVIHdoZW4gYWNjZXNzaW5nIHRoZSBETUEgYnVmZmVy
IGhhcyB0aGUgY2hhbmNlCnRvIGRvIHRoZSBjb252ZXJzaW9uPwoKVGhlIHJlbGV2YW50IGRvY3Vt
ZW50YXRpb24gYW5kIGNvZGUgSSBmb3VuZCBzbyBmYXIgd291bGQgYmU6CgpodHRwczovL3d3dy5y
YXNwYmVycnlwaS5vcmcvZG9jdW1lbnRhdGlvbi9oYXJkd2FyZS8KcmFzcGJlcnJ5cGkvYmNtMjgz
NS9CQ00yODM1LUFSTS1QZXJpcGhlcmFscy5wZGYKaHR0cHM6Ly9naXRodWIuY29tL3Jhc3BiZXJy
eXBpL2xpbnV4L2Jsb2IvcnBpLTQuCjQueS9zb3VuZC9zb2MvYmNtL2JjbTI4MzUtaTJzLmMKCkkg
Y2FuJ3QgbG9jYXRlIGFueSByZWxldmFudCBiaXRzIG9mIGNvZGUgb3IgaW5mb3JtYXRpb24gdGhh
dCdkIGluZGljYXRlCmNhcGFiaWxpdGllcyBvZiBzYW1wbGUgZm9ybWF0IGNvbnZlcnNpb24uLi4K
ClRoYW5rIHlvdSwKR2llZHJpdXMuCgpPbiBUaHUsIERlYyAyOSwgMjAxNiBhdCA3OjUzIEFNLCBD
bGVtZW5zIExhZGlzY2ggPGNsZW1lbnNAbGFkaXNjaC5kZT4gd3JvdGU6Cgo+IEdpZWRyaXVzIFRy
YWluYXZpxI1pdXMgd3JvdGU6Cj4gPkl0IHVzZXMgSTJTIGZvciBzZW5kaW5nIC8gcmVjZWl2aW5n
IGF1ZGlvLiBIb3dldmVyLCB0aGUgbWFzdGVyIGNsb2NrIG9uCj4gb3VyCj4gPnNvdW5kIGNhcmQg
aXMgZ2VuZXJhdGVkIGJ5IHRoZSBBREMsIHdoaWNoIHN1cHBvcnRzIG9ubHkgMjQgYml0IGRhdGEs
IHNvCj4gPmdldHRpbmcgb3RoZXIgc2FtcGxlIGZvcm1hdHMgaXMgbm90IHBvc3NpYmxlLgo+Cj4g
VGhlIEkyUyBzYW1wbGUgZm9ybWF0IG5lZWQgbm90IGJlIHRoZSBzYW1lIGFzIHdoYXQgdGhlIERN
QQo+IGNvbnRyb2xsZXIgcmVhZHMvd3JpdGVzIGZyb20vdG8gbWVtb3J5Lgo+Cj4gPkEgcXVlc3Rp
b24gb24gJ3BsdWcnIC0gaXQgYWNjZXB0cyAnbmVhcmVzdCcgYXMgdGhlIGFyZ3VtZW50IGZvciBm
b3JtYXQsCj4gPnJhdGUsIHdoYXQgaGFwcGVucyBpbiBjYXNlIHRoZSBzbGF2ZSBwY20gc3RyZWFt
IHN1cHBvcnRzIHRoZSBleGFjdCBzYW1lCj4gPmZvcm1hdCBhcyByZXF1ZXN0ZWQgYnkgdXNlciBz
b2Z0d2FyZT8KPgo+IFRoZSBwbHVnIHBsdWdpbiBpbnN0YW50aWF0ZXMgdGhlIGFjdHVhbCBjb252
ZXJzaW9uIHBsdWdpbnMgb25seQo+IGFzIG5lZWRlZDsgd2l0aCBubyBjb252ZXJzaW9uLCBpdCB2
YW5pc2hlcyBlbnRpcmVseS4KPgo+Cj4gUmVnYXJkcywKPiBDbGVtZW5zCj4KPgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcg
bGlzdApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cDovL21haWxtYW4uYWxzYS1wcm9q
ZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
