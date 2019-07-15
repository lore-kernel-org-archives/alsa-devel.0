From: Kailang <kailang@realtek.com>
Subject: Dell ALC295 Headphone Mic can't record
Date: Mon, 15 Jul 2019 02:50:20 +0000
Message-ID: <6FAB7C47BCF00940BB0999A99BE3547A1D769F1A@RTITMBSVM07.realtek.com.tw>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="_004_6FAB7C47BCF00940BB0999A99BE3547A1D769F1ARTITMBSVM07real_"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id EC200F800D8
 for <alsa-devel@alsa-project.org>; Mon, 15 Jul 2019 04:50:30 +0200 (CEST)
Content-Language: zh-TW
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: "Takashi Iwai (tiwai@suse.de)" <tiwai@suse.de>
Cc: " (alsa-devel@alsa-project.org)" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

--_004_6FAB7C47BCF00940BB0999A99BE3547A1D769F1ARTITMBSVM07real_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Takashi,

Attach patch was for Dell ALC295 Headphone Mic can't record.
Thanks.

BR,
Kailang

--_004_6FAB7C47BCF00940BB0999A99BE3547A1D769F1ARTITMBSVM07real_
Content-Type: application/octet-stream;
	name="0000-dell-alc295-HP-Mic-fail.patch"
Content-Description: 0000-dell-alc295-HP-Mic-fail.patch
Content-Disposition: attachment;
	filename="0000-dell-alc295-HP-Mic-fail.patch"; size=1176;
	creation-date="Mon, 15 Jul 2019 02:48:01 GMT";
	modification-date="Mon, 15 Jul 2019 02:47:06 GMT"
Content-Transfer-Encoding: base64

RnJvbSAxODJmOWI0ZjEzYmQyNzNhMmM5ZTg2ZTMwMjZmYzZhMjEwMmY1YWY5IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBLYWlsYW5nIFlhbmcgPGthaWxhbmdAcmVhbHRlay5jb20+CkRh
dGU6IE1vbiwgMTUgSnVsIDIwMTkgMTA6NDE6NTAgKzA4MDAKU3ViamVjdDogW1BBVENIXSBBTFNB
OiBoZGEvcmVhbHRlayAtIEZpeGVkIEhlYWRwaG9uZSBNaWMgY2FuJ3QgcmVjb3JkIG9uIERlbGwK
IHBsYXRmb3JtCgpJdCBhc3NpZ25lZCB0byB3cm9uZyBtb2RlbC4gU28sIFRoZSBoZWFkcGhvbmUg
TWljIGNhbid0IHdvcmsuCgpTaWduZWQtb2ZmLWJ5OiBLYWlsYW5nIFlhbmcgPGthaWxhbmdAcmVh
bHRlay5jb20+CgpkaWZmIC0tZ2l0IGEvc291bmQvcGNpL2hkYS9wYXRjaF9yZWFsdGVrLmMgYi9z
b3VuZC9wY2kvaGRhL3BhdGNoX3JlYWx0ZWsuYwppbmRleCAwZjc3NjQ0NGFiODYuLjE5NmRlNTFm
OGRjNiAxMDA2NDQKLS0tIGEvc291bmQvcGNpL2hkYS9wYXRjaF9yZWFsdGVrLmMKKysrIGIvc291
bmQvcGNpL2hkYS9wYXRjaF9yZWFsdGVrLmMKQEAgLTc2NzAsOSArNzY3MCwxMiBAQCBzdGF0aWMg
Y29uc3Qgc3RydWN0IHNuZF9oZGFfcGluX3F1aXJrIGFsYzI2OV9waW5fZml4dXBfdGJsW10gPSB7
CiAJCXsweDEyLCAweDkwYTYwMTMwfSwKIAkJezB4MTcsIDB4OTAxNzAxMTB9LAogCQl7MHgyMSwg
MHgwMzIxMTAyMH0pLAotCVNORF9IREFfUElOX1FVSVJLKDB4MTBlYzAyOTUsIDB4MTAyOCwgIkRl
bGwiLCBBTEMyNjlfRklYVVBfREVMTDFfTUlDX05PX1BSRVNFTkNFLAorCVNORF9IREFfUElOX1FV
SVJLKDB4MTBlYzAyOTUsIDB4MTAyOCwgIkRlbGwiLCBBTEMyNjlfRklYVVBfREVMTDRfTUlDX05P
X1BSRVNFTkNFLAogCQl7MHgxNCwgMHg5MDE3MDExMH0sCiAJCXsweDIxLCAweDA0MjExMDIwfSks
CisJU05EX0hEQV9QSU5fUVVJUksoMHgxMGVjMDI5NSwgMHgxMDI4LCAiRGVsbCIsIEFMQzI2OV9G
SVhVUF9ERUxMNF9NSUNfTk9fUFJFU0VOQ0UsCisJCXsweDE0LCAweDkwMTcwMTEwfSwKKwkJezB4
MjEsIDB4MDQyMTEwMzB9KSwKIAlTTkRfSERBX1BJTl9RVUlSSygweDEwZWMwMjk1LCAweDEwMjgs
ICJEZWxsIiwgQUxDMjY5X0ZJWFVQX0RFTEwxX01JQ19OT19QUkVTRU5DRSwKIAkJQUxDMjk1X1NU
QU5EQVJEX1BJTlMsCiAJCXsweDE3LCAweDIxMDE0MDIwfSwK

--_004_6FAB7C47BCF00940BB0999A99BE3547A1D769F1ARTITMBSVM07real_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--_004_6FAB7C47BCF00940BB0999A99BE3547A1D769F1ARTITMBSVM07real_--
