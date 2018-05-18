From: Muni Sekhar <munisekharrms@gmail.com>
Subject: sound: latency and synchronization measurements
Date: Fri, 18 May 2018 18:07:29 +0530
Message-ID: <CAHhAz+hFFYqz2gtVnEZVyMjAO3fe4f5EtZeFO4tvO-2W-6sv7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ot0-f170.google.com (mail-ot0-f170.google.com
 [74.125.82.170])
 by alsa0.perex.cz (Postfix) with ESMTP id B9E09266F88
 for <alsa-devel@alsa-project.org>; Fri, 18 May 2018 14:37:32 +0200 (CEST)
Received: by mail-ot0-f170.google.com with SMTP id l13-v6so8888710otk.9
 for <alsa-devel@alsa-project.org>; Fri, 18 May 2018 05:37:32 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel <alsa-devel@alsa-project.org>, linux-sound@vger.kernel.org, kernelnewbies <kernelnewbies@kernelnewbies.org>
List-Id: alsa-devel@alsa-project.org

WyBQbGVhc2Uga2VlcCBtZSBpbiBDQyBhcyBJJ20gbm90IHN1YnNjcmliZWQgdG8gdGhlIGxpc3Rd
CgpIaSBBbGwsCgpJIGFtIHRyeWluZyB0byBjaGFyYWN0ZXJpemUgdGhlIGF1ZGlvIHN5bmNocm9u
aXphdGlvbiBiZXR3ZWVuIHR3bwpzeXN0ZW1zLiBUaGVyZSBpcyBhIG1lY2hhbmlzbSB0byByb3V0
ZSBhdWRpbyBiZXR3ZWVuIHR3byBzeXN0ZW1zLCB3ZQpydW4g4oCYYXBsYXnigJkgYXQgb25lIHN5
c3RlbSBhbmQg4oCYYXJlY29yZOKAmSBpbiBvdGhlciBzeXN0ZW0uCgpXZSBuZWVkIHRvIG1lYXN1
cmUgdGhlIHRpbWUgZGlmZmVyZW5jZSB3aGVuIGF1ZGlvIHNhbXBsZSBpcyBvdXQgYXQgb25lCnBv
cnQgYW5kIGFycml2aW5nIGF0IGFub3RoZXIgcG9ydCBpbiBkaWZmZXJlbnQgc3lzdGVtLgoKSSBw
bGFuIHRvIGFkZCBwcmludGvigJlzIGluIOKAnHN0cnVjdCBzbmRfcGNtX29wc+KAnSBjYWxsIGJh
Y2tzLCBidXQgZG9lcwp0aGVzZSBjYWxsIGJhY2tzIHRlbGxzIHdoZW4gaXQgcmVjZWl2ZWQgZmly
c3QgYW5kIGxhc3QgYXVkaW8KZnJhbWVzXHNhbXBsZXM/CgpPciBlbHNlIHBsZWFzZSBzdWdnZXN0
IGFueSBvdGhlciBiZXN0IG1ldGhvZC4KCgotLSAKVGhhbmtzLApTZWtoYXIKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KQWxzYS1kZXZlbCBtYWlsaW5nIGxp
c3QKQWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0dHA6Ly9tYWlsbWFuLmFsc2EtcHJvamVj
dC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVsCg==
