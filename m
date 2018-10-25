From: Chris Wilson <chris@chris-wilson.co.uk>
Subject: Re: [PATCH 2/2] ALSA: x86: Rip out the lpe audio
 runtime suspend/resume hooks
Date: Thu, 25 Oct 2018 07:53:05 +0100
Message-ID: <154045038585.5632.7716882929392437772@skylake-alporthouse-com>
References: <20181024154825.18185-1-ville.syrjala@linux.intel.com>
 <20181024154825.18185-2-ville.syrjala@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
In-Reply-To: <20181024154825.18185-2-ville.syrjala@linux.intel.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: intel-gfx-bounces@lists.freedesktop.org
Sender: "Intel-gfx" <intel-gfx-bounces@lists.freedesktop.org>
To: Ville Syrjala <ville.syrjala@linux.intel.com>, alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>, intel-gfx@lists.freedesktop.org
List-Id: alsa-devel@alsa-project.org

UXVvdGluZyBWaWxsZSBTeXJqYWxhICgyMDE4LTEwLTI0IDE2OjQ4OjI1KQo+IEZyb206IFZpbGxl
IFN5cmrDpGzDpCA8dmlsbGUuc3lyamFsYUBsaW51eC5pbnRlbC5jb20+Cj4gCj4gRXZlciBzaW5j
ZSBjb21taXQgNDZlODMxYWJlODY0ICgiZHJtL2k5MTUvbHBlOiBNYXJrIExQRSBhdWRpbyBydW50
aW1lCj4gcG0gYXMgIm5vIGNhbGxiYWNrcyIiKSB0aGUgcnVudGltZSBzdXNwZW5kL3Jlc3VtZSBo
b29rcyBhcmUgbm8gbG9uZ2VyCj4gdXNlZC4gSW5saW5lIHRoZW0gaW50byB0aGUgc3lzdGVtIHN1
c3BlbmQgaG9va3MuCj4gCj4gQ2M6IENocmlzIFdpbHNvbiA8Y2hyaXNAY2hyaXMtd2lsc29uLmNv
LnVrPgo+IENjOiBUYWthc2hpIEl3YWkgPHRpd2FpQHN1c2UuZGU+Cj4gQ2M6IFBpZXJyZS1Mb3Vp
cyBCb3NzYXJ0IDxwaWVycmUtbG91aXMuYm9zc2FydEBsaW51eC5pbnRlbC5jb20+Cj4gU2lnbmVk
LW9mZi1ieTogVmlsbGUgU3lyasOkbMOkIDx2aWxsZS5zeXJqYWxhQGxpbnV4LmludGVsLmNvbT4K
CkFsbCB0YWxsaWVzIHVwLCBhbmQgcnBtIGNvbnRpbnVlcyB0byBmdW5jdGlvbiBhcyBkZXNpcmVk
LgpSZXZpZXdlZC1ieTogQ2hyaXMgV2lsc29uIDxjaHJpc0BjaHJpcy13aWxzb24uY28udWs+Ci1D
aHJpcwpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpJbnRl
bC1nZnggbWFpbGluZyBsaXN0CkludGVsLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6
Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9pbnRlbC1nZngK
