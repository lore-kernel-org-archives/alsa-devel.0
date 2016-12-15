From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [alsa-devel] [PATCH 1/7] drm/i915: setup bridge for
 HDMI LPE audio driver
Date: Thu, 15 Dec 2016 13:04:21 -0600
Message-ID: <73eef0cf-b9c2-7baf-046e-3dbb66c19895@linux.intel.com>
References: <20161212181043.12512-1-jerome.anand@intel.com>
 <20161212181043.12512-2-jerome.anand@intel.com>
 <20161214125227.iasl2ff4ud6cdize@phenom.ffwll.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
In-Reply-To: <20161214125227.iasl2ff4ud6cdize@phenom.ffwll.local>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: intel-gfx-bounces@lists.freedesktop.org
Sender: "Intel-gfx" <intel-gfx-bounces@lists.freedesktop.org>
To: Daniel Vetter <daniel@ffwll.ch>, Jerome Anand <jerome.anand@intel.com>
Cc: tiwai@suse.de, intel-gfx@lists.freedesktop.org, broonie@kernel.org, rakesh.a.ughreja@intel.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

CiA+Pj4gK3N0YXRpYyB2b2lkIGxwZV9hdWRpb19pcnFfdW5tYXNrKHN0cnVjdCBpcnFfZGF0YSAq
ZCkgewogPj4+ICsJc3RydWN0IGRybV9pOTE1X3ByaXZhdGUgKmRldl9wcml2ID0gZC0+Y2hpcF9k
YXRhOwogPj4+ICsJdW5zaWduZWQgbG9uZyBpcnFmbGFnczsKID4+PiArCXUzMiB2YWwgPSAoSTkx
NV9MUEVfUElQRV9BX0lOVEVSUlVQVCB8CiA+Pj4gKwkJSTkxNV9MUEVfUElQRV9CX0lOVEVSUlVQ
VCk7CiA+PgogPj4gUElQRV9DIG1pc3Npbmc/CiA+PgogPgogPiBObyBQSVBFX0Mgb24gdmx2CgpH
b29kIGNhdGNoIERhbmllbC4KV2UgaW5pdGlhbGx5IGhhZCBQSVBFX0MgZXZlcnlod2VyZSwgdGhp
bmtpbmcgdGhhdCBpdCdzIGhhcm1sZXNzIG9uIApCYXl0cmFpbC4gVmlsbGUgaGFkIGEgY29tbWVu
dCB0aGF0IHRoZXJlIHdhcyBubyBQSVBFX0Mgb24gQllUIHNvIHdlIApyZW1vdmVkIGl0IGZvciBC
YXl0cmFpbC1vbmx5IGNvZGUsIGhlcmUgaXQgbWFrZXMgbm8gc2Vuc2UgdG8gbWUuIHdlIGhhdmUg
CnRoZSBzYW1lIHByb2JsZW0gaW4gbHBlX2F1ZGlvX2lycV9tYXNrCgogPj4gQmVzaWRlcyB0aGUg
ZmV3IGJpa2VzaGVkcyBzZWVtcyBhbGwgcmVhc29uYWJsZSwgd2l0aCB0aG9zZSBhZGRyZXNzZWQK
ID4+CiA+PiBBY2tlZC1ieTogRGFuaWVsIFZldHRlciA8ZGFuaWVsLnZldHRlckBmZndsbC5jaD4K
ID4+CiA+CiA+IFRoYW5rcwogPgogPj4gLi4uIGZvciBtZXJnaW5nIHRocm91Z2ggc291bmQgdHJl
ZS4gU2luY2Ugd2UncmUgc3VwZXIgZWFybHkgaW4gNC4xMSAKYSB0b3BpYwogPj4gYnJhbmNoIGZv
ciBtZSB0byBwdWxsIGluIHRvIGF2b2lkIHN5bmMgaGVhZGFjaGVzIHdvdWxkIGJlIGdvb2QuCgpU
aGFua3MgZm9yIHRoZSByZXZpZXdzIGFuZCBhY2ssIHdlJ2xsIGZpeCB0aGUgY29tbWVudHMgc2hv
cnRseS4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KSW50
ZWwtZ2Z4IG1haWxpbmcgbGlzdApJbnRlbC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBz
Oi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vaW50ZWwtZ2Z4Cg==
