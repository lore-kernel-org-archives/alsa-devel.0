From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: [PATCH] - ALSA Documentation SB-Live-mixer.txt -
 Rename Music controls to Synth controls
Date: Sat, 9 Apr 2011 15:20:45 +0800
Message-ID: <BANLkTikA5pKOf9RCH1gZk_OQYm8xxkdnEw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=0016e6dab47357f0af04a0772e40
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 70C7C103807
	for <alsa-devel@alsa-project.org>;
	Sat,  9 Apr 2011 09:20:46 +0200 (CEST)
Received: by bwz10 with SMTP id 10so3631957bwz.38
	for <alsa-devel@alsa-project.org>; Sat, 09 Apr 2011 00:20:46 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

--0016e6dab47357f0af04a0772e40
Content-Type: text/plain; charset=ISO-8859-1

Rename "Music" controls to "Synth" controls in
Documentation/alsa/SB-Live-mixer.txt as alsa driver had already changed the
name of the controls

--0016e6dab47357f0af04a0772e40
Content-Type: application/octet-stream;
	name="0001-Rename-Music-controls-to-Synth-controls.patch"
Content-Disposition: attachment;
	filename="0001-Rename-Music-controls-to-Synth-controls.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gma7s6is0

RnJvbSAxNjk3OTdhNzM0MmE0NGUxYzE4OTAwMDI1N2QwZGU2MDFhYTlkZGYyIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBSYXltb25kIFlhdSA8c3VwZXJxdWFkLnZvcnRleDJAZ21haWwu
Y29tPgpEYXRlOiBGcmksIDggQXByIDIwMTEgMTU6NDY6MTcgKzA4MDAKU3ViamVjdDogW1BBVENI
XSBEb2N1bWVudGF0aW9uIEFMU0EgU0ItTGl2ZS1taXhlci50eHQgIC0gUmVuYW1lICJNdXNpYyIg
Y29udHJvbHMgdG8gIlN5bnRoIiBjb250cm9scwoKClNpZ25lZC1vZmYtYnk6IFJheW1vbmQgWWF1
IDxzdXBlcnF1YWQudm9ydGV4MkBnbWFpbC5jb20+CgpkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlv
bi9zb3VuZC9hbHNhL1NCLUxpdmUtbWl4ZXIudHh0IGIvRG9jdW1lbnRhdGlvbi9zb3VuZC9hbHNh
L1NCLUxpdmUtbWl4ZXIudHh0CmluZGV4IGY1NjM5ZDQuLmY0YjU5ODggMTAwNjQ0Ci0tLSBhL0Rv
Y3VtZW50YXRpb24vc291bmQvYWxzYS9TQi1MaXZlLW1peGVyLnR4dAorKysgYi9Eb2N1bWVudGF0
aW9uL3NvdW5kL2Fsc2EvU0ItTGl2ZS1taXhlci50eHQKQEAgLTg3LDE0ICs4NywxNCBAQCBhY2N1
bXVsYXRvci4gQUxTQSB1c2VzIGFjY3VtdWxhdG9ycyAwIGFuZCAxIGZvciBsZWZ0IGFuZCByaWdo
dCBQQ00uCiBUaGUgcmVzdWx0IGlzIGZvcndhcmRlZCB0byB0aGUgQURDIGNhcHR1cmUgRklGTyAo
dGh1cyB0byB0aGUgc3RhbmRhcmQgY2FwdHVyZQogUENNIGRldmljZSkuCiAKLW5hbWU9J011c2lj
IFBsYXliYWNrIFZvbHVtZScsaW5kZXg9MAorbmFtZT0nU3ludGggUGxheWJhY2sgVm9sdW1lJyxp
bmRleD0wCiAKIFRoaXMgY29udHJvbCBpcyB1c2VkIHRvIGF0dGVudWF0ZSBzYW1wbGVzIGZvciBs
ZWZ0IGFuZCByaWdodCBNSURJIEZYLWJ1cwogYWNjdW11bGF0b3JzLiBBTFNBIHVzZXMgYWNjdW11
bGF0b3JzIDQgYW5kIDUgZm9yIGxlZnQgYW5kIHJpZ2h0IE1JREkgc2FtcGxlcy4KIFRoZSByZXN1
bHQgc2FtcGxlcyBhcmUgZm9yd2FyZGVkIHRvIHRoZSBmcm9udCBEQUMgUENNIHNsb3RzIG9mIHRo
ZSBBQzk3IGNvZGVjLgogCi1uYW1lPSdNdXNpYyBDYXB0dXJlIFZvbHVtZScsaW5kZXg9MAotbmFt
ZT0nTXVzaWMgQ2FwdHVyZSBTd2l0Y2gnLGluZGV4PTAKK25hbWU9J1N5bnRoIENhcHR1cmUgVm9s
dW1lJyxpbmRleD0wCituYW1lPSdTeW50aCBDYXB0dXJlIFN3aXRjaCcsaW5kZXg9MAogCiBUaGVz
ZSBjb250cm9scyBhcmUgdXNlZCB0byBhdHRlbnVhdGUgc2FtcGxlcyBmb3IgbGVmdCBhbmQgcmln
aHQgTUlESSBGWC1idXMKIGFjY3VtdWxhdG9yLiBBTFNBIHVzZXMgYWNjdW11bGF0b3JzIDQgYW5k
IDUgZm9yIGxlZnQgYW5kIHJpZ2h0IFBDTS4KLS0gCjEuNi4wLjYKCg==
--0016e6dab47357f0af04a0772e40
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--0016e6dab47357f0af04a0772e40--
