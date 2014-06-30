From: Jean-Francois Moine <moinejf@free.fr>
Subject: Re: [PATCH 00/13] Remove mach-kirkwood and mach-dove
Date: Mon, 30 Jun 2014 18:13:47 +0200
Message-ID: <20140630181347.6a4ad4a8@armhf>
References: <1404075603-31838-1-git-send-email-andrew@lunn.ch>
 <20140629213510.GR32514@n2100.arm.linux.org.uk>
 <53B154FE.80804@gmail.com>
 <20140630124320.GZ32514@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp2-g21.free.fr (smtp2-g21.free.fr [212.27.42.2])
 by alsa0.perex.cz (Postfix) with ESMTP id 78A9F2655DC
 for <alsa-devel@alsa-project.org>; Mon, 30 Jun 2014 18:12:00 +0200 (CEST)
In-Reply-To: <20140630124320.GZ32514@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, alsa-devel@alsa-project.org, Jason Cooper <jason@lakedaemon.net>, Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>, Mark Brown <broonie@kernel.org>, Gregory Clement <gregory.clement@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: alsa-devel@alsa-project.org

T24gTW9uLCAzMCBKdW4gMjAxNCAxMzo0MzoyMCArMDEwMApSdXNzZWxsIEtpbmcgLSBBUk0gTGlu
dXggPGxpbnV4QGFybS5saW51eC5vcmcudWs+IHdyb3RlOgoKPiBGb3IgZXhhbXBsZSwgSSd2ZSBo
YWQgZnVsbHkgd29ya2luZyBhdWRpbyBvbiB0aGUgQ3Vib3ggZm9yIDE4KyBtb250aHMsCj4gYnV0
IHRoZXJlJ3MgYSBiaWcgcHJvYmxlbSBnZXR0aW5nIGl0IGludG8gbWFpbmxpbmUuICBGaXJzdCBp
dCB3YXMgdGhlCj4gbGFjayBvZiBjby1vcGVyYXRpb24gZnJvbSB0aGUgQVNvQyBtYWludGFpbmVy
cy4gIFRoZW4gaXQgd2FzIHRoZSBBU29DCj4gbWFpbnRhaW5lcnMgYWNjZXB0aW5nIEplYW4tRnJh
bmNvaXMgcGF0Y2hlcyAod2hpY2ggcmVhbGx5IHRvcnBlZG9lZAo+IG15IGVmZm9ydHMuKSAgQW5k
IHRoZSBmaW5hbCBwcm9ibGVtIHdoaWNoIG1ha2VzIGl0IHRvdGFsbHkgaW1wb3NzaWJsZQo+IGlz
IHRoYXQgcHVzaGluZyB0aGUgRFBDTSBzdHVmZiB3aWxsIGNvbXBsZXRlbHkgYnJlYWsgdGhlIERU
IGJhc2VkCj4ga2lya3dvb2QgQVNvQyBzdHVmZiB3aGljaCBnb3QgcHVzaGVkIGluLgoKSSBhbHJl
YWR5IHRyaWVkIERQQ00gd2l0aCB0aGUga2lya3dvb2QgYXVkaW8gc3Vic3lzdGVtLiBJdCBqdXN0
IGFzayB0bwphZGQgYSAnc3lzdGVtJyBEQUkgaW4ga2lya3dvb2QtaTJzLiBUaGUgY2FyZCBpcyBk
ZWZpbmVkIGFzOgoKLSBsaW5rIDA6CglDUFU6ICdzeXN0ZW0nIChraXJrd29vZCBuZXcgREFJKQoJ
Q09ERUM6ICdkdW1teScKCWZyb250LWVuZAotIGxpbmsgMToKCUNQVTogJ2kycycgKGtpcmt3b29k
KQoJQ09ERUM6ICdpMnMtaGRtaScgKHRkYTk5OHggY29kZWMpCgliYWNrLWVuZAotIGxpbmsgMgoJ
Q1BVOiAnc3BkaWYnIChraXJrd29vZCkKCUNPREVDOiAnc3BkaWYtaGRtaScgKHRkYTk5OHggY29k
ZWMpCgliYWNrLWVuZAotIGxpbmsgMwoJQ1BVOiAnc3BkaWYnIChraXJrd29vZCkKCUNPREVDOiAn
ZGl0LWhpZmknIChzcGRpZiBjb2RlYykKCWJhY2tlbmQKCndpdGggdGhlIHJvdXRlcyAoc2ltcGxl
LWNhcmQgZm9ybWF0KToKCgkiSTJTIFBsYXliYWNrIiwgICAiU3lzdGVtIFBsYXliYWNrIiwKCSJT
UERJRiBQbGF5YmFjayIsICJTeXN0ZW0gUGxheWJhY2siLAogICAgICAgIAogCSJoZG1pLW91dCIs
ICAgICAiSTJTIFBsYXliYWNrIiwKIAkiaGRtaS1vdXQiLCAgICAgIlNQRElGIFBsYXliYWNrIiwK
CSJzcGRpZi1vdXQiLCAgICAiU1BESUYgUGxheWJhY2siOwoKVGhpcyB3b3JrcywgYnV0IHRoZSBI
VyBjb25zdHJhaW50cyBvZiB0aGUgc2lua3MgYXJlIG5vdCBoYW5kbGVkLCBzbywKYWxsIGJhY2tl
bmRzIGFyZSBhbHdheXMgYWN0aXZhdGVkIGZvciBhbnkgZm9ybWF0L2FueSByYXRlLgoKLS0gCktl
biBhciBjJ2hlbnRhw7EJfAkgICAgICAqKiBCcmVpemggaGEgTGludXggYXRhdiEgKioKSmVmCQl8
CQlodHRwOi8vbW9pbmVqZi5mcmVlLmZyLwpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNhLWRldmVsQGFsc2Et
cHJvamVjdC5vcmcKaHR0cDovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2Fsc2EtZGV2ZWwK
