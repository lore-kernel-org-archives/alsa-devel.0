From: Andrei Tanas <andrei@tanas.ca>
Subject: Asus P5QL-EM motherboard (ALC1200 codec) - no sound
	through S/PDIF
Date: Wed, 12 Nov 2008 21:51:15 -0500
Message-ID: <668af2a1e877d41c059f6c84fa462476@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tanas.ca (tanas.ca [206.248.136.31])
	by alsa0.perex.cz (Postfix) with ESMTP id 002A22414C
	for <alsa-devel@alsa-project.org>; Thu, 13 Nov 2008 03:51:17 +0100 (CET)
Received: from tanas.ca (localhost [127.0.0.1])
	by tanas.ca (Postfix) with ESMTP id 732D51C68471
	for <alsa-devel@alsa-project.org>; Wed, 12 Nov 2008 21:51:15 -0500 (EST)
Received: from mail.unchanged.net (localhost [127.0.0.1])
	by tanas.ca (Postfix) with ESMTP id 4028D1C68470
	for <alsa-devel@alsa-project.org>; Wed, 12 Nov 2008 21:51:15 -0500 (EST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

SGVsbG8sCkkgY2FuJ3QgZ2V0IHRoZSBTL1BESUYgb3V0IHRvIHdvcmsgb24gUDVRTC1FTSBtb3Ro
ZXJib2FyZC4gCgpGaXJzdCBvZiBhbGwsIGl0IGRvZXNuJ3QgZGV0ZWN0IHRoZSBib2FyZCBjb25m
aWd1cmF0aW9uIGNvcnJlY3RseSwgdGhlCm1vdGhlcmJvYXJkIGhhcyBhbiBIRE1JIG91dHB1dCBh
bmQgYW4gUy9QRElGIGhlYWRlciAoSSBoYXZlIGEgVFYKY29ubmVjdGVkIHRvIG9uZSBhbmQgYW4g
YW1wbGlmaWVyIHRvIHRoZSBvdGhlciwgaW4gY2FzZSBvbmUgb3V0cHV0CndpbGwgImdvIGxpdmUi
KS4gCgphcGxheSAtTCBub3JtYWxseSBvbmx5IHNob3dzIHRoIEhETUkgcG9ydCwgaG93ZXZlciBp
ZiBJIGFkZCB0aGlzIApvcHRpb25zIHNuZC1oZGEtaW50ZWwgbW9kZWw9NnN0YWNrLWRpZyBwcm9i
ZV9tYXNrPTEgCnRvwqAvZXRjL21vZHByb2JlLmQvYWxzYS1iYXNlLCBpdCB3aWxsIHNob3cgYm90
aC4gCgpQcm9ibGVtIGlzLCB0aGVyZSBzZWVtcyB0byBiZSBubyBzaWduYWwgY29taW5nIG91dCBv
ZiBhbnkgb2YgdGhlIHR3bwpkaWdpdGFsIHBvcnRzICh0aGV5IGFyZSBub3QgbXV0ZWQgaW4gbWl4
ZXIpIGluIGVpdGhlciBQQ00gb3IgQUMzCnBhc3MtdGhyb3VnaCBtb2RlLgoKSSBjb21waWxlZCB0
aGUgImFsc2Eta2VybmVsIiBob3BpbmcgdGhhdCB0aGUgbGF0ZXN0IGNvbW1pdHMgcmVsYXRlZCB0
bwpBTEMxMjAwIHdvdWxkIGhlbHAsIGJ1dMKgaXQgaGFzbid0IGhlbHBlZC4KCkhlcmUncyB0aGUg
b3V0cHV0IG9mIGFsc2EtaW5mby5zaDoKaHR0cDovL3d3dy5hbHNhLXByb2plY3Qub3JnL2RiLz9m
PWI2MmI1NmM1Y2UwYWEzODNmZWYxYmUwZjU1Yjg3YjRlMjdlOGFiNjMKQWdhaW4sIGl0J3MgcnVu
bmluZyAiYWxzYS1rZXJuZWwiLCBjaGVja2VkIGluIGp1c3QgMTIgaG91cnMgYWdvLgoKTGV0IG1l
IGtub3cgd2hhdCBJIGNhbiBkbyB0byBoZWxwLCBJIGFtIGEgZGV2ZWxvcGVyIGJ1dCBBbHNhIGlz
IG5vdApteSB0ZXJyaXRvcnkuCgpUaGFua3MKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KQWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNh
LXByb2plY3Qub3JnCmh0dHA6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0
aW5mby9hbHNhLWRldmVsCg==
