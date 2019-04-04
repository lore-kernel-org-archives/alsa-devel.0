From: Annaliese McDermond <nh6z@nh6z.net>
Subject: Re: [PATCH 1/2] ASoC: tlv320aic32x4: Add Switch for
	Setting Common Mode Voltage
Date: Thu, 4 Apr 2019 03:45:31 -0700
Message-ID: <77890BB1-16C4-4109-A80F-7B2C74FB5DF6@nh6z.net>
References: <20190404040155.29246-1-nh6z@nh6z.net>
 <20190404054322.GM5748@sirena.org.uk>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp97.ord1c.emailsrvr.com (smtp97.ord1c.emailsrvr.com
 [108.166.43.97])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6C1AFF80714
 for <alsa-devel@alsa-project.org>; Thu,  4 Apr 2019 12:45:37 +0200 (CEST)
In-Reply-To: <20190404054322.GM5748@sirena.org.uk>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, team@nwdigitalradio.com
List-Id: alsa-devel@alsa-project.org

Cj4gT24gQXByIDMsIDIwMTksIGF0IDEwOjQzIFBNLCBNYXJrIEJyb3duIDxicm9vbmllQGtlcm5l
bC5vcmc+IHdyb3RlOgo+IAo+PiBPbiBXZWQsIEFwciAwMywgMjAxOSBhdCAwOTowMTo1NFBNIC0w
NzAwLCBBbm5hbGllc2UgTWNEZXJtb25kIHdyb3RlOgo+PiBBZGQgYSBzd2l0Y2ggZm9yIHNldHRp
bmcgY29tbW9uIG1vZGUgdm9sdGFnZS4gIFRoaXMgY2FuIGFsbG93Cj4+IGZvciBoaWdoZXIgZHJp
dmUgbGV2ZWxzIG9uIHRoZSBhbXBsaWZpZXIgb3V0cHV0cy4KPiAKPiBTaG91bGQgdGhpcyBiZSBy
dW50aW1lIGNvbnRyb2xsYWJsZSBvciBpcyB0aGlzIHNvbWV0aGluZyB0aGF0J3MgbGlrZWx5Cj4g
dG8gYmUgZml4ZWQgYnkgdGhlIGJvYXJkIGRlc2lnbj8KCkZvciB1cywgaW4gb3VyIHBhcnRpY3Vs
YXIgYXBwbGljYXRpb24sIGl04oCZcyByZWFsbHkgbmVjZXNzYXJ5IGF0IHJ1bnRpbWUuIE91ciB1
c2UKY2FzZSBpcyBub3QgdGhhdCB3ZSBhcmUgZHJpdmluZyBzcGVha2VycywgYnV0IHRoZSBpbnB1
dHMgb2YgdmFyaW91cyBhbWF0ZXVyIApyYWRpbyB1bml0cy4gRXhwZXJpZW5jZSBoYXMgc2hvd24g
dXMgdGhhdCB0aGUgaW5wdXQgY2hhcmFjdGVyaXN0aWNzIG9mIHRoZXNlIApkZXZpY2VzIHZhcnkg
d2lkZWx5IGFuZCByZXF1aXJlIGRpZmZlcmVudCBsZXZlbHMgb2YgZHJpdmUgdG8gZnVuY3Rpb24g
CmNvcnJlY3RseTsgYSBNb3Rvcm9sYSBtYXkgbmVlZCBhIGxvdCBvZiBkcml2ZSBjb21wYXJlZCB0
byBhbiBJY29tIHRoYXQgCnJlcXVpcmVzIGFsbW9zdCBub25lLiAKCldlIGNvdWxkIG1vZGlmeSB0
aGUgYm9hcmQgdG8gaGF2ZSBhbiBvdXRib2FyZCBhbXBsaWZpZXIgb2Ygc29tZSBzb3J0IG9uIApp
dCwgYnV0IHRoYXQganVzdCBtb3ZlcyB0aGUgcHJvYmxlbSB0byBhbm90aGVyIGNvbXBvbmVudC4g
ICBPciB3ZSBjb3VsZCBwdXQgCnNvbWUgc29ydCBvZiBwcmVzY2FsaW5nIHN3aXRjaGFibGUgcmVz
aXN0b3JzIGluIHRoZSBib2FyZCwgYnV0IHRoaXMgYWxzbyBhZGRzIApjb21wbGV4aXR5IHRoYXTi
gJlzIGR1YmlvdXMuIAoKSeKAmXZlIHRob3VnaHQgYWJvdXQgcHV0dGluZyB0aGVzZSBpbiB0aGUg
RFQsIGJ1dCBpdCBvY2N1cnMgdG8gbWUgdGhhdCB0aGV5IGFyZSAKcmVhbGx5IG5vdCBib2FyZCBk
ZXNpZ24gZGVwZW5kZW50LiBUaGUgb3B0aW9ucyBhcmUgcmVhbGx5IHRoZXJlIHRvIGNvbnRyb2wg
CnBvd2VyIGNvbnN1bXB0aW9uIG9uIHRoZSBjaGlwLiBJbiBvdXIgYXBwbGljYXRpb24gdGhhdOKA
mXMgcmVhbGx5IG5vdCBpbXBvcnRhbnQuIApGb3Igb3RoZXIgYXBwbGljYXRpb25zIEkgY2FuIHNl
ZSB3aGVyZSB0aGF0IG1pZ2h0IGJlIHVzZWZ1bCB0byBjaGFuZ2UgCmR5bmFtaWNhbGx5IGF0IHJ1
bnRpbWUgZGVwZW5kaW5nIG9uIGN1cnJlbnQgY29uZGl0aW9ucy4gCgrigJQKQW5uYWxpZXNlIE1j
RGVybW9uZApuaDZ6QG5oNnoubmV0Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9q
ZWN0Lm9yZwpodHRwczovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2Fsc2EtZGV2ZWwK
