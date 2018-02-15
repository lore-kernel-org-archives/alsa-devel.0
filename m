From: Tobias Bora <tobias.bora@gmail.com>
Subject: Problem with microphone of ALC3236
Date: Thu, 15 Feb 2018 15:23:34 +0100
Message-ID: <680665f9-959e-5206-7d6b-3b12d4124f88@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f51.google.com (mail-wm0-f51.google.com [74.125.82.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 2DD90266E42
 for <alsa-devel@alsa-project.org>; Thu, 15 Feb 2018 15:23:35 +0100 (CET)
Received: by mail-wm0-f51.google.com with SMTP id j199so1158805wmj.2
 for <alsa-devel@alsa-project.org>; Thu, 15 Feb 2018 06:23:35 -0800 (PST)
Received: from [172.28.44.240]
 (roam-nat-fw-prg-194-254-61-44.net.univ-paris-diderot.fr. [194.254.61.44])
 by smtp.googlemail.com with ESMTPSA id o6sm6849579edj.65.2018.02.15.06.23.34
 for <alsa-devel@alsa-project.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 15 Feb 2018 06:23:34 -0800 (PST)
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

SGVsbG8sCgpJJ3ZlIGJlZW4gaGF2aW5nIGxvdCdzIG9mIHRyb3VibGVzIHdpdGggdGhlIG1pY3Jv
cGhvbmVzIHdpdGggbXkgQUxDMzIzNgpzb3VuZCBjYXJkLiBCeSBkZWZhdWx0ICh0ZXN0ZWQgb24g
dWJ1bnR1LCBmZWRvcmEsIGFuZCBjdXJyZW50bHkgb24KZGViaWFuIHNpZCkgdGhlIGludGVybmFs
IG1pY3JvcGhvbmUgc3RvcHMgd29ya2luZyB3aGVuIHRoZSBtaWMgYm9vc3QgaXMKZW5hYmxlZCAo
dmlhIGFsc2FtaXhlciBvciB3aGVuIHlvdSBzZXQgdGhlIHNvdW5kIHRvIG1vcmUgdGhhbiBzb21l
dGhpbmcKbGlrZSAzMCUgb24gcHVsc2VhdWRpbykuIEFmdGVyIHJlYWRpbmcgdGhpcyBkaXNjdXRp
b24KPGh0dHA6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvcGlwZXJtYWlsL2Fsc2EtZGV2ZWwv
MjAxNS1BcHJpbC8wOTEzMjUuaHRtbD4KdGhhdCB3YXMgdGFsa2luZyBhYm91dCBhIHByb2JsZW0g
dmVyeSBzaW1pbGFyIHRvIG1pbmUsIEkgdHJpZWQgdG8gY2hhbmdlCnRoZSBmaWxlIC9ldGMvbW9k
cHJvYmUuZC9hbHNhLWJhc2UuY29uZiBpbnRvCgpvcHRpb25zIHNuZC1oZGEtaW50ZWwgbW9kZWw9
LGRlbGwtaGVhZHNldC1tdWx0aQoKKEkgYWxzbyB0cmllZCBsb3QncyBvZiBvdGhlciBtb2RlbHMp
CgpCdXQgbm9uZSBvZiB0aGVtIGlzIHJlYWxseSB3b3JraW5nLiBPciBvbmx5IHRoZSBpbnRlcm5h
bCBtaWNyb3Bob25lIGlzCndvcmtpbmcgYW5kIEkgY2FuJ3QgdXNlIGhlYWRzZXRzLCBvciBvbmx5
IHRoZSBoZWFkc2V0cyBhcmUgdXNhYmxlIGFuZApub3QgdGhlIGludGVybmFsIG1pY3JvcGhvbmUs
IG9yIHNvbWV0aW1lcyBuZWlndGhlciB3b3JrLi4uIERvIHlvdSBoYXZlIGEKc29sdXRpb24gZm9y
IHRoYXQ/IEknbSBwcmV0dHkgc3VyZSB0aGF0IGl0J3MgYSBwcm9ibGVtIG9mICJiYWQgcGluCmFz
c2lnbm1lbnQiLCBidXQgSSdtIG5vdCBhbiBleHBlcnQgYXQgYWxsIF5eCgpZb3UgY2FuIGZpbmQg
aGVyZSA8aHR0cHM6Ly93d3cueW91dHViZS5jb20vd2F0Y2g/dj1NVGJWZlJYTUoyST4gc29tZW9u
ZQp0aGF0IGhhcyBhIHNpbWlsYXIgYnVnIG9uIE1hYyBhbmQgdGhhdCBtYW5hZ2UgdG8gc29sdmUg
aXQgdXNpbmcgc3RyYW5nZQp0cmlja3MgaW52b2x2aW5nIHBpbiBjb25maWd1cmF0aW9uLMKgCgpE
byB5b3Uga25vdyBob3cgSSBjb3VsZCBmaW5hbGx5IGdldCBhIHdvcmtpbmcgbWljcm9waG9uZSA/
CgpUaGFuayB5b3UhCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwpBbHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcK
aHR0cDovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2
ZWwK
