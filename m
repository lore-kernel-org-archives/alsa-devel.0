From: =?UTF-8?B?4piIa2luZw==?= <alsa-devel@sharpsaw.org>
Subject: Re: [PATCH 0/3] ALSA: snd-usb: Regression fixes for 3.5
Date: Fri, 31 Aug 2012 06:59:03 -0600
Message-ID: <5040B517.5050101@sharpsaw.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sharpsaw.org (li455-14.members.linode.com [50.116.25.14])
 by alsa0.perex.cz (Postfix) with ESMTP id B38BF266471
 for <alsa-devel@alsa-project.org>; Fri, 31 Aug 2012 20:04:11 +0200 (CEST)
Received: from [10.0.0.8] (unknown [74.197.124.13])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by sharpsaw.org (Postfix) with ESMTPSA id 166639539E
 for <alsa-devel@alsa-project.org.>; Fri, 31 Aug 2012 18:04:11 +0000 (UTC)
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

SSBhbSBoYXZpbmcgdGhlIGZvbGxvd2luZyBzeW1wdG9tcywgYmVmb3JlIGFuZCBhZnRlciBhcHBs
aWNhdGlvbiBvZiB0aGlzCnRocmVhZCdzIHBhdGNoZXM6CgpHaXZlbjoKLSBBbiBvbmJvYXJkIGNh
cmQKLSBBIExvZ2l0ZWNoIGgzOTAgVVNCIGhlYWRzZXQKLSBhbHNhLWluZm8gb2Y6IGh0dHA6Ly93
d3cuYWxzYS1wcm9qZWN0Lm9yZy9kYi8/Zj05NDJiNWU5NmI1M2E2NjcyNzBmODk1ZWM1MDYxY2Ex
NGFmMDMzOWVlCgpXaGVuOgotIEkgZG86IGFwbGF5ICQobG9jYXRlIC53YXYgfCBncmVwIEZyb250
KQogIGl0IG91dHB1dHM6CiAgYWxzYSBBTFNBIGxpYiBwY21fZGlyZWN0LmM6OTgwOihzbmQxX3Bj
bV9kaXJlY3RfaW5pdGlhbGl6ZV9zbGF2ZSkKdW5hYmxlIHRvIGluc3RhbGwgaHcgcGFyYW1zCiAg
QUxTQSBsaWIgcGNtX2RtaXguYzoxMDMwOihzbmRfcGNtX2RtaXhfb3BlbikgdW5hYmxlIHRvIGlu
aXRpYWxpemUgc2xhdmUKICBhcGxheTogbWFpbjo2ODI6IGF1ZGlvIG9wZW4gZXJyb3I6IEJyb2tl
biBwaXBlCi0gSSBkbyBhIFNreXBlICJNYWtlIGEgdGVzdCBzb3VuZCIKICAvdmFyL2xvZy9tZXNz
YWdlcyBzdHJlYW1zIGRvemVucyBvZiB0aGVzZToKICBrZXJuZWw6IGNhbm5vdCBzdWJtaXQgdXJi
IDAsIGVycm9yIC0yODogbm90IGVub3VnaCBiYW5kd2lkdGgKCk5vdGUgdGhhdCB0aGlzIGlzIGEg
bmV3IGxhcHRvcCBhbmQgaGVhZHNldCwgc28gSSBoYXZlbid0IGNvbXBhcmVkIGhvdwplaXRoZXIg
d29ya3Mgb24gb3RoZXIgc2V0dXBzLCBzdWNoIGFzIHdpdGggb3RoZXIga2VybmVscyBvciBhbHNh
IHZlcnNpb25zLgoKQW55IGhpbnRzPyBBbnkgZnVydGhlciBpbmZvIG5lZWRlZD8KClRoYW5rcyEK
4oCU4piICgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpB
bHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cDov
L21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
