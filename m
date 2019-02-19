From: Li RongQing <lirongqing@baidu.com>
Subject: [PATCH] ALSA: xen-front: remove unneeded switch
 fall-through
Date: Tue, 19 Feb 2019 12:57:28 +0800
Message-ID: <1550552248-17492-1-git-send-email-lirongqing@baidu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <xen-devel-bounces@lists.xenproject.org>
List-Unsubscribe: <https://lists.xenproject.org/mailman/options/xen-devel>,
 <mailto:xen-devel-request@lists.xenproject.org?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xenproject.org>
List-Help: <mailto:xen-devel-request@lists.xenproject.org?subject=help>
List-Subscribe: <https://lists.xenproject.org/mailman/listinfo/xen-devel>,
 <mailto:xen-devel-request@lists.xenproject.org?subject=subscribe>
Errors-To: xen-devel-bounces@lists.xenproject.org
Sender: "Xen-devel" <xen-devel-bounces@lists.xenproject.org>
To: alsa-devel@alsa-project.org, xen-devel@lists.xenproject.org, oleksandr_andrushchenko@epam.com
List-Id: alsa-devel@alsa-project.org

VGhpcyBjYXNlIGJsb2NrIHdpbGwgYmUgdGVybWluYXRlZCBieSBhIGJyZWFrLCBzbyBub3QgbmVl
ZAphIHN3aXRjaCBmYWxsLXRocm91Z2gKClNpZ25lZC1vZmYtYnk6IExpIFJvbmdRaW5nIDxsaXJv
bmdxaW5nQGJhaWR1LmNvbT4KLS0tCiBzb3VuZC94ZW4veGVuX3NuZF9mcm9udC5jIHwgMSAtCiAx
IGZpbGUgY2hhbmdlZCwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL3NvdW5kL3hlbi94ZW5f
c25kX2Zyb250LmMgYi9zb3VuZC94ZW4veGVuX3NuZF9mcm9udC5jCmluZGV4IGE5ZTVjMmNkNzY5
OC4uZjEyZmI4ZWVhYTI3IDEwMDY0NAotLS0gYS9zb3VuZC94ZW4veGVuX3NuZF9mcm9udC5jCisr
KyBiL3NvdW5kL3hlbi94ZW5fc25kX2Zyb250LmMKQEAgLTI1MCw3ICsyNTAsNiBAQCBzdGF0aWMg
dm9pZCBzbmRiYWNrX2NoYW5nZWQoc3RydWN0IHhlbmJ1c19kZXZpY2UgKnhiX2RldiwKIAljYXNl
IFhlbmJ1c1N0YXRlUmVjb25maWd1cmVkOgogCQkvKiBmYWxsIHRocm91Z2ggKi8KIAljYXNlIFhl
bmJ1c1N0YXRlSW5pdGlhbGlzZWQ6Ci0JCS8qIGZhbGwgdGhyb3VnaCAqLwogCQlicmVhazsKIAog
CWNhc2UgWGVuYnVzU3RhdGVJbml0aWFsaXNpbmc6Ci0tIAoyLjE2LjIKCgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpYZW4tZGV2ZWwgbWFpbGluZyBsaXN0
Clhlbi1kZXZlbEBsaXN0cy54ZW5wcm9qZWN0Lm9yZwpodHRwczovL2xpc3RzLnhlbnByb2plY3Qu
b3JnL21haWxtYW4vbGlzdGluZm8veGVuLWRldmVs
