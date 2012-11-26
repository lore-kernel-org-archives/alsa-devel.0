From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [PATCH] ALSA: usb - Don't create "Speaker" mixer
 controls on headphones and headsets
Date: Mon, 26 Nov 2012 16:26:02 +0100
Message-ID: <50B38A0A.2010505@canonical.com>
References: <1353674935-4215-1-git-send-email-david.henningsson@canonical.com>
 <CAN8cciboDbGx6Ua6d25vsM=85EiuvN+ZEruNYNCmx+byTrgnvQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id B43B92650D1
 for <alsa-devel@alsa-project.org>; Mon, 26 Nov 2012 16:26:02 +0100 (CET)
In-Reply-To: <CAN8cciboDbGx6Ua6d25vsM=85EiuvN+ZEruNYNCmx+byTrgnvQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Raymond Yau <superquad.vortex2@gmail.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, zonque@gmail.com
List-Id: alsa-devel@alsa-project.org

T24gMTEvMjYvMjAxMiAwNDoyMSBQTSwgUmF5bW9uZCBZYXUgd3JvdGU6Cj4KPiAyMDEyLTExLTIz
IOS4i+WNiDg6NDkg5pa8ICJEYXZpZCBIZW5uaW5nc3NvbiIKPiA8ZGF2aWQuaGVubmluZ3Nzb25A
Y2Fub25pY2FsLmNvbQo+IDxtYWlsdG86ZGF2aWQuaGVubmluZ3Nzb25AY2Fub25pY2FsLmNvbT4+
IOWvq+mBk++8mgo+ICA+Cj4gID4gQSBsb3Qgb2YgaGVhZHNldHMvaGVhZHBob25lcyBoYXZlIGEg
IlNwZWFrZXIiIG1peGVyIGNvbnRyb2wuIFRoaXMKPiBjb25mdXNlcwo+ICA+IFB1bHNlQXVkaW8g
dG8gdGhpbmsgaXQgaXMgYSBzcGVha2VyIGluc3RlYWQgb2YgYSBoZWFkcGhvbmUvaGVhZHNldC4K
PiAgPiBUaGVyZm9yZSwgd2UgcmVuYW1lIGl0IHRvICJIZWFkcGhvbmUiLgo+ICA+Cj4gID4gV2Ug
ZGV0ZXJtaW5lIGlmIHNvbWV0aGluZyBpcyBhIGhlYWRwaG9uZSBzaW1pbGFyIHRvIGhvdyB1ZGV2
IGRldGVybWluZXMKPiAgPiBmb3JtIGZhY3RvciAoc2VlIDc4LXNvdW5kLWNhcmQucnVsZXMpLgo+
Cj4gZG9lcyBpdCByZWFsbHkgZml4IHRoZSBwcm9ibGVtCgpJdCBmaXhlcyBhIHByb2JsZW0gd2l0
aCBhIGNvbW1vbiBjbGFzcyBvZiBMb2dpdGVjaCBzdGVyZW8gaGVhZHNldHMuCgo+IHNpbmNlIHRo
ZXJlIGFyZQo+Cj4gMSkgdXNiIGhlYWRzZXRzIHdoaWNoIGhhcyAiUENNIiB2b2x1bWUgY29udHJv
bAo+IDIpIHNvbWUgdXNiIGhlYWRwaG9uZSBzdXBwb3J0IDUuMQoKVGhlc2UgZGV2aWNlcyBhcmUg
dW5saWtlbHkgdG8gYmUgYWZmZWN0ZWQgYnkgdGhlIHBhdGNoLiBJZiB5b3UgaGF2ZSBhIApwcm9i
bGVtIHdpdGggYW55IG9mIHRoZXNlIGRldmljZXMsIGl0J3MgYSBkaWZmZXJlbnQgYnVnLgoKCi0t
IApEYXZpZCBIZW5uaW5nc3NvbiwgQ2Fub25pY2FsIEx0ZC4KaHR0cHM6Ly9sYXVuY2hwYWQubmV0
L35kaXdpYwpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpB
bHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cDov
L21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
