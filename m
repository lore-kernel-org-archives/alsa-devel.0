From: libin.yang@intel.com
Subject: [PATCH v4 1/4] drm/i915: Add audio sync_audio_rate
	callback
Date: Tue, 18 Aug 2015 14:35:26 +0800
Message-ID: <1439879729-27885-1-git-send-email-libin.yang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: intel-gfx-bounces@lists.freedesktop.org
Sender: "Intel-gfx" <intel-gfx-bounces@lists.freedesktop.org>
To: alsa-devel@alsa-project.org, tiwai@suse.de, intel-gfx@lists.freedesktop.org, daniel.vetter@ffwll.ch, jani.nikula@linux.intel.com
List-Id: alsa-devel@alsa-project.org

RnJvbTogTGliaW4gWWFuZyA8bGliaW4ueWFuZ0BpbnRlbC5jb20+CgpBZGQgdGhlIHN5bmNfYXVk
aW9fcmF0ZSBjYWxsYmFjay4KCldpdGggdGhlIGNhbGxiYWNrLCBhdWRpbyBkcml2ZXIgY2FuIHRy
aWdnZXIKaTkxNSBkcml2ZXIgdG8gc2V0IHRoZSBwcm9wZXIgTi9DVFMgb3IgTi9NCmJhc2VkIG9u
IGRpZmZlcmVudCBzYW1wbGUgcmF0ZXMuCgpTaWduZWQtb2ZmLWJ5OiBMaWJpbiBZYW5nIDxsaWJp
bi55YW5nQGludGVsLmNvbT4KLS0tCiBpbmNsdWRlL2RybS9pOTE1X2NvbXBvbmVudC5oIHwgMSAr
CiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykKCmRpZmYgLS1naXQgYS9pbmNsdWRlL2Ry
bS9pOTE1X2NvbXBvbmVudC5oIGIvaW5jbHVkZS9kcm0vaTkxNV9jb21wb25lbnQuaAppbmRleCBj
OWE4YjY0Li5hYWJlYmNiIDEwMDY0NAotLS0gYS9pbmNsdWRlL2RybS9pOTE1X2NvbXBvbmVudC5o
CisrKyBiL2luY2x1ZGUvZHJtL2k5MTVfY29tcG9uZW50LmgKQEAgLTMzLDYgKzMzLDcgQEAgc3Ry
dWN0IGk5MTVfYXVkaW9fY29tcG9uZW50IHsKIAkJdm9pZCAoKnB1dF9wb3dlcikoc3RydWN0IGRl
dmljZSAqKTsKIAkJdm9pZCAoKmNvZGVjX3dha2Vfb3ZlcnJpZGUpKHN0cnVjdCBkZXZpY2UgKiwg
Ym9vbCBlbmFibGUpOwogCQlpbnQgKCpnZXRfY2RjbGtfZnJlcSkoc3RydWN0IGRldmljZSAqKTsK
KwkJaW50ICgqc3luY19hdWRpb19yYXRlKShzdHJ1Y3QgZGV2aWNlICosIGludCBwb3J0LCBpbnQg
cmF0ZSk7CiAJfSAqb3BzOwogfTsKIAotLSAKMS45LjEKCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCkludGVsLWdmeCBtYWlsaW5nIGxpc3QKSW50ZWwtZ2Z4
QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxt
YW4vbGlzdGluZm8vaW50ZWwtZ2Z4Cg==
