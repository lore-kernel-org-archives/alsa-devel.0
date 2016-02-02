From: =?UTF-8?q?Andreas=20Irest=C3=A5l?= <andreas.irestal@axis.com>
Subject: [PATCH 2/4] ASoc: adau17x1: Correct typos in file
	headers
Date: Tue,  2 Feb 2016 15:31:48 +0100
Message-ID: <1454423510-1330-3-git-send-email-andire@axis.com>
References: <1454423510-1330-1-git-send-email-andire@axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bes.se.axis.com (bes.se.axis.com [195.60.68.10])
 by alsa0.perex.cz (Postfix) with ESMTP id 1F735265104
 for <alsa-devel@alsa-project.org>; Tue,  2 Feb 2016 15:32:28 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by bes.se.axis.com (Postfix) with ESMTP id BB3952E173
 for <alsa-devel@alsa-project.org>; Tue,  2 Feb 2016 15:32:27 +0100 (CET)
Received: from bes.se.axis.com ([IPv6:::ffff:127.0.0.1])
 by localhost (bes.se.axis.com [::ffff:127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id Z4ae81uCEUxu for <alsa-devel@alsa-project.org>;
 Tue,  2 Feb 2016 15:32:27 +0100 (CET)
Received: from boulder.se.axis.com (boulder.se.axis.com [10.0.2.104])
 by bes.se.axis.com (Postfix) with ESMTP id 5293E2E34B
 for <alsa-devel@alsa-project.org>; Tue,  2 Feb 2016 15:32:27 +0100 (CET)
Received: from boulder.se.axis.com (localhost [127.0.0.1])
 by postfix.imss71 (Postfix) with ESMTP id 27500167D
 for <alsa-devel@alsa-project.org>; Tue,  2 Feb 2016 15:32:27 +0100 (CET)
Received: from seth.se.axis.com (seth.se.axis.com [10.0.2.172])
 by boulder.se.axis.com (Postfix) with ESMTP id 1C03615E6
 for <alsa-devel@alsa-project.org>; Tue,  2 Feb 2016 15:32:27 +0100 (CET)
In-Reply-To: <1454423510-1330-1-git-send-email-andire@axis.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: =?UTF-8?q?Andreas=20Irest=C3=A5l?= <andire@axis.com>
List-Id: alsa-devel@alsa-project.org

U2lnbmVkLW9mZi1ieTogQW5kcmVhcyBJcmVzdMOlbCA8YW5kaXJlQGF4aXMuY29tPgotLS0KIGlu
Y2x1ZGUvbGludXgvcGxhdGZvcm1fZGF0YS9hZGF1MTd4MS5oIHwgMiArLQogc291bmQvc29jL2Nv
ZGVjcy9hZGF1MTc2MS1pMmMuYyAgICAgICAgfCAyICstCiBzb3VuZC9zb2MvY29kZWNzL2FkYXUx
NzYxLXNwaS5jICAgICAgICB8IDIgKy0KIHNvdW5kL3NvYy9jb2RlY3MvYWRhdTE3NjEuYyAgICAg
ICAgICAgIHwgMiArLQogc291bmQvc29jL2NvZGVjcy9hZGF1MTc4MS5jICAgICAgICAgICAgfCAy
ICstCiA1IGZpbGVzIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkKCmRp
ZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L3BsYXRmb3JtX2RhdGEvYWRhdTE3eDEuaCBiL2luY2x1
ZGUvbGludXgvcGxhdGZvcm1fZGF0YS9hZGF1MTd4MS5oCmluZGV4IGE4MTc2NmMuLjlkYjFiOTAg
MTAwNjQ0Ci0tLSBhL2luY2x1ZGUvbGludXgvcGxhdGZvcm1fZGF0YS9hZGF1MTd4MS5oCisrKyBi
L2luY2x1ZGUvbGludXgvcGxhdGZvcm1fZGF0YS9hZGF1MTd4MS5oCkBAIC0xLDUgKzEsNSBAQAog
LyoKLSAqIERyaXZlciBmb3IgQURBVTE3NjEvQURBVTE0NjEvQURBVTE3NjEvQURBVTE5NjEvQURB
VTE3ODEvQURBVTE3ODEgY29kZWNzCisgKiBEcml2ZXIgZm9yIEFEQVUxMzYxL0FEQVUxNDYxL0FE
QVUxNzYxL0FEQVUxOTYxL0FEQVUxMzgxL0FEQVUxNzgxIGNvZGVjcwogICoKICAqIENvcHlyaWdo
dCAyMDExLTIwMTQgQW5hbG9nIERldmljZXMgSW5jLgogICogQXV0aG9yOiBMYXJzLVBldGVyIENs
YXVzZW4gPGxhcnNAbWV0YWZvby5kZT4KZGlmZiAtLWdpdCBhL3NvdW5kL3NvYy9jb2RlY3MvYWRh
dTE3NjEtaTJjLmMgYi9zb3VuZC9zb2MvY29kZWNzL2FkYXUxNzYxLWkyYy5jCmluZGV4IDM0OGNj
YjEuLmExYjEyNjcgMTAwNjQ0Ci0tLSBhL3NvdW5kL3NvYy9jb2RlY3MvYWRhdTE3NjEtaTJjLmMK
KysrIGIvc291bmQvc29jL2NvZGVjcy9hZGF1MTc2MS1pMmMuYwpAQCAtMSw1ICsxLDUgQEAKIC8q
Ci0gKiBEcml2ZXIgZm9yIEFEQVUxNzYxL0FEQVUxNDYxL0FEQVUxNzYxL0FEQVUxOTYxIGNvZGVj
CisgKiBEcml2ZXIgZm9yIEFEQVUxMzYxL0FEQVUxNDYxL0FEQVUxNzYxL0FEQVUxOTYxIGNvZGVj
CiAgKgogICogQ29weXJpZ2h0IDIwMTQgQW5hbG9nIERldmljZXMgSW5jLgogICogIEF1dGhvcjog
TGFycy1QZXRlciBDbGF1c2VuIDxsYXJzQG1ldGFmb28uZGU+CmRpZmYgLS1naXQgYS9zb3VuZC9z
b2MvY29kZWNzL2FkYXUxNzYxLXNwaS5jIGIvc291bmQvc29jL2NvZGVjcy9hZGF1MTc2MS1zcGku
YwppbmRleCA4YmMxZmJkLi4xODgzMzQ5IDEwMDY0NAotLS0gYS9zb3VuZC9zb2MvY29kZWNzL2Fk
YXUxNzYxLXNwaS5jCisrKyBiL3NvdW5kL3NvYy9jb2RlY3MvYWRhdTE3NjEtc3BpLmMKQEAgLTEs
NSArMSw1IEBACiAvKgotICogRHJpdmVyIGZvciBBREFVMTc2MS9BREFVMTQ2MS9BREFVMTc2MS9B
REFVMTk2MSBjb2RlYworICogRHJpdmVyIGZvciBBREFVMTM2MS9BREFVMTQ2MS9BREFVMTc2MS9B
REFVMTk2MSBjb2RlYwogICoKICAqIENvcHlyaWdodCAyMDE0IEFuYWxvZyBEZXZpY2VzIEluYy4K
ICAqICBBdXRob3I6IExhcnMtUGV0ZXIgQ2xhdXNlbiA8bGFyc0BtZXRhZm9vLmRlPgpkaWZmIC0t
Z2l0IGEvc291bmQvc29jL2NvZGVjcy9hZGF1MTc2MS5jIGIvc291bmQvc29jL2NvZGVjcy9hZGF1
MTc2MS5jCmluZGV4IDJmMTI0NzcuLjE2ZmVkMzYgMTAwNjQ0Ci0tLSBhL3NvdW5kL3NvYy9jb2Rl
Y3MvYWRhdTE3NjEuYworKysgYi9zb3VuZC9zb2MvY29kZWNzL2FkYXUxNzYxLmMKQEAgLTEsNSAr
MSw1IEBACiAvKgotICogRHJpdmVyIGZvciBBREFVMTc2MS9BREFVMTQ2MS9BREFVMTc2MS9BREFV
MTk2MSBjb2RlYworICogRHJpdmVyIGZvciBBREFVMTM2MS9BREFVMTQ2MS9BREFVMTc2MS9BREFV
MTk2MSBjb2RlYwogICoKICAqIENvcHlyaWdodCAyMDExLTIwMTMgQW5hbG9nIERldmljZXMgSW5j
LgogICogQXV0aG9yOiBMYXJzLVBldGVyIENsYXVzZW4gPGxhcnNAbWV0YWZvby5kZT4KZGlmZiAt
LWdpdCBhL3NvdW5kL3NvYy9jb2RlY3MvYWRhdTE3ODEuYyBiL3NvdW5kL3NvYy9jb2RlY3MvYWRh
dTE3ODEuYwppbmRleCBmZGU5MDY4Li5iYzFiYjU2IDEwMDY0NAotLS0gYS9zb3VuZC9zb2MvY29k
ZWNzL2FkYXUxNzgxLmMKKysrIGIvc291bmQvc29jL2NvZGVjcy9hZGF1MTc4MS5jCkBAIC0xLDUg
KzEsNSBAQAogLyoKLSAqIERyaXZlciBmb3IgQURBVTE3ODEvQURBVTE3ODEgY29kZWMKKyAqIERy
aXZlciBmb3IgQURBVTEzODEvQURBVTE3ODEgY29kZWMKICAqCiAgKiBDb3B5cmlnaHQgMjAxMS0y
MDEzIEFuYWxvZyBEZXZpY2VzIEluYy4KICAqIEF1dGhvcjogTGFycy1QZXRlciBDbGF1c2VuIDxs
YXJzQG1ldGFmb28uZGU+Ci0tIAoyLjEuNAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KQWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNh
LXByb2plY3Qub3JnCmh0dHA6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0
aW5mby9hbHNhLWRldmVsCg==
