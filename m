From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re:
 =?utf-8?q?=E2=9C=97_Fi=2ECI=2EBAT=3A_failure_for_drm/?=
 =?utf-8?q?i915/bxt=3A_Fix_off-by-one_error_in_Broxton_PLL_IDs_=28rev3=29?=
Date: Wed, 16 Mar 2016 16:37:06 +0100
Message-ID: <20160316153706.GT14170@phenom.ffwll.local>
References: <1457977942-11772-1-git-send-email-imre.deak@intel.com>
 <20160316073153.17251.51881@emeril.freedesktop.org>
 <1458118123.27377.11.camel@intel.com> <6454956.W1mfK3ePPj@fractal>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <6454956.W1mfK3ePPj@fractal>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: intel-gfx-bounces@lists.freedesktop.org
Sender: "Intel-gfx" <intel-gfx-bounces@lists.freedesktop.org>
To: Tomi Sarvela <tomi.p.sarvela@intel.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, intel-gfx@lists.freedesktop.org, Libin Yang <libin.yang@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

T24gV2VkLCBNYXIgMTYsIDIwMTYgYXQgMDI6Mzc6MjRQTSArMDIwMCwgVG9taSBTYXJ2ZWxhIHdy
b3RlOgo+IE9uIFdlZG5lc2RheSAxNiBNYXJjaCAyMDE2IDEwOjQ4OjQzIEltcmUgRGVhayB3cm90
ZToKPiA+IFRvbWksIG5vdGljZWQgdHdvIHRoaW5ncyB0aGF0IG1heWJlIGluZnJhc3RydWN0dXJl
IHJlbGF0ZWQsIHNlZSBiZWxvdzoKPiA+IAo+ID4gPiBUZXN0IGRydl9tb2R1bGVfcmVsb2FkX2Jh
c2ljOgo+ID4gPiAgICAgICAgICAgICAgICAgc2tpcCAgICAgICAtPiBQQVNTICAgICAgIChiZHct
bnVjaTcpCj4gPiA+IFRlc3QgZ2VtX3JpbmdmaWxsOgo+ID4gPiAgICAgICAgIFN1Ymdyb3VwIGJh
c2ljLWRlZmF1bHQtczM6Cj4gPiA+ICAgICAgICAgICAgICAgICBwYXNzICAgICAgIC0+IERNRVNH
LVdBUk4gKHNrbC1udWNpNSkKPiA+ID4gVGVzdCBnZW1fc3RvcmVkd19sb29wOgo+ID4gPiAgICAg
ICAgIFN1Ymdyb3VwIGJhc2ljLWJzZDoKPiA+ID4gICAgICAgICAgICAgICAgIHBhc3MgICAgICAg
LT4gRE1FU0ctV0FSTiAoc2tsLW51Y2k1KQo+ID4gPiAgICAgICAgIFN1Ymdyb3VwIGJhc2ljLWJz
ZDE6Cj4gPiA+ICAgICAgICAgICAgICAgICBwYXNzICAgICAgIC0+IERNRVNHLVdBUk4gKHNrbC1u
dWNpNSkKPiA+IAo+ID4gVW5yZWxhdGVkIHBsYXRmb3JtLiBBbGwgb2YgdGhlIGFib3ZlIGFyZSBT
TkQgcmVzdW1lIGZhaWx1cmVzLiBWaWxsZQo+ID4gc2FpZCBoZSBjb250YWN0ZWQgVGFrYXNoaSBh
Ym91dCB0aGVtLgo+IAo+IFNORCBpcyByZWN1cnJpbmcgcHJvYmxlbS4gSSdkIGxpa2UgdG8gc2Vl
IGRybS1pbnRlbC1uaWdodGx5IG5vdCBicmVha2luZyB3aGVuIAo+IHB1bGxpbmcgc291bmQgdXBk
YXRlcy4KCldlIG5lZWQgdG8gZXNjYWxhdGUgdGhpcyBhZ2Fpbiwgc25kIHRlYW0gc2VyaW91c2x5
IHN1Y2tzIGF0IHF1YWxpdHkKY29udHJvbCA6KCBBZGRpbmcgTGliaW4mVGFrYXNoaS4gSWYgdGhp
cyBkb2Vzbid0IGltcHJvdmUgSSBuZWVkIHRvIHRocm93CnNvdW5kIHRyZWVzIG91dCBvZiAtbmln
aHRseSBmb3IgcmVhbC4KLURhbmllbAotLSAKRGFuaWVsIFZldHRlcgpTb2Z0d2FyZSBFbmdpbmVl
ciwgSW50ZWwgQ29ycG9yYXRpb24KaHR0cDovL2Jsb2cuZmZ3bGwuY2gKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KSW50ZWwtZ2Z4IG1haWxpbmcgbGlzdApJ
bnRlbC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Au
b3JnL21haWxtYW4vbGlzdGluZm8vaW50ZWwtZ2Z4Cg==
