From: Chris Wilson <chris@chris-wilson.co.uk>
Subject: Re: [PATCH 1/2] ALSA: x86: Fix runtime PM for
 hdmi-lpe-audio
Date: Wed, 24 Oct 2018 16:52:22 +0100
Message-ID: <154039634272.5632.2532479909216282819@skylake-alporthouse-com>
References: <20181024154825.18185-1-ville.syrjala@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
In-Reply-To: <20181024154825.18185-1-ville.syrjala@linux.intel.com>
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

UXVvdGluZyBWaWxsZSBTeXJqYWxhICgyMDE4LTEwLTI0IDE2OjQ4OjI0KQo+IEZyb206IFZpbGxl
IFN5cmrDpGzDpCA8dmlsbGUuc3lyamFsYUBsaW51eC5pbnRlbC5jb20+Cj4gCj4gQ29tbWl0IDQ2
ZTgzMWFiZTg2NCAoImRybS9pOTE1L2xwZTogTWFyayBMUEUgYXVkaW8gcnVudGltZSBwbSBhcwo+
ICJubyBjYWxsYmFja3MiIikgYnJva2UgcnVudGltZSBQTSB3aXRoIGxwZSBhdWRpby4gV2UgY2Fu
IG5vIGxvbmdlcgo+IHJ1bnRpbWUgc3VzcGVuZCB0aGUgR1BVIHNpbmNlIHRoZSBzeXNmcyAgcG93
ZXIvY29udHJvbCBmb3IgdGhlCj4gbHBlLWF1ZGlvIGRldmljZSBubyBsb25nZXIgZXhpc3RzIGFu
ZCB0aGUgZGV2aWNlIGlzIGNvbnNpZGVyZWQKPiBhbHdheXMgYWN0aXZlLiBXZSBjYW4gZml4IHRo
aXMgYnkgbm90IG1hcmtpbmcgdGhlIGRldmljZSBhcwo+IGFjdGl2ZS4KCkRvIHlvdSBhbHNvIHdh
bnQgdG8gc2VuZCB3aXRoIGEgSEFYIHBhdGNoIHRvIGZvcmNlIHNlbGVjdGlvbiBvZiBTTkRfWDg2
CmZvciBDST8KLUNocmlzCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCkludGVsLWdmeCBtYWlsaW5nIGxpc3QKSW50ZWwtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2ludGVs
LWdmeAo=
