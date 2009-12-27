From: Daniel Chen <seven.steps@gmail.com>
Subject: [PATCH] ALSA: atiixp: Specify codec for Foxconn
	RC4107MA-RS2
Date: Sun, 27 Dec 2009 15:55:44 -0500
Message-ID: <604760770912271255y673a4bcat9c11360d9bf97956@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=00504502b1462be120047bbc034f
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pw0-f53.google.com (mail-pw0-f53.google.com
	[209.85.160.53]) by alsa0.perex.cz (Postfix) with ESMTP id CF99924520
	for <alsa-devel@alsa-project.org>; Sun, 27 Dec 2009 21:55:45 +0100 (CET)
Received: by pwi18 with SMTP id 18so24800852pwi.32
	for <alsa-devel@alsa-project.org>; Sun, 27 Dec 2009 12:55:44 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

--00504502b1462be120047bbc034f
Content-Type: text/plain; charset=UTF-8

Hi,

Attached is a patch against sound-2.6.git and also targeted for stable
to make sound audible by default for this mainboard.

Thanks,
Dan

--00504502b1462be120047bbc034f
Content-Type: text/x-diff; charset=US-ASCII;
	name="0001-ALSA-atiixp-Specify-codec-for-Foxconn-RC4107MA-RS2.patch"
Content-Disposition: attachment;
	filename="0001-ALSA-atiixp-Specify-codec-for-Foxconn-RC4107MA-RS2.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g3qau21i0

RnJvbSAyNGJiNjAwOTY0ZjEyNzMwYTI4MmEyOWY4ZjgyNTI0OGViMjBhYmJjIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBEYW5pZWwgVCBDaGVuIDxjcmltc3VuQHVidW50dS5jb20+CkRh
dGU6IFN1biwgMjcgRGVjIDIwMDkgMTU6NDg6NDAgLTA1MDAKU3ViamVjdDogW1BBVENIXSBBTFNB
OiBhdGlpeHA6IFNwZWNpZnkgY29kZWMgZm9yIEZveGNvbm4gUkM0MTA3TUEtUlMyCgpCdWdMaW5r
OiBodHRwczovL2J1Z3MubGF1bmNocGFkLm5ldC91YnVudHUvK2J1Zy80OTg4NjMKClRoaXMgbWFp
bmJvYXJkIG5lZWRzIGFjOTdfY29kZWM9MC4KCkNjOiBzdGFibGVAa2VybmVsLm9yZwpUZXN0ZWQt
Ynk6IEFwb29ydiBQYXJsZSA8YXBwYXJsZUB5YWhvby5jby5pbj4KU2lnbmVkLW9mZi1ieTogRGFu
aWVsIFQgQ2hlbiA8Y3JpbXN1bkB1YnVudHUuY29tPgotLS0KIHNvdW5kL3BjaS9hdGlpeHAuYyB8
ICAgIDEgKwogMSBmaWxlcyBjaGFuZ2VkLCAxIGluc2VydGlvbnMoKyksIDAgZGVsZXRpb25zKC0p
CgpkaWZmIC0tZ2l0IGEvc291bmQvcGNpL2F0aWl4cC5jIGIvc291bmQvcGNpL2F0aWl4cC5jCmlu
ZGV4IGQ2NzUyZGYuLjQyYjRmYmIgMTAwNjQ0Ci0tLSBhL3NvdW5kL3BjaS9hdGlpeHAuYworKysg
Yi9zb3VuZC9wY2kvYXRpaXhwLmMKQEAgLTI5Nyw2ICsyOTcsNyBAQCBzdGF0aWMgc3RydWN0IHBj
aV9kZXZpY2VfaWQgc25kX2F0aWl4cF9pZHNbXSA9IHsKIE1PRFVMRV9ERVZJQ0VfVEFCTEUocGNp
LCBzbmRfYXRpaXhwX2lkcyk7CiAKIHN0YXRpYyBzdHJ1Y3Qgc25kX3BjaV9xdWlyayBhdGlpeHBf
cXVpcmtzW10gX19kZXZpbml0ZGF0YSA9IHsKKwlTTkRfUENJX1FVSVJLKDB4MTA1YiwgMHgwYzgx
LCAiRm94Y29ubiBSQzQxMDdNQS1SUzIiLCAwKSwKIAlTTkRfUENJX1FVSVJLKDB4MTViZCwgMHgz
MTAwLCAiREZJIFJTNDgyIiwgMCksCiAJeyB9IC8qIHRlcm1pbmF0b3IgKi8KIH07Ci0tIAoxLjYu
NQoK
--00504502b1462be120047bbc034f
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--00504502b1462be120047bbc034f--
