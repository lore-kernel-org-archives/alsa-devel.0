From: Jani Nikula <jani.nikula@linux.intel.com>
Subject: Re: [RFC PATCH v3 1/7] drm/i915: setup bridge for HDMI
	LPE audio driver
Date: Mon, 28 Nov 2016 10:06:48 +0200
Message-ID: <871sxw2fl3.fsf@intel.com>
References: <20161124235548.16440-1-jerome.anand@intel.com>
 <20161124235548.16440-2-jerome.anand@intel.com>
 <20161124133154.GQ31595@intel.com>
 <F6867404AABACB4D8EC371BF802A4B7C14925AAA@fmsmsx101.amr.corp.intel.com>
 <8760nbvnl0.fsf@intel.com>
 <F6867404AABACB4D8EC371BF802A4B7C149269C2@fmsmsx101.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
In-Reply-To: <F6867404AABACB4D8EC371BF802A4B7C149269C2@fmsmsx101.amr.corp.intel.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: intel-gfx-bounces@lists.freedesktop.org
Sender: "Intel-gfx" <intel-gfx-bounces@lists.freedesktop.org>
To: "Anand, Jerome" <jerome.anand@intel.com>, Ville =?utf-8?B?U3lyasOk?= =?utf-8?B?bMOk?= <ville.syrjala@linux.intel.com>
Cc: "tiwai@suse.de" <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@kernel.org" <broonie@kernel.org>, "Ughreja,
 Rakesh A" <rakesh.a.ughreja@intel.com>, "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>
List-Id: alsa-devel@alsa-project.org

T24gTW9uLCAyOCBOb3YgMjAxNiwgIkFuYW5kLCBKZXJvbWUiIDxqZXJvbWUuYW5hbmRAaW50ZWwu
Y29tPiB3cm90ZToKPiBMYXN0IHRpbWUgLCBpdCB0b29rIGNsb3NlIHRvIDEwIGRheXMgd2hlbiBt
eSBwYXRjaGVzIHdlcmUgcmVmbGVjdGVkIG9uCj4gdGhlIGdmeCBtYWlsaW5nIGxpc3QuIE5vdCBz
dXJlIHdoYXQgaXMgdGhlIHByb2JsZW0gPz8gTGV0IG1lIHRyeQo+IHNlbmRpbmcgaXQgYWdhaW4g
Pz8KCkkgZ3Vlc3MgdGhlIGxhc3QgdGltZSB0aGV5IG9ubHkgZXZlciBzaG93ZWQgdXAgYmVjYXVz
ZSBWaWxsZSBib3VuY2VkCnRoZW0gdG8gdGhlIGxpc3QgYWZ0ZXIgSSdkIHdvbmRlcmVkIHdoZXJl
IHRoZSBwYXRjaGVzIHdlcmUuLi4KCkNsZWFybHkgdGhlIHBhdGNoZXMgZ28gdGhyb3VnaCB0byBw
ZW9wbGUgZGlyZWN0bHksIGF0IGxlYXN0IFZpbGxlLCBhbmQKeW91ciByZXBsaWVzIG9uIHRoZSBs
aXN0IGdvIHRocm91Z2gsIGJ1dCB0aGVyZSdzIGdvdCB0byBiZSBzb21ldGhpbmcKZ29pbmcgb24g
d2l0aCBob3cgeW91IHNlbmQgcGF0Y2hlcyB0byB0aGUgbGlzdHMuIChJJ2Qgc3VzcGVjdApmcmVl
ZGVza3RvcC5vcmcsIGJ1dCB0aGUgcGF0Y2hlcyB3ZXJlbid0IG9uIGFsc2EtZGV2ZWwgYXJjaGl2
ZSBlaXRoZXIuKQpZb3UgYWxyZWFkeSBzZWVtIHRvIGJlIHVzaW5nICdnaXQgc2VuZC1lbWFpbCcu
IEkgZG9uJ3Qga25vdyB3aGF0IHRvCnN1Z2dlc3QgbmV4dCwgZXhjZXB0IHRvIG1heWJlIHRyeSB0
byBzZW5kIGEgdGVzdCBtYWlsIHRvIHRoZSBsaXN0IHVzaW5nCidnaXQgc2VuZC1lbWFpbCcgYW5k
IHNlZSBpZiBpdCBnb2VzIHRocm91Z2guCgpCUiwKSmFuaS4KCgotLSAKSmFuaSBOaWt1bGEsIElu
dGVsIE9wZW4gU291cmNlIFRlY2hub2xvZ3kgQ2VudGVyCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCkludGVsLWdmeCBtYWlsaW5nIGxpc3QKSW50ZWwtZ2Z4
QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2ludGVsLWdmeAo=
