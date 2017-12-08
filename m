From: "Chen, Augustine" <augustine.chen@intel.com>
Subject: [PATCH] drm/i915: Remove unused IRQ chip data of HDMI
	LPE audio
Date: Fri, 8 Dec 2017 08:34:16 +0000
Message-ID: <9A1A7991592FAD49BCF9F28D9CF9FE3121AB6F61@PGSMSX105.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="_002_9A1A7991592FAD49BCF9F28D9CF9FE3121AB6F61PGSMSX105garcor_"
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: intel-gfx-bounces@lists.freedesktop.org
Sender: "Intel-gfx" <intel-gfx-bounces@lists.freedesktop.org>
To: "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Anand, Jerome" <jerome.anand@intel.com>, "Bossart, Pierre-louis" <pierre-louis.bossart@intel.com>, "tiwai@suse.de" <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

--_002_9A1A7991592FAD49BCF9F28D9CF9FE3121AB6F61PGSMSX105garcor_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Dear Sirs,
Please kindly help reviewing this patch for the Bugzilla below.
https://bugs.freedesktop.org/show_bug.cgi?id=3D103731

Thanks.

Best regards,
Augustine



--_002_9A1A7991592FAD49BCF9F28D9CF9FE3121AB6F61PGSMSX105garcor_
Content-Type: application/octet-stream;
	name="0001-drm-i915-Remove-unused-IRQ-chip-data-of-HDMI-LPE-aud.patch"
Content-Description: 0001-drm-i915-Remove-unused-IRQ-chip-data-of-HDMI-LPE-aud.patch
Content-Disposition: attachment;
	filename="0001-drm-i915-Remove-unused-IRQ-chip-data-of-HDMI-LPE-aud.patch";
	size=1564; creation-date="Fri, 08 Dec 2017 07:36:20 GMT";
	modification-date="Fri, 08 Dec 2017 08:19:53 GMT"
Content-Transfer-Encoding: base64

RnJvbSBlYTEzMTEyMWJkZWI4ZTBmNTBhNjkzMzhlOTMyMGZlMjdhNTM1ZjNmIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiAiQXVndXN0aW5lLkNoZW4iIDxhdWd1c3RpbmUuY2hlbkBpbnRl
bC5jb20+CkRhdGU6IEZyaSwgOCBEZWMgMjAxNyAxNTowNjo0MSArMDgwMApTdWJqZWN0OiBbUEFU
Q0hdIGRybS9pOTE1OiBSZW1vdmUgdW51c2VkIElSUSBjaGlwIGRhdGEgb2YgSERNSSBMUEUgYXVk
aW8KClRoZSBjaGlwIGRhdGEgb2YgSERNSSBMUEUgYXVkaW8gaXMgc2V0IHRvIGRybV9pOTE1X3By
aXZhdGUgd2hpY2ggaXMgbm90CmNvbnNpc3RlbnQgd2l0aCB0aGUgZXhwZWN0YXRpb24gYnkgeDg2
IEFQSUMgZHJpdmVyLiBJbiB0aGUgY2FzZSBvZiBub3QKZW5hYmxpbmcgQ09ORklHX0NQVU1BU0tf
T0ZGU1RBQ0ssIHRoaXMgd291bGQgY2F1c2Uga2VybmVsIHBhbmljIHdoaWxlIGRvaW5nCkNQVSBo
b3RwbHVnLiBTaW5jZSB0aGUgZGVwZW5kZW5jeSBvZiBJUlEgY2hpcCBkYXRhIHdhcyByZW1vdmVk
IGZyb20gSERNSQpMUEUgYXVkaW8gYnkgQ29tbWl0IDliZDk1OTA5OTdiOTJmYmQ3OWZkMDI4Zjcw
NGY2YzU4NGI0NDM5ZDcgKCJkcm0vaTkxNToKU3RvcCBwcmV0ZW5kaW5nIHRvIG1hc2svdW5tYXNr
IExQRSBhdWRpbyBpbnRlcnJ1cHRzIiksIHJlbW92ZSB0aGUKY29kZSBvZiBzZXR0aW5nIElSUSBj
aGlwIGRhdGEgdG8gcmVzb2x2ZSB0aGlzIGlzc3VlLgoKQnVnemlsbGE6IGh0dHBzOi8vYnVncy5m
cmVlZGVza3RvcC5vcmcvc2hvd19idWcuY2dpP2lkPTEwMzczMQpDYzogUGllcnJlLUxvdWlzIEJv
c3NhcnQgPHBpZXJyZS1sb3Vpcy5ib3NzYXJ0QGludGVsLmNvbT4KQ2M6IEplcm9tZSBBbmFuZCA8
amVyb21lLmFuYW5kQGludGVsLmNvbT4KQ2M6IFRha2FzaGkgSXdhaSA8dGl3YWlAc3VzZS5kZT4K
U2lnbmVkLW9mZi1ieTogQXVndXN0aW5lLkNoZW4gPGF1Z3VzdGluZS5jaGVuQGludGVsLmNvbT4K
LS0tCiBkcml2ZXJzL2dwdS9kcm0vaTkxNS9pbnRlbF9scGVfYXVkaW8uYyB8IDIgKy0KIDEgZmls
ZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvZ3B1L2RybS9pOTE1L2ludGVsX2xwZV9hdWRpby5jIGIvZHJpdmVycy9ncHUvZHJtL2k5
MTUvaW50ZWxfbHBlX2F1ZGlvLmMKaW5kZXggM2JmNjUyOC4uNTYxNzZmOSAxMDA2NDQKLS0tIGEv
ZHJpdmVycy9ncHUvZHJtL2k5MTUvaW50ZWxfbHBlX2F1ZGlvLmMKKysrIGIvZHJpdmVycy9ncHUv
ZHJtL2k5MTUvaW50ZWxfbHBlX2F1ZGlvLmMKQEAgLTE3Niw3ICsxNzYsNyBAQCBzdGF0aWMgaW50
IGxwZV9hdWRpb19pcnFfaW5pdChzdHJ1Y3QgZHJtX2k5MTVfcHJpdmF0ZSAqZGV2X3ByaXYpCiAJ
CQkJaGFuZGxlX3NpbXBsZV9pcnEsCiAJCQkJImhkbWlfbHBlX2F1ZGlvX2lycV9oYW5kbGVyIik7
CiAKLQlyZXR1cm4gaXJxX3NldF9jaGlwX2RhdGEoaXJxLCBkZXZfcHJpdik7CisJcmV0dXJuIDA7
CiB9CiAKIHN0YXRpYyBib29sIGxwZV9hdWRpb19kZXRlY3Qoc3RydWN0IGRybV9pOTE1X3ByaXZh
dGUgKmRldl9wcml2KQotLSAKMS45LjEKCg==

--_002_9A1A7991592FAD49BCF9F28D9CF9FE3121AB6F61PGSMSX105garcor_
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KSW50ZWwtZ2Z4
IG1haWxpbmcgbGlzdApJbnRlbC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vaW50ZWwtZ2Z4Cg==

--_002_9A1A7991592FAD49BCF9F28D9CF9FE3121AB6F61PGSMSX105garcor_--
