From: "=?UTF-8?Q?Vedran_Mileti=C4=87?=" <rivanvx@gmail.com>
Subject: Re: [PATCH] ALSA: emu10k1: fix device names for
	Live!/Audigy1/2/4/E-mu and coding style
Date: Tue, 21 Oct 2008 19:18:31 +0200
Message-ID: <fd3eb9bf0810211018r50a12e5bu6a3141e16762fe91@mail.gmail.com>
References: <fd3eb9bf0810190533l75f8b20kd31a3dbb158d7c0f@mail.gmail.com>
	<s5h7i83rdvr.wl%tiwai@suse.de>
	<fd3eb9bf0810210200l45b33311o7ec5d674b53f5912@mail.gmail.com>
	<s5habcykl3o.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_436_15960198.1224609511647"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gx0-f17.google.com (mail-gx0-f17.google.com
	[209.85.217.17]) by alsa0.perex.cz (Postfix) with ESMTP id 483F8247E2
	for <alsa-devel@alsa-project.org>;
	Tue, 21 Oct 2008 19:18:51 +0200 (CEST)
Received: by gxk10 with SMTP id 10so5816190gxk.8
	for <alsa-devel@alsa-project.org>; Tue, 21 Oct 2008 10:18:32 -0700 (PDT)
In-Reply-To: <s5habcykl3o.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, alsa-devel mailing list <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

------=_Part_436_15960198.1224609511647
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Content-Disposition: inline

SGVyZSdzIGEgZml4IGZvciBteSBjb21taXQuIFNvcnJ5IGFnYWluLgoKQUxTQTogZW11MTBrMTog
Zml4IGZhdWx0eSBjb21taXQgMThjNzEwOTI4OTYyNTEwNmNkYzgxMGIyMGI2MjhjZDEzYjQ2ZDZk
ZAoKQ29tbWl0IDE4YzcxMDkyODk2MjUxMDZjZGM4MTBiMjBiNjI4Y2QxM2I0NmQ2ZGQgaGFkICNl
bmRpZiBsZWZ0b2ZmIGZyb20KY29tcGlsYXRpb24uIFRoaXMgcGF0Y2ggZml4ZXMgaXQuCkFsc28s
IEkgcmVwbGFjZWQgYSBtaXNwbGFjZWQgY29tbWVudCBieSBhIHVzZWZ1bCBvbmUsIHRoYXQgZXhw
bGFpbnMgd2h5IGFyZQpoZXJlICNpZmRlZiBhbmQgI2VuZGlmIGFkZGVkIGluIGNvbXBpbGF0aW9u
LgoKU2lnbmVkLW9mZi1ieTogVmVkcmFuIE1pbGV0aWMgPHJpdmFudnhAZ21haWwuY29tPgoKMjAw
OC8xMC8yMSBUYWthc2hpIEl3YWkgPHRpd2FpQHN1c2UuZGU+Ogo+IEF0IFR1ZSwgMjEgT2N0IDIw
MDggMTE6MDA6MTEgKzAyMDAsCj4gPT9VVEYtOD9RP1ZlZHJhbl9NaWxldGk9QzQ9ODc/PSB3cm90
ZToKPj4KPj4gRmlyc3QgcGFydC4gUGxlYXNlIGNoZWNraW4gdGhpcyBpZiBwb3NzaWJsZSwgYW5k
IHRoZW4gSSB3aWxsIHNlbmQgeW91Cj4+IHRoZSBzZWNvbmQgcGFydCAoY29kaW5nIHN0eWxlIGZp
eGVzKS4KPj4KPj4gQUxTQTogZW11MTBrMTogZml4IGRldmljZSBuYW1lcyBmb3IgTGl2ZSEvQXVk
aWd5MS8yLzQvRS1tdQo+Pgo+PiBDaGFuZ2Vsb2c6Cj4+ICogYWRkZWQgbWlzc2luZyBTQnh4eHgs
IENUeHh4eCwgUEN4eHggYW5kIE1BRU14eHh4IHdoZXJlIHRoZXkgd2VyZSBtaXNzaW5nLAo+PiBh
bmQgZml4ZWQgc29tZSBvZiB0aGVtIHdoaWNoIHdlcmUgd3JvbmcgKGFjY29yZGluZyB0byBreC5p
bmYsIHdoaWNoIGlzIHByZXR0eQo+PiBhY2N1cmF0ZSBjb21wYXJlZCB0byBhbnl0aGluZyBvdXQg
dGhlcmUpCj4+ICogZml4ZWQgZGV2aWNlIG5hbWVzIHRvIG1ha2UgdGhlbSBtb3JlIGNvbnNpc3Rl
bnQgYWNyb3NzIHZhcmlvdXMgY2FyZHMKPj4gKiBmaXhlZCBvcmRlciBvZiBkZXZpY2VzIHdoZXJl
IGFwcHJvcHJpYXRlCj4+Cj4+IFNpZ25lZC1vZmYtYnk6IFZlZHJhbiBNaWxldGljIDxyaXZhbnZ4
QGdtYWlsLmNvbT4KPgo+IFRoYW5rcywgYXBwbGllZCBub3cgKHdpdGggYSBzbGlnaHQgY29kaW5n
LXN0eWxlIGZpeCkuCj4KPgo+IFRha2FzaGkKPgoKCgotLSAKVmVkcmFuIE1pbGV0acSHCg==
------=_Part_436_15960198.1224609511647
Content-Type: text/x-patch; name=fix_my_commit.patch
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fmksvl2g0
Content-Disposition: attachment; filename=fix_my_commit.patch

