From: jimqu <jimqu-5C7GfCeVMHo@public.gmane.org>
Subject: =?UTF-8?Q?Re:_=e7=ad=94=e5=a4=8d:_[PATCH_3/4]_drm/radeon:_Add_audio?=
 =?UTF-8?Q?_component_support?=
Date: Wed, 25 Jul 2018 13:40:08 +0800
Message-ID: <55f9b97c-9f35-ec91-dcae-90a6d63e527a@amd.com>
References: <20180723145030.25133-1-tiwai@suse.de>
 <s5h8t5zyjch.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <s5h8t5zyjch.wl-tiwai-l3A5Bk7waGM@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Help: <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=subscribe>
Errors-To: amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Sender: "amd-gfx" <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
To: Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, "Qu, Jim" <Jim.Qu-5C7GfCeVMHo@public.gmane.org>
Cc: "alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org" <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

CgpPbiAyMDE45bm0MDfmnIgyNeaXpSAxMzoyOCwgVGFrYXNoaSBJd2FpIHdyb3RlOgo+IE9uIFdl
ZCwgMjUgSnVsIDIwMTggMDU6MzI6NTIgKzAyMDAsCj4gUXUsIEppbSB3cm90ZToKPj4gQEAgLTI2
OSw2ICsyNzEsMTAgQEAgc3RhdGljIHZvaWQgcmFkZW9uX2F1ZGlvX2VuYWJsZShzdHJ1Y3QgcmFk
ZW9uX2RldmljZSAqcmRldiwKPj4KPj4gICAgICAgICAgaWYgKHJkZXYtPmF1ZGlvLmZ1bmNzLT5l
bmFibGUpCj4+ICAgICAgICAgICAgICAgICAgcmRldi0+YXVkaW8uZnVuY3MtPmVuYWJsZShyZGV2
LCBwaW4sIGVuYWJsZV9tYXNrKTsKPj4gKwo+PiArICAgICAgIGlmIChhY29tcCAmJiBhY29tcC0+
YXVkaW9fb3BzICYmIGFjb21wLT5hdWRpb19vcHMtPnBpbl9lbGRfbm90aWZ5KQo+PiArICAgICAg
ICAgICAgICAgYWNvbXAtPmF1ZGlvX29wcy0+cGluX2VsZF9ub3RpZnkoYWNvbXAtPmF1ZGlvX29w
cy0+YXVkaW9fcHRyLAo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgcGluLT5pZCwgLTEpOwo+Pgo+PiBKaW06IHJhZGVvbl9hdWRpb19lbmFibGUoKSBj
YW4gZW5hYmxlIGF1ZGlvcyBhbmQgYWxzbyBkaXNhYmxlIHRoZW0sIHNvIGVsZCBub2l0ZnkgY2Fs
bGJhY2sgc2hvdWxkIGJlIGNhbGxlZCB3aGVuIGVuYWJsZV9tYXNrIGlzIHRydWUuCj4gSXQncyBp
bnRlbnRpb25hbC4gIFRoZSBub3RpZmllciBuZWVkcyB0byBiZSBjYWxsZWQgYXQgZGlzYWJsZW1l
bnQKPiB0aW1lLCB0b28uICBUaGUgYXVkaW8gZHJpdmVyIGhhcyB0byBmb2xsb3cgdGhlIEhETUkg
YXVkaW8gZGlzYWJsZW1lbnQsCj4gYW5kIG5vdGlmaWVyIHJlY2VpdmVzIGJvdGggb24gYW5kIG9m
ZiBjYXNlLgo+Cj4gVGhlIGFjdHVhbCBzdGF0ZSBpcyBpbnF1aXJlZCB2aWEgZ2V0X2VsZCBjYWxs
IGJ5IEhELWF1ZGlvIGZvbGxvd2VkCj4gYWZ0ZXIgdGhlIG5vdGlmaWNhdGlvbi4KPgo+Cj4gdGhh
bmtzLAo+Cj4gVGFrYXNoaQoKT0ssIEkgZ290IHlvdXIgcG9pbnQuCgpUaGFua3MKSmltUXUKCgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1h
aWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZy
ZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
