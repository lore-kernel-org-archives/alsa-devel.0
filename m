From: Kailang <kailang@realtek.com>
Subject: New SSID for Dell Headset mode
Date: Mon, 27 Oct 2014 08:38:16 +0000
Message-ID: <6FAB7C47BCF00940BB0999A99BE3547A179FA42A@RTITMBSV09.realtek.com.tw>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="_002_6FAB7C47BCF00940BB0999A99BE3547A179FA42ARTITMBSV09realt_"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id D7E5D2607F8
 for <alsa-devel@alsa-project.org>; Mon, 27 Oct 2014 09:38:21 +0100 (CET)
Content-Language: zh-TW
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Takashi Iwai (tiwai@suse.de)" <tiwai@suse.de>
Cc: " (alsa-devel@alsa-project.org)" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

--_002_6FAB7C47BCF00940BB0999A99BE3547A179FA42ARTITMBSV09realt_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Takashi,
=20
Dell has new machine. That SSID was 0x069f.
It is the lite version of 0x0626.
The audio layout was the same.
Attach patch was add the SSID for the fixup table.
=20
Many Thanks.
=20
BR,
Kailang

--_002_6FAB7C47BCF00940BB0999A99BE3547A179FA42ARTITMBSV09realt_
Content-Type: application/octet-stream;
	name="0000-new-ssid-for-dell-headset-quirk.patch"
Content-Description: 0000-new-ssid-for-dell-headset-quirk.patch
Content-Disposition: attachment;
	filename="0000-new-ssid-for-dell-headset-quirk.patch"; size=1220;
	creation-date="Mon, 27 Oct 2014 08:34:04 GMT";
	modification-date="Mon, 27 Oct 2014 08:33:20 GMT"
Content-Transfer-Encoding: base64

RnJvbSA4YzMyMGE4ZTJlMmRjOTY1MWUyOTA2MjUwYWZkYWExOTZlNzBlYzlhIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBLYWlsYW5nIFlhbmcgPGthaWxhbmdAcmVhbHRlay5jb20+CkRh
dGU6IE1vbiwgMjcgT2N0IDIwMTQgMTY6MjA6MzAgKzA4MDAKU3ViamVjdDogW1BBVENIXSBBTFNB
OiBoZGEvcmVhbHRlayAtIE5ldyBTU0lEIGZvciBIZWFkc2V0IHF1aXJrCgpJdCBpcyBsaXRlIHZl
cnNpb24gb2YgQUlPIG1hY2hpbmUoMHgwNjI2KS4KVGhlIGF1ZGlvIGxheW91dCBvZiB0aGlzIG1h
Y2hpbmUgd2FzIHNpbWlsYXIgd2l0aCBTU0lEIDB4MDYyNi4KVGhlIGF1ZGlvIHdhcyBzYW1lIGFz
IGNvbW1pdCBhZDhmZjk5ZTZiZWI4NzA4YjBiZGVmZDlkNTY1ODMyNGU5MDIwMGYwLgoKU2lnbmVk
LW9mZi1ieTogS2FpbGFuZyBZYW5nIDxrYWlsYW5nQHJlYWx0ZWsuY29tPgoKZGlmZiAtLWdpdCBh
L3NvdW5kL3BjaS9oZGEvcGF0Y2hfcmVhbHRlay5jIGIvc291bmQvcGNpL2hkYS9wYXRjaF9yZWFs
dGVrLmMKaW5kZXggYWU5NjhjMS4uYzljZjI0OCAxMDA2NDQKLS0tIGEvc291bmQvcGNpL2hkYS9w
YXRjaF9yZWFsdGVrLmMKKysrIGIvc291bmQvcGNpL2hkYS9wYXRjaF9yZWFsdGVrLmMKQEAgLTU5
MjMsNiArNTkyMyw3IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3Qgc25kX3BjaV9xdWlyayBhbGM2NjJf
Zml4dXBfdGJsW10gPSB7CiAJU05EX1BDSV9RVUlSSygweDEwMjgsIDB4MDYyNiwgIkRlbGwiLCBB
TEM2NjhfRklYVVBfREVMTF9NSUNfTk9fUFJFU0VOQ0UpLAogCVNORF9QQ0lfUVVJUksoMHgxMDI4
LCAweDA2OTYsICJEZWxsIiwgQUxDNjY4X0ZJWFVQX0RFTExfTUlDX05PX1BSRVNFTkNFKSwKIAlT
TkRfUENJX1FVSVJLKDB4MTAyOCwgMHgwNjk4LCAiRGVsbCIsIEFMQzY2OF9GSVhVUF9ERUxMX01J
Q19OT19QUkVTRU5DRSksCisJU05EX1BDSV9RVUlSSygweDEwMjgsIDB4MDY5ZiwgIkRlbGwiLCBB
TEM2NjhfRklYVVBfREVMTF9NSUNfTk9fUFJFU0VOQ0UpLAogCVNORF9QQ0lfUVVJUksoMHgxMDNj
LCAweDE2MzIsICJIUCBSUDU4MDAiLCBBTEM2NjJfRklYVVBfSFBfUlA1ODAwKSwKIAlTTkRfUENJ
X1FVSVJLKDB4MTA0MywgMHgxMWNkLCAiQXN1cyBONTUwIiwgQUxDNjYyX0ZJWFVQX0JBU1NfMUEp
LAogCVNORF9QQ0lfUVVJUksoMHgxMDQzLCAweDE0NzcsICJBU1VTIE41NlZaIiwgQUxDNjYyX0ZJ
WFVQX0JBU1NfTU9ERTRfQ0hNQVApLAo=

--_002_6FAB7C47BCF00940BB0999A99BE3547A179FA42ARTITMBSV09realt_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--_002_6FAB7C47BCF00940BB0999A99BE3547A179FA42ARTITMBSV09realt_--
