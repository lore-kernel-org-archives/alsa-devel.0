From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 0/6 v4] Add ASoC support for AMD Stoney APUs
Date: Wed, 13 Sep 2017 14:49:08 -0400
Message-ID: <CADnq5_PdpjS448n6u6tPBqgKfEw278BENMTjVPiEQ4zQx313AA@mail.gmail.com>
References: <1505325475-22602-1-git-send-email-alexander.deucher@amd.com>
 <20170913181218.bb2br4zehzjoatyq@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20170913181218.bb2br4zehzjoatyq-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Help: <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=subscribe>
Errors-To: amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Sender: "amd-gfx" <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: "alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org" <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Maling list - DRI developers <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, rajeev kumar <rajeevkumar.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Vijendar Mukunda <Vijendar.Mukunda-5C7GfCeVMHo@public.gmane.org>, Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, perex-/Fr2/VpizcU@public.gmane.org, Dave Airlie <airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

T24gV2VkLCBTZXAgMTMsIDIwMTcgYXQgMjoxMiBQTSwgTWFyayBCcm93biA8YnJvb25pZUBrZXJu
ZWwub3JnPiB3cm90ZToKPiBPbiBXZWQsIFNlcCAxMywgMjAxNyBhdCAwMTo1Nzo0OVBNIC0wNDAw
LCBBbGV4IERldWNoZXIgd3JvdGU6Cj4KPj4gSSBqdXN0IG5lZWQgYWNrcyBmcm9tIGF1ZGlvIG9u
IHRoZSByZW1haW5pbmcgcGF0Y2hlcyB0aGF0IHRvdWNoIGF1ZGlvCj4+ICgxLCA1LCA2KSwgYW5k
IHRoZW4gSSBjYW4gc2VuZCBhIHB1bGwgcmVxdWVzdC4KPgo+IE5vLCBzZW5kIG1lIGEgcHVsbCBy
ZXF1ZXN0IGZvciB0aGUgZGVwZW5kZW5jaWVzIHNvIHdlIGNhbiBkbyBhIGNyb3NzCj4gbWVyZ2Uu
ICBJIHdhbnQgdG8gbWFrZSBzdXJlIHRoYXQgd2hlbiB0aGlzIGdldHMgcmV2aWV3ZWQgaXQgYWN0
dWFsbHkKPiBnZXRzIG1lcmdlZC4KCkknbSBub3QgcXVpdGUgc3VyZSB3aGF0IHlvdSBtZWFuIGJ5
IHRoZSBjcm9zcyBtZXJnZS4gIFRoZXJlIGFyZSBubwpkZXBlbmRlbmNpZXMgb3V0c2lkZSB0aGlz
IHBhdGNoIHNldC4gIFRoZSBvbmx5IHBhdGNoZXMgdGhhdCB0b3VjaCBkcm0KYXJlIHBhdGNoZXMg
MSBhbmQgMi4gIFBhdGNoIDEgdG91Y2hlcyBib3RoIGF1ZGlvIGFuZCBkcm0sIHBhdGNoIDIganVz
dAp0b3VjaGVzIGRybS4gIERvIHlvdSB3YW50IG1lIHRvIHNlbmQgeW91IGEgcHVsbCByZXF1ZXN0
IGZvciBwYXRjaGVzIDEKYW5kIDIgYW5kIHRoZW4gd291bGQgeW91J2Qgc2VuZCBEYXZlIGEgcHVs
bCByZXF1ZXN0IGZvciB0aGUgYXVkaW8gc2lkZQoocGF0Y2hlcyAzLTYpPwoKQWxleApfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcg
bGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNr
dG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
