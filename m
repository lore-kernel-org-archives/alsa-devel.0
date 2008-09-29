From: "=?UTF-8?Q?Vedran_Mileti=C4=87?=" <rivanvx@gmail.com>
Subject: [PATCH] ALSA: hda: add more board-specific information
	for Realtek ALC662 rev1
Date: Mon, 29 Sep 2008 20:39:33 +0200
Message-ID: <fd3eb9bf0809291139y4252c1e1h75abbfdb68b21225@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_5761_2998621.1222713573468"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gx0-f17.google.com (mail-gx0-f17.google.com
	[209.85.217.17]) by alsa0.perex.cz (Postfix) with ESMTP id 21502244EB
	for <alsa-devel@alsa-project.org>;
	Mon, 29 Sep 2008 20:39:34 +0200 (CEST)
Received: by gxk10 with SMTP id 10so13221049gxk.8
	for <alsa-devel@alsa-project.org>; Mon, 29 Sep 2008 11:39:34 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel mailing list <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

------=_Part_5761_2998621.1222713573468
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Content-Disposition: inline

SSByZWNlbnRseSBnb3QgYSBjaGFuY2UgdG8gcGxheSB3aXRoIHR3byBib2FyZHMgd2l0aCBBTEM2
NjIgcmV2MToKKiBCSU9TVEFSIFRBNzgwRyBNMisKKiBBU1JPQ0sgSzEwTjc4RnVsbEhELWhTTEkg
UjMuMApCb3RoIHVzZSAzIHN0YWNrLCA2Y2ggbW9kZSB3aXRoIGRpZ2l0YWwgb3V0LiBTaW5jZSBh
dXRvZGV0ZWN0aW9uIGlzbid0IGFibGUKdG8gZmlndXJlIHRoYXQgb3V0IGZyb20gQklPUywgd2Ug
bmVlZCB0byBzcGVjaWZ5IHRoYXQgbWFudWFsbHkuCgpCVFcsIHRoYW5rcyBmb3IgZml4aW5nIE5W
SURJQSBNQ1A3OFMgW0dlRm9yY2UgODIwMF0gSEQgYXVkaW8gaW4KMS4wLjE4LCBpdCdzIG11Y2gg
YXBwcmVjaWF0ZWQgOi0pCgotLSAKVmVkcmFuIE1pbGV0acSHCg==
------=_Part_5761_2998621.1222713573468
Content-Type: text/x-patch;
 name=0001-ALSA-hda-add-more-board-specific-information-for-R.patch
Content-Transfer-Encoding: base64
X-Attachment-Id: f_flpg05o00
Content-Disposition: attachment;
 filename=0001-ALSA-hda-add-more-board-specific-information-for-R.patch

RnJvbSA5NDUyYWQyOWZmMjk5ZWU2M2EzMjE2M2Q3Nzg3M2M0NzU2Nzk2ZjJhIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBWZWRyYW4gTWlsZXRpYyA8cml2YW52eEBnbWFpbC5jb20+CkRh
dGU6IE1vbiwgMjkgU2VwIDIwMDggMjA6Mjk6MjUgKzAyMDAKU3ViamVjdDogW1BBVENIXSBBTFNB
OiBoZGE6IGFkZCBtb3JlIGJvYXJkLXNwZWNpZmljIGluZm9ybWF0aW9uIGZvciBSZWFsdGVrIEFM
QzY2MiByZXYxCgpJIHJlY2VudGx5IGdvdCBhIGNoYW5jZSB0byBwbGF5IHdpdGggdHdvIGJvYXJk
cyB3aXRoIEFMQzY2MiByZXYxOgoqIEJJT1NUQVIgVEE3ODBHIE0yKwoqIEFTUk9DSyBLMTBONzhG
dWxsSEQtaFNMSSBSMy4wCkJvdGggdXNlIDMgc3RhY2ssIDZjaCBtb2RlIHdpdGggZGlnaXRhbCBv
dXQuIFNpbmNlIGF1dG9kZXRlY3Rpb24gaXNuJ3QgYWJsZQp0byBmaWd1cmUgdGhhdCBvdXQgZnJv
bSBCSU9TLCB3ZSBuZWVkIHRvIHNwZWNpZnkgdGhhdCBtYW51YWxseS4KClNpZ25lZC1vZmYtYnk6
IFZlZHJhbiBNaWxldGljIDxyaXZhbnZ4QGdtYWlsLmNvbT4KLS0tCiBwY2kvaGRhL3BhdGNoX3Jl
YWx0ZWsuYyB8ICAgIDMgKysrCiAxIGZpbGVzIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMCBk
ZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9wY2kvaGRhL3BhdGNoX3JlYWx0ZWsuYyBiL3BjaS9o
ZGEvcGF0Y2hfcmVhbHRlay5jCmluZGV4IGMyZmY4NWQuLjA4MWZmYTEgMTAwNjQ0Ci0tLSBhL3Bj
aS9oZGEvcGF0Y2hfcmVhbHRlay5jCisrKyBiL3BjaS9oZGEvcGF0Y2hfcmVhbHRlay5jCkBAIC0x
NTcwMyw2ICsxNTcwMyw5IEBAIHN0YXRpYyBzdHJ1Y3Qgc25kX3BjaV9xdWlyayBhbGM2NjJfY2Zn
X3RibFtdID0gewogCVNORF9QQ0lfUVVJUksoMHgxN2FhLCAweDEwMWUsICJMZW5vdm8iLCBBTEM2
NjJfTEVOT1ZPXzEwMUUpLAogCVNORF9QQ0lfUVVJUksoMHgxMDE5LCAweDkwODcsICJFQ1MiLCBB
TEM2NjJfRUNTKSwKIAlTTkRfUENJX1FVSVJLKDB4MTA1YiwgMHgwY2Q2LCAiRm94Y29ubiIsIEFM
QzY2Ml9FQ1MpLAorCVNORF9QQ0lfUVVJUksoMHgxNTY1LCAweDgyMGYsICJCaW9zdGFyIFRBNzgw
RyBNMisiLCBBTEM2NjJfM1NUXzZjaF9ESUcpLAorCVNORF9QQ0lfUVVJUksoMHgxODQ5LCAweDA3
NzQsICJBU1JPQ0sgSzEwTjc4RnVsbEhELWhTTEkgUjMuMCIsCisJCQkJCUFMQzY2Ml8zU1RfNmNo
X0RJRyksCiAJU05EX1BDSV9RVUlSSygweDE4NTQsIDB4MjAwMCwgIkFTVVMgSDEzLTIwMDAiLCBB
TEM2NjNfQVNVU19IMTMpLAogCVNORF9QQ0lfUVVJUksoMHgxODU0LCAweDIwMDEsICJBU1VTIEgx
My0yMDAxIiwgQUxDNjYzX0FTVVNfSDEzKSwKIAlTTkRfUENJX1FVSVJLKDB4MTg1NCwgMHgyMDAy
LCAiQVNVUyBIMTMtMjAwMiIsIEFMQzY2M19BU1VTX0gxMyksCi0tIAoxLjUuNi41Cgo=
------=_Part_5761_2998621.1222713573468
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

------=_Part_5761_2998621.1222713573468--