QUxTQTogZW11MTBrMTogZml4IGZhdWx0eSBjb21taXQgMThjNzEwOTI4OTYyNTEwNmNkYzgxMGIy
MGI2MjhjZDEzYjQ2ZDZkZAoKQ29tbWl0IDE4YzcxMDkyODk2MjUxMDZjZGM4MTBiMjBiNjI4Y2Qx
M2I0NmQ2ZGQgaGFkICNlbmRpZiBsZWZ0b2ZmIGZyb20KY29tcGlsYXRpb24uIFRoaXMgcGF0Y2gg
Zml4ZXMgaXQuCkFsc28sIEkgcmVwbGFjZWQgYSBtaXNwbGFjZWQgY29tbWVudCBieSBhIHVzZWZ1
bCBvbmUsIHRoYXQgZXhwbGFpbnMgd2h5IGFyZQpoZXJlICNpZmRlZiBhbmQgI2VuZGlmIGFkZGVk
IGluIGNvbXBpbGF0aW9uLgoKU2lnbmVkLW9mZi1ieTogVmVkcmFuIE1pbGV0aWMgPHJpdmFudnhA
Z21haWwuY29tPgotLS0KIHNvdW5kL3BjaS9lbXUxMGsxL2VtdTEwazFfbWFpbi5jIHwgICAgMyAr
LS0KIDEgZmlsZXMgY2hhbmdlZCwgMSBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlm
ZiAtLWdpdCBhL3NvdW5kL3BjaS9lbXUxMGsxL2VtdTEwazFfbWFpbi5jIGIvc291bmQvcGNpL2Vt
dTEwazEvZW11MTBrMV9tYWluLmMKaW5kZXggNDIzYWEwZC4uMGQ3NDY2YiAxMDA2NDQKLS0tIGEv
c291bmQvcGNpL2VtdTEwazEvZW11MTBrMV9tYWluLmMKKysrIGIvc291bmQvcGNpL2VtdTEwazEv
ZW11MTBrMV9tYWluLmMKQEAgLTE0MzksOCArMTQzOSw3IEBAIHN0YXRpYyBzdHJ1Y3Qgc25kX2Vt
dV9jaGlwX2RldGFpbHMgZW11X2NoaXBfZGV0YWlsc1tdID0gewogCSAuY2EwMTAyX2NoaXAgPSAx
LAogCSAuc3BrNzEgPSAxLAogCSAuZW11X21vZGVsID0gRU1VX01PREVMX0VNVTA0MDR9LCAvKiBF
TVUgMDQwNCAqLwotI2VuZGlmCi0JLyogQXVkaWd5NCAoTm90IFBSTykgU0IwNjEwICovCisJLyog
Tm90ZSB0aGF0IGFsbCBFLW11IGNhcmRzIHJlcXVpcmUga2VybmVsIDIuNiBvciBuZXdlci4gKi8K
IAl7LnZlbmRvciA9IDB4MTEwMiwgLmRldmljZSA9IDB4MDAwOCwKIAkgLmRyaXZlciA9ICJBdWRp
Z3kyIiwgLm5hbWUgPSAiU0IgQXVkaWd5IDIgVmFsdWUgW1Vua25vd25dIiwKIAkgLmlkID0gIkF1
ZGlneTIiLAo=
------=_Part_436_15960198.1224609511647
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

------=_Part_436_15960198.1224609511647--
