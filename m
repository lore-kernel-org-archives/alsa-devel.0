From: Colin Guthrie <gmane@colin.guthr.ie>
Subject: Re: alsamixer is not able to set pulseaudio master
	volume
Date: Wed, 16 Sep 2009 09:50:21 +0100
Message-ID: <h8q8sd$3dr$1@ger.gmane.org>
References: <4AB0901A.6040200@pardus.org.tr>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by alsa0.perex.cz (Postfix) with ESMTP id 38780243EA
	for <alsa-devel@alsa-project.org>;
	Wed, 16 Sep 2009 10:50:47 +0200 (CEST)
Received: from list by lo.gmane.org with local (Exim 4.50) id 1MnqDs-00013c-6l
	for alsa-devel@alsa-project.org; Wed, 16 Sep 2009 10:50:44 +0200
Received: from brent.tribalogic.net ([78.86.109.144])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Wed, 16 Sep 2009 10:50:44 +0200
Received: from gmane by brent.tribalogic.net with local (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Wed, 16 Sep 2009 10:50:44 +0200
In-Reply-To: <4AB0901A.6040200@pardus.org.tr>
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
Cc: pulseaudio-discuss@mail.0pointer.de
List-Id: alsa-devel@alsa-project.org

J1R3YXMgYnJpbGxpZywgYW5kIE96YW4gw4dhxJ9sYXlhbiBhdCAxNi8wOS8wOSAwODoxMyBkaWQg
Z3lyZSBhbmQgZ2ltYmxlOgo+IEkndmUganVzdCBub3RpY2VkIHRoYXQgdXNpbmcgYWxzYW1peGVy
IHRvIHNldCBwdWxzZWF1ZGlvJ3MgbWFzdGVyIHZvbHVtZQo+IGlzIG5vdCB3b3JraW5nIGFueW1v
cmUuIEkgc3dpdGNoZWQgYmFjayB0byBhbiBlYXJsaWVyIGFsc2EtdXRpbHMKPiBzbmFwc2hvdCAo
MjAwOTA2MjQpIHN0aWxsIHRoZSBzYW1lLgo+IAo+IEkgZGlkbid0IGRvIGFueSBjaGFuZ2VzIHRv
IHB1bHNlYXVkaW8gZm9yIGEgbG9uZyB0aW1lLCBpdCdzIDAuOS4xNSB3aXRoCj4gdGhlIHByb3Bv
c2VkIHBhdGNoc2V0IG9mIExlbm5hcnQuCj4gCj4gYWxzYW1peGVyIGlzIGxhdW5jaGVkLCB0aGUg
bWFzdGVyIGNoYW5uZWwgaXMgZGlzcGxheWVkIGJ1dCBwcmVzc2luZyBVcAo+IGFuZCBEb3duIGRv
ZXNuJ3QgY2hhbmdlIGFueXRoaW5nIG9uIHRoZSBVSS4gUHJlc3NpbmcgTSBjaGFuZ2VzICdPTycg
dG8gJ01NJy4KCkkndmUgc2VlbiB0aGlzIHRvbywgYnV0IHByZXNzaW5nIHRoZSBudW1iZXJzIDAt
OSB3b3JrIGZpbmUgdG8gYWRqdXN0IHRoZSAKdm9sdW1lLiBJdCdzIGFsc28gYmUgcmVwb3J0ZWQg
b24gSVJDLgoKSSdtIG5vdCBzdXJlIHRoaXMgaXMgYSBwdWxzZSBwcm9ibGVtIHNwZWNpZmljYWxs
eSwgYWx0aG91Z2ggY291bGQgYmUgCnJlbGF0ZWQgdG8gdGhlIGFsc2EgcGx1Z2luIGl0c2VsZiAt
IGhhdmUgeW91IHRyaWVkIHJldmVydGluZyB0aGF0PwoKQ29sCgoKLS0gCgpDb2xpbiBHdXRocmll
CmdtYW5lKGF0KWNvbGluLmd1dGhyLmllCmh0dHA6Ly9jb2xpbi5ndXRoci5pZS8KCkRheSBKb2I6
CiAgIFRyaWJhbG9naWMgTGltaXRlZCBbaHR0cDovL3d3dy50cmliYWxvZ2ljLm5ldC9dCk9wZW4g
U291cmNlOgogICBNYW5kcml2YSBMaW51eCBDb250cmlidXRvciBbaHR0cDovL3d3dy5tYW5kcml2
YS5jb20vXQogICBQdWxzZUF1ZGlvIEhhY2tlciBbaHR0cDovL3d3dy5wdWxzZWF1ZGlvLm9yZy9d
CiAgIFRyYWMgSGFja2VyIFtodHRwOi8vdHJhYy5lZGdld2FsbC5vcmcvXQoKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KQWxzYS1kZXZlbCBtYWlsaW5nIGxp
c3QKQWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0dHA6Ly9tYWlsbWFuLmFsc2EtcHJvamVj
dC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVsCg==
