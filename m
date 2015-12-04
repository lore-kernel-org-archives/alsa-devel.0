From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH v2 2/9] drm/i915: Add get_eld audio component
Date: Fri, 4 Dec 2015 17:15:59 +0100
Message-ID: <20151204161559.GF10243@phenom.ffwll.local>
References: <1448986198-3488-1-git-send-email-tiwai@suse.de>
 <1448986198-3488-3-git-send-email-tiwai@suse.de>
 <20151204102102.GM10243@phenom.ffwll.local>
 <s5hsi3i32ut.wl-tiwai@suse.de>
 <20151204150046.GR10243@phenom.ffwll.local>
 <s5hd1umz1mb.wl-tiwai@suse.de>
 <20151204155432.GB10243@phenom.ffwll.local>
 <s5h37viyzdg.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <s5h37viyzdg.wl-tiwai@suse.de>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: intel-gfx-bounces@lists.freedesktop.org
Sender: "Intel-gfx" <intel-gfx-bounces@lists.freedesktop.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mengdong Lin <mengdong.lin@linux.intel.com>, Vinod Koul <vinod.koul@intel.com>, intel-gfx@lists.freedesktop.org, Daniel Vetter <daniel.vetter@intel.com>, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

T24gRnJpLCBEZWMgMDQsIDIwMTUgYXQgMDU6MDM6NTVQTSArMDEwMCwgVGFrYXNoaSBJd2FpIHdy
b3RlOgo+IE9uIEZyaSwgMDQgRGVjIDIwMTUgMTY6NTQ6MzIgKzAxMDAsCj4gRGFuaWVsIFZldHRl
ciB3cm90ZToKPiA+IAo+ID4gT24gRnJpLCBEZWMgMDQsIDIwMTUgYXQgMDQ6MTU6MjRQTSArMDEw
MCwgVGFrYXNoaSBJd2FpIHdyb3RlOgo+ID4gPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9kcm0vaTkx
NV9jb21wb25lbnQuaCBiL2luY2x1ZGUvZHJtL2k5MTVfY29tcG9uZW50LmgKPiA+ID4gaW5kZXgg
MzBkODllMGRhMmM2Li4wNThkMzllOGQ1N2YgMTAwNjQ0Cj4gPiA+IC0tLSBhL2luY2x1ZGUvZHJt
L2k5MTVfY29tcG9uZW50LmgKPiA+ID4gKysrIGIvaW5jbHVkZS9kcm0vaTkxNV9jb21wb25lbnQu
aAo+ID4gPiBAQCAtMzgsNiArMzgsNyBAQAo+ID4gPiAgICogQGNvZGVjX3dha2Vfb3ZlcnJpZGU6
IEVuYWJsZS9EaXNhYmxlIGdlbmVyYXRpbmcgdGhlIGNvZGVjIHdha2Ugc2lnbmFsCj4gPiA+ICAg
KiBAZ2V0X2NkY2xrX2ZyZXE6IGdldCB0aGUgQ29yZSBEaXNwbGF5IENsb2NrIGluIEtIego+ID4g
PiAgICogQHN5bmNfYXVkaW9fcmF0ZTogc2V0IG4vY3RzIGJhc2VkIG9uIHRoZSBzYW1wbGUgcmF0
ZQo+ID4gPiArICogQGdldF9lbGQ6IGZpbGwgdGhlIGF1ZGlvIHN0YXRlIGFuZCBFTEQgYnl0ZXMg
Zm9yIHRoZSBnaXZlbiBwb3J0Cj4gPiAKPiA+IE9uZSBtb3JlOiBZb3Ugc2VlbSB0byBzdGlsbCBi
ZSBvbiBhbiBvbGQgYmFzZWxpbmUsIHdpdGggc3dpdGNoZWQgdG8gdGhlCj4gPiBuZXcgaW4tbGlu
ZSBjb21tZW50IGxheW91dC4gVGhhdCBhbGxvd3MgeW91IHRvIHNwZWMgdGhlIGNhbGxiYWNrIHNl
bWFudGljcwo+ID4gaW4gbXVjaCBtb3JlIGRldGFpbCBzaW5jZSBpdCBhbGxvd3MgcmVhbCBwYXJh
Z3JhcGhzLgo+IAo+IFllcywgSSd2ZSBiZWVuIHdhaXRpbmcgZm9yIHlvdXIgKG9yIERhdmUncykg
YW5zd2VyIHRvIG15IHByZXZpb3VzCj4gcXVlc3Rpb246IHdoaWNoIGJyYW5jaCBjYW4gSSB1c2Ug
YXMgYSBzb2xpZCBiYXNlPwoKT29vcHMgc29ycnkuIGRybS1uZXh0IGlzIG5vdyBvcGVuIGFuZCBo
YXMgZXZlcnl0aGluZyB5b3UgbmVlZC4KCmdpdDovL3Blb3BsZS5mcmVlZGVza3RvcC5vcmcvfmFp
cmxpZWQvbGludXggZHJtLW5leHQKCkNoZWVycywgRGFuaWVsCi0tIApEYW5pZWwgVmV0dGVyClNv
ZnR3YXJlIEVuZ2luZWVyLCBJbnRlbCBDb3Jwb3JhdGlvbgpodHRwOi8vYmxvZy5mZndsbC5jaApf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpJbnRlbC1nZngg
bWFpbGluZyBsaXN0CkludGVsLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cDovL2xpc3Rz
LmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2ludGVsLWdmeAo=
