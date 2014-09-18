From: Renu Tyagi <renu.tyagi@samsung.com>
Subject: Re: [PATCH 8/8] coverity fix in alsa-libs
Date: Thu, 18 Sep 2014 11:36:50 +0000 (GMT)
Message-ID: <A0.40.04938.2D3CA145@epcpsbgx1.samsung.com>
Reply-To: renu.tyagi@samsung.com
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="----=SAMSUNG_mySingle_MIME_MULTIPART_BOUNDARY"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 7455E261B14
 for <alsa-devel@alsa-project.org>; Thu, 18 Sep 2014 13:36:52 +0200 (CEST)
Received: from epcpsbgr4.samsung.com
 (u144.gpu120.samsung.co.kr [203.254.230.144])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0NC300N6YHLE2N90@mailout1.samsung.com> for
 alsa-devel@alsa-project.org; Thu, 18 Sep 2014 20:36:50 +0900 (KST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org


------=SAMSUNG_mySingle_MIME_MULTIPART_BOUNDARY
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="windows-1252"
MIME-Version: 1.0
Message-ID: <30264820.99631411040210023.JavaMail.weblogic@epv6ml12>

SGksDQpCdWcgVHlwZSA6IE51bGwgY2hlY2sgYmVmb3JlIGNsb3NpbmcgaA0KRmlsZXMgY2hhbmdl
ZCA6IHBjbV9ob29rcy5jDQpQRkEgcGF0Y2g4DQoNClRoYW5rcw0KUmVudSBUeWFnaQ0KLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLQ0KRnJvbSA5MDZhOGI2NTkxMWVkZmQ5ZDhiZWY0ODQ1MDcwNzY4NWJmNGI4OTgw
IE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQ0KRnJvbTogcmVudSB0eWFnaSA8cmVudS50eWFnaUBz
YW1zdW5nLmNvbT4NCkRhdGU6IFRodSwgMTggU2VwIDIwMTQgMTY6NDU6NTkgKzA1MzANClN1Ympl
Y3Q6IFtQQVRDSCA4LzhdIFtwY21faG9va3NdIDogTnVsbCBjaGVjayBiZWZvcmUgY2xvc2luZyBo
DQoNCg0KU2lnbmVkLW9mZi1ieTogcmVudSB0eWFnaSA8cmVudS50eWFnaUBzYW1zdW5nLmNvbT4N
Ci0tLQ0KIHNyYy9wY20vcGNtX2hvb2tzLmMgfCAgICAzICsrLQ0KIDEgZmlsZXMgY2hhbmdlZCwg
MiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvc3JjL3BjbS9w
Y21faG9va3MuYyBiL3NyYy9wY20vcGNtX2hvb2tzLmMNCmluZGV4IDBiOTNjNjQuLmNlMWNmMzYg
MTAwNjQ0DQotLS0gYS9zcmMvcGNtL3BjbV9ob29rcy5jDQorKysgYi9zcmMvcGNtL3BjbV9ob29r
cy5jDQpAQCAtNDU3LDcgKzQ1Nyw4IEBAIHN0YXRpYyBpbnQgc25kX3BjbV9ob29rX2FkZF9jb25m
KHNuZF9wY21fdCAqcGNtLCBzbmRfY29uZmlnX3QgKnJvb3QsIHNuZF9jb25maWdfDQogICAgICAg
ICAgICAgICAgZXJyID0gaG9va19hZGRfZGxvYmoocGNtLCBoKTsNCg0KICAgICAgICBpZiAoZXJy
IDwgMCkgew0KLSAgICAgICAgICAgICAgIHNuZF9kbGNsb3NlKGgpOw0KKyAgICAgICAgICAgICAg
IGlmKGgpDQorICAgICAgICAgICAgICAgICAgICAgICBzbmRfZGxjbG9zZShoKTsNCiAgICAgICAg
ICAgICAgICByZXR1cm4gZXJyOw0KICAgICAgICB9DQogICAgICAgIHJldHVybiAwOw0KLS0NCjEu
Ny4x


------=SAMSUNG_mySingle_MIME_MULTIPART_BOUNDARY
Content-Type: application/octet-stream;
 name="patch8.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="patch8.patch"


RnJvbSA5MDZhOGI2NTkxMWVkZmQ5ZDhiZWY0ODQ1MDcwNzY4NWJmNGI4OTgwIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiByZW51IHR5YWdpIDxyZW51LnR5YWdpQHNhbXN1bmcu
Y29tPgpEYXRlOiBUaHUsIDE4IFNlcCAyMDE0IDE2OjQ1OjU5ICswNTMwClN1YmplY3Q6IFtQ
QVRDSCA4LzhdIFtwY21faG9va3NdIDogTnVsbCBjaGVjayBiZWZvcmUgY2xvc2luZyBoCgoK
U2lnbmVkLW9mZi1ieTogcmVudSB0eWFnaSA8cmVudS50eWFnaUBzYW1zdW5nLmNvbT4KLS0t
CiBzcmMvcGNtL3BjbV9ob29rcy5jIHwgICAgMyArKy0KIDEgZmlsZXMgY2hhbmdlZCwgMiBp
bnNlcnRpb25zKCspLCAxIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3NyYy9wY20vcGNt
X2hvb2tzLmMgYi9zcmMvcGNtL3BjbV9ob29rcy5jCmluZGV4IDBiOTNjNjQuLmNlMWNmMzYg
MTAwNjQ0Ci0tLSBhL3NyYy9wY20vcGNtX2hvb2tzLmMKKysrIGIvc3JjL3BjbS9wY21faG9v
a3MuYwpAQCAtNDU3LDcgKzQ1Nyw4IEBAIHN0YXRpYyBpbnQgc25kX3BjbV9ob29rX2FkZF9j
b25mKHNuZF9wY21fdCAqcGNtLCBzbmRfY29uZmlnX3QgKnJvb3QsIHNuZF9jb25maWdfCiAJ
CWVyciA9IGhvb2tfYWRkX2Rsb2JqKHBjbSwgaCk7CiAKIAlpZiAoZXJyIDwgMCkgewotCQlz
bmRfZGxjbG9zZShoKTsKKwkJaWYoaCkKKwkJCXNuZF9kbGNsb3NlKGgpOwogCQlyZXR1cm4g
ZXJyOwogCX0KIAlyZXR1cm4gMDsKLS0gCjEuNy4xCgo=


------=SAMSUNG_mySingle_MIME_MULTIPART_BOUNDARY
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


------=SAMSUNG_mySingle_MIME_MULTIPART_BOUNDARY--
