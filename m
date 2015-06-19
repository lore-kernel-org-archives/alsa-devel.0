From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 4/6] ASOC: intel - hsw: fix sparse unused
	varible warn
Date: Fri, 19 Jun 2015 23:55:29 +0530
Message-ID: <1434738331-12518-5-git-send-email-vinod.koul@intel.com>
References: <1434738331-12518-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 89EC726062C
 for <alsa-devel@alsa-project.org>; Fri, 19 Jun 2015 20:24:04 +0200 (CEST)
In-Reply-To: <1434738331-12518-1-git-send-email-vinod.koul@intel.com>
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
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org, Vinod Koul <vinod.koul@intel.com>
List-Id: alsa-devel@alsa-project.org

U3BhcnNlIHJpZ2h0bHkgY29tcGxhaW5zIHRoYXQgdGhlIHZhcmlhYmxlIGhzdyBpcyBub3QgdXNl
ZCBzbyBzaG91bGQKYmUgcmVtb3ZlZCwgc28gcmVtb3ZlIGl0Cgpzb3VuZC9zb2MvaW50ZWwvaGFz
d2VsbC9zc3QtaGFzd2VsbC1wY20uYzogSW4gZnVuY3Rpb24g4oCYaHN3X3BjbV9wcmVwYXJl4oCZ
Ogpzb3VuZC9zb2MvaW50ZWwvaGFzd2VsbC9zc3QtaGFzd2VsbC1wY20uYzoxMzQ5OjE4OiB3YXJu
aW5nOiB1bnVzZWQgdmFyaWFibGUK4oCYaHN34oCZIFstV3VudXNlZC12YXJpYWJsZV0KICBzdHJ1
Y3Qgc3N0X2hzdyAqaHN3ID0gcGRhdGEtPmhzdzsKClNpZ25lZC1vZmYtYnk6IFZpbm9kIEtvdWwg
PHZpbm9kLmtvdWxAaW50ZWwuY29tPgotLS0KIHNvdW5kL3NvYy9pbnRlbC9oYXN3ZWxsL3NzdC1o
YXN3ZWxsLXBjbS5jIHwgMSAtCiAxIGZpbGUgY2hhbmdlZCwgMSBkZWxldGlvbigtKQoKZGlmZiAt
LWdpdCBhL3NvdW5kL3NvYy9pbnRlbC9oYXN3ZWxsL3NzdC1oYXN3ZWxsLXBjbS5jIGIvc291bmQv
c29jL2ludGVsL2hhc3dlbGwvc3N0LWhhc3dlbGwtcGNtLmMKaW5kZXggZTU5M2U3YTRiN2E3Li4x
YWE4MTljN2UwOWIgMTAwNjQ0Ci0tLSBhL3NvdW5kL3NvYy9pbnRlbC9oYXN3ZWxsL3NzdC1oYXN3
ZWxsLXBjbS5jCisrKyBiL3NvdW5kL3NvYy9pbnRlbC9oYXN3ZWxsL3NzdC1oYXN3ZWxsLXBjbS5j
CkBAIC0xMzQ2LDcgKzEzNDYsNiBAQCBzdGF0aWMgdm9pZCBoc3dfcGNtX2NvbXBsZXRlKHN0cnVj
dCBkZXZpY2UgKmRldikKIHN0YXRpYyBpbnQgaHN3X3BjbV9wcmVwYXJlKHN0cnVjdCBkZXZpY2Ug
KmRldikKIHsKIAlzdHJ1Y3QgaHN3X3ByaXZfZGF0YSAqcGRhdGEgPSBkZXZfZ2V0X2RydmRhdGEo
ZGV2KTsKLQlzdHJ1Y3Qgc3N0X2hzdyAqaHN3ID0gcGRhdGEtPmhzdzsKIAlzdHJ1Y3QgaHN3X3Bj
bV9kYXRhICpwY21fZGF0YTsKIAlpbnQgaSwgZXJyOwogCi0tIAoxLjkuMQoKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KQWxzYS1kZXZlbCBtYWlsaW5nIGxp
c3QKQWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0dHA6Ly9tYWlsbWFuLmFsc2EtcHJvamVj
dC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVsCg==
