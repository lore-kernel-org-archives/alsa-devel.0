From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: [PATCH] ALSA - HDA - Change "Mic" to "Rear Mic" in
	ad1988_6stack_capture_source
Date: Mon, 23 May 2011 14:58:05 +0800
Message-ID: <BANLkTim35Trrj+_x+74SEUFA3ud+9Xcc_Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=00151747b3624d26d504a3ebfe92
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51])
	by alsa0.perex.cz (Postfix) with ESMTP id F1E401037FC
	for <alsa-devel@alsa-project.org>;
	Mon, 23 May 2011 08:58:06 +0200 (CEST)
Received: by fxm5 with SMTP id 5so4182113fxm.38
	for <alsa-devel@alsa-project.org>; Sun, 22 May 2011 23:58:06 -0700 (PDT)
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

--00151747b3624d26d504a3ebfe92
Content-Type: text/plain; charset=ISO-8859-1

Change "Mic" to "Rear Mic" in ad1988_6stack_capture_source

--00151747b3624d26d504a3ebfe92
Content-Type: application/octet-stream;
	name="0001-Change-Mic-to-Rear-Mic-of-ad1988_6stack_capture_source.patch"
Content-Disposition: attachment;
	filename="0001-Change-Mic-to-Rear-Mic-of-ad1988_6stack_capture_source.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_go12d43x0

RnJvbSA3NWRlMDZmOTI4YmEyMzAyMDMwNzg3NTE4ZGNhMjhjZDc1ODYyN2E1IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBSYXltb25kIFlhdSA8c3VwZXJxdWFkLnZvcnRleDJAZ21haWwu
Y29tPgpEYXRlOiBNb24sIDIzIE1heSAyMDExIDE0OjQ3OjI1ICswODAwClN1YmplY3Q6IFtQQVRD
SF0gQUxTQSAtIEhEQSAtIENoYW5nZSAiTWljIiB0byAiUmVhciBNaWMiIGluIGFkMTk4OF82c3Rh
Y2tfY2FwdHVyZV9zb3VyY2UKCkNoYW5nZSAiTWljIiB0byAiUmVhciBNaWMiIGluIGFkMTk4OF82
c3RhY2tfY2FwdHVyZV9zb3VyY2UKClNpZ25lZC1vZmYtYnk6IFJheW1vbmQgWWF1IDxzdXBlcnF1
YWQudm9ydGV4MkBnbWFpbC5jb20+CgpkaWZmIC0tZ2l0IGEvc291bmQvcGNpL2hkYS9wYXRjaF9h
bmFsb2cuYyBiL3NvdW5kL3BjaS9oZGEvcGF0Y2hfYW5hbG9nLmMKaW5kZXggZjFiMzg3NS4uMzNk
OGViZSAxMDA2NDQKLS0tIGEvc291bmQvcGNpL2hkYS9wYXRjaF9hbmFsb2cuYworKysgYi9zb3Vu
ZC9wY2kvaGRhL3BhdGNoX2FuYWxvZy5jCkBAIC0yMTE3LDcgKzIxMTcsNyBAQCBzdGF0aWMgY29u
c3Qgc3RydWN0IGhkYV9pbnB1dF9tdXggYWQxOTg4XzZzdGFja19jYXB0dXJlX3NvdXJjZSA9IHsK
IAkuaXRlbXMgPSB7CiAJCXsgIkZyb250IE1pYyIsIDB4MSB9LAkvKiBwb3J0LUIgKi8KIAkJeyAi
TGluZSIsIDB4MiB9LAkvKiBwb3J0LUMgKi8KLQkJeyAiTWljIiwgMHg0IH0sCQkvKiBwb3J0LUUg
Ki8KKwkJeyAiUmVhciBNaWMiLCAweDQgfSwJLyogcG9ydC1FICovCiAJCXsgIkNEIiwgMHg1IH0s
CiAJCXsgIk1peCIsIDB4OSB9LAogCX0sCi0tIAoxLjYuMC42Cgo=
--00151747b3624d26d504a3ebfe92
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--00151747b3624d26d504a3ebfe92--
