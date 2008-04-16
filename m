From: "Risto Suominen" <risto.suominen@gmail.com>
Subject: [PATCH 001a/001] snd-powermac: enable headphone
	detection on older kernels
Date: Wed, 16 Apr 2008 19:47:09 +0300
Message-ID: <46e1c7760804160947l1b087082k3ebc6f95588490b8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_1118_16735482.1208364429104"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.251])
	by alsa0.perex.cz (Postfix) with ESMTP id 459B710382F
	for <alsa-devel@alsa-project.org>;
	Wed, 16 Apr 2008 18:47:12 +0200 (CEST)
Received: by an-out-0708.google.com with SMTP id c36so713512ana.80
	for <alsa-devel@alsa-project.org>; Wed, 16 Apr 2008 09:47:10 -0700 (PDT)
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

------=_Part_1118_16735482.1208364429104
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

So this is not for kernel tree, but alsa-driver.

Risto

------=_Part_1118_16735482.1208364429104
Content-Type: text/plain; name=alsa-pmac_old-hp-1.0.16-p5.diff
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ff44wxuf
Content-Disposition: attachment; filename=alsa-pmac_old-hp-1.0.16-p5.diff

RnJvbTogUmlzdG8gU3VvbWluZW4gPFJpc3RvLlN1b21pbmVuQGdtYWlsLmNvbT4KCkVuYWJsZSBw
b3J0IGNoYW5nZSBpbnRlcnJ1cHQgd2hpbGUgaW5pdGlhbGlzaW5nIEFXQUNTLCBTY3JlYW1lciwg
YW5kCkJ1cmd1bmR5IGNoaXBzZXRzLiBPbGRlciBrZXJuZWxzLgoKU2lnbmVkLW9mZi1ieTogUmlz
dG8gU3VvbWluZW4gPFJpc3RvLlN1b21pbmVuQGdtYWlsLmNvbT4KLS0tCktlcm5lbCB2ZXJzaW9u
IDwgMi42LjE2CgotLS0gcHBjL3BtYWNfb2xkLmMub3JpZwkyMDA4LTAyLTA1IDExOjIzOjIzLjAw
MDAwMDAwMCArMDIwMAorKysgcHBjL3BtYWNfb2xkLmMJMjAwOC0wNC0xNSAyMDowNTo1Ni4wMDAw
MDAwMDAgKzAzMDAKQEAgLTEyNTgsOSArMTI1OCw5IEBAIGludCBfX2luaXQgc25kX3BtYWNfbmV3
KHN0cnVjdCBzbmRfY2FyZCAKIAogCXNuZF9wbWFjX3NvdW5kX2ZlYXR1cmUoY2hpcCwgMSk7CiAK
LQkvKiByZXNldCAqLwotCWlmIChjaGlwLT5tb2RlbCA9PSBQTUFDX0FXQUNTKQotCQlvdXRfbGUz
MigmY2hpcC0+YXdhY3MtPmNvbnRyb2wsIDB4MTEpOworCS8qIHJlc2V0ICYgZW5hYmxlIGludGVy
cnVwdHMgKi8KKwlpZiAoY2hpcC0+bW9kZWwgPD0gUE1BQ19CVVJHVU5EWSkKKwkJb3V0X2xlMzIo
JmNoaXAtPmF3YWNzLT5jb250cm9sLCBjaGlwLT5jb250cm9sX21hc2spOwogCiAJLyogUG93ZXJi
b29rcyBoYXZlIG9kZCB3YXlzIG9mIGVuYWJsaW5nIGlucHV0cyBzdWNoIGFzCiAJICAgYW4gZXhw
YW5zaW9uLWJheSBDRCBvciBzb3VuZCBmcm9tIGFuIGludGVybmFsIG1vZGVtCg==
------=_Part_1118_16735482.1208364429104
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

------=_Part_1118_16735482.1208364429104--
