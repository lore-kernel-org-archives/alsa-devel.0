From: Kailang <kailang@realtek.com>
Subject: No Loopback for ALC225/ALC295
Date: Fri, 21 Jul 2017 09:24:44 +0000
Message-ID: <6FAB7C47BCF00940BB0999A99BE3547A183F3E52@RTITMBSV02.realtek.com.tw>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="_002_6FAB7C47BCF00940BB0999A99BE3547A183F3E52RTITMBSV02realt_"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 by alsa0.perex.cz (Postfix) with ESMTP id 60626266C39
 for <alsa-devel@alsa-project.org>; Fri, 21 Jul 2017 11:24:51 +0200 (CEST)
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

--_002_6FAB7C47BCF00940BB0999A99BE3547A183F3E52RTITMBSV02realt_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable


Hi Takashi,

There are also no loopback mixer for ALC225 / ALC295 codecs.
Attach is the update patch.
Many Thanks.

BR,
Kailang=

--_002_6FAB7C47BCF00940BB0999A99BE3547A183F3E52RTITMBSV02realt_
Content-Type: application/octet-stream;
	name="0000-no-loopback-alc225-alc295.patch"
Content-Description: 0000-no-loopback-alc225-alc295.patch
Content-Disposition: attachment;
	filename="0000-no-loopback-alc225-alc295.patch"; size=786;
	creation-date="Fri, 21 Jul 2017 09:22:33 GMT";
	modification-date="Fri, 21 Jul 2017 09:20:57 GMT"
Content-Transfer-Encoding: base64

RnJvbSAwYjFkMmNjMGMyYzUyMzJlNTgzOWYwYzcyZWFhNDNkMzRmOTI4MjQwIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBLYWlsYW5nIFlhbmcgPGthaWxhbmdAcmVhbHRlay5jb20+CkRh
dGU6IEZyaSwgMjEgSnVsIDIwMTcgMTc6MTU6MDcgKzA4MDAKU3ViamVjdDogW1BBVENIXSBBTFNB
OiBoZGEvcmVhbHRlayAtIE5vIGxvb3BiYWNrIG9uIEFMQzIyNS9BTEMyOTUgY29kZWMKCkFMQzIy
NS9BTEMyOTUgYWxzbyBoYXZlIG5vIGxvb3BiYWNrIG1peGVyLgoKU2lnbmVkLW9mZi1ieTogS2Fp
bGFuZyBZYW5nIDxrYWlsYW5nQHJlYWx0ZWsuY29tPgoKZGlmZiAtLWdpdCBhL3NvdW5kL3BjaS9o
ZGEvcGF0Y2hfcmVhbHRlay5jIGIvc291bmQvcGNpL2hkYS9wYXRjaF9yZWFsdGVrLmMKaW5kZXgg
MGNlMzJkZi4uNGY5YjdiZSAxMDA2NDQKLS0tIGEvc291bmQvcGNpL2hkYS9wYXRjaF9yZWFsdGVr
LmMKKysrIGIvc291bmQvcGNpL2hkYS9wYXRjaF9yZWFsdGVrLmMKQEAgLTY3NzgsNiArNjc3OCw3
IEBAIHN0YXRpYyBpbnQgcGF0Y2hfYWxjMjY5KHN0cnVjdCBoZGFfY29kZWMgKmNvZGVjKQogCWNh
c2UgMHgxMGVjMDIyNToKIAljYXNlIDB4MTBlYzAyOTU6CiAJCXNwZWMtPmNvZGVjX3ZhcmlhbnQg
PSBBTEMyNjlfVFlQRV9BTEMyMjU7CisJCXNwZWMtPmdlbi5taXhlcl9uaWQgPSAwOyAvKiBubyBs
b29wYmFjayBvbiBBTEMyMjUgQUxDMjk1ICovCiAJCWJyZWFrOwogCWNhc2UgMHgxMGVjMDI5OToK
IAkJc3BlYy0+Y29kZWNfdmFyaWFudCA9IEFMQzI2OV9UWVBFX0FMQzIyNTsK

--_002_6FAB7C47BCF00940BB0999A99BE3547A183F3E52RTITMBSV02realt_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--_002_6FAB7C47BCF00940BB0999A99BE3547A183F3E52RTITMBSV02realt_--
