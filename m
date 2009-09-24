From: Dan Chen <crimsunkg@yahoo.com>
Subject: Re: [Pkg-alsa-devel] Bug#547994: snd-hda-intel and MSI
Date: Wed, 23 Sep 2009 17:28:38 -0700 (PDT)
Message-ID: <21151.71754.qm@web31804.mail.mud.yahoo.com>
References: <20090923143306.GC4488@aragorn.home.lxtec.de>
	<s5hpr9hzmx0.wl%tiwai@suse.de>
	<20090923170635.GD4488@aragorn.home.lxtec.de>
	<604760770909231011t1b05c01dn79d94f8a021a1884@mail.gmail.com>
	<20090923180842.GE4488@aragorn.home.lxtec.de>
	<604760770909231111n7a1d1a0dw1a01b64f7066a574@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1275010023-1253752118=:71754"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from web31804.mail.mud.yahoo.com (web31804.mail.mud.yahoo.com
	[68.142.207.67]) by alsa0.perex.cz (Postfix) with SMTP id 502A8103822
	for <alsa-devel@alsa-project.org>;
	Thu, 24 Sep 2009 02:28:41 +0200 (CEST)
In-Reply-To: <604760770909231111n7a1d1a0dw1a01b64f7066a574@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Chen <seven.steps@gmail.com>, 547994@bugs.debian.org, Takashi Iwai <tiwai@suse.de>, alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

--0-1275010023-1253752118=:71754
Content-Type: text/plain; charset=us-ascii

Attached, please find a patch against current sound-2.6.git HEAD resolving this issue.

-Dan



      
--0-1275010023-1253752118=:71754
Content-Type: application/octet-stream; name="0001-Add-HP-Pavilion-dv4t-1300-to-MSI-whitelist.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="0001-Add-HP-Pavilion-dv4t-1300-to-MSI-whitelist.patch"

RnJvbSA0MDlmZGI3Yjc1YzIxYjAzMTE5OTA2OTYwNmM4ODVkMGFjOTE4NzA3
IE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBEYW5pZWwgVCBDaGVu
IDxzZXZlbi5zdGVwc0BnbWFpbC5jb20+CkRhdGU6IFdlZCwgMjMgU2VwIDIw
MDkgMjA6MjM6MjcgLTA0MDAKU3ViamVjdDogW1BBVENIXSBBZGQgSFAgUGF2
aWxpb24gZHY0dC0xMzAwIHRvIE1TSSB3aGl0ZWxpc3QKCkJ1Z0xpbms6IGh0
dHA6Ly9idWdzLmRlYmlhbi5vcmcvY2dpLWJpbi9idWdyZXBvcnQuY2dpP2J1
Zz01NDc5OTQKCkVuYWJsZSBNU0kgYnkgZGVmYXVsdCBmb3IgdGhpcyBQYXZp
bGlvbiBtb2RlbC4KClNpZ25lZC1vZmYtYnk6IERhbmllbCBUIENoZW4gPGNy
aW1zdW5AdWJ1bnR1LmNvbT4KLS0tCiBzb3VuZC9wY2kvaGRhL2hkYV9pbnRl
bC5jIHwgICAgMSArCiAxIGZpbGVzIGNoYW5nZWQsIDEgaW5zZXJ0aW9ucygr
KSwgMCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9zb3VuZC9wY2kvaGRh
L2hkYV9pbnRlbC5jIGIvc291bmQvcGNpL2hkYS9oZGFfaW50ZWwuYwppbmRl
eCAyMGE2NmY4Li5jOWFkMTgyIDEwMDY0NAotLS0gYS9zb3VuZC9wY2kvaGRh
L2hkYV9pbnRlbC5jCisrKyBiL3NvdW5kL3BjaS9oZGEvaGRhX2ludGVsLmMK
QEAgLTIzMDMsNiArMjMwMyw3IEBAIHN0YXRpYyB2b2lkIF9fZGV2aW5pdCBj
aGVja19wcm9iZV9tYXNrKHN0cnVjdCBhenggKmNoaXAsIGludCBkZXYpCiAg
KiB3aGl0ZS1saXN0IGZvciBlbmFibGVfbXNpCiAgKi8KIHN0YXRpYyBzdHJ1
Y3Qgc25kX3BjaV9xdWlyayBtc2lfd2hpdGVfbGlzdFtdIF9fZGV2aW5pdGRh
dGEgPSB7CisJU05EX1BDSV9RVUlSSygweDEwM2MsIDB4MzBmNywgIkhQIFBh
dmlsaW9uIGR2NHQtMTMwMCIsIDEpLAogCVNORF9QQ0lfUVVJUksoMHgxMDNj
LCAweDM2MDcsICJIUCBDb21wYSBDUTQwIiwgMSksCiAJe30KIH07Ci0tIAox
LjYuMy4zCgo=

--0-1275010023-1253752118=:71754
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--0-1275010023-1253752118=:71754--
