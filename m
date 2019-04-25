From: "rander.wang" <rander.wang@linux.intel.com>
Subject: HDAudio and pulse audio
Date: Thu, 25 Apr 2019 16:50:32 +0800
Message-ID: <ca0ffa32-dc13-6fbf-42d7-65ee7879f681@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B8694F8961C
 for <alsa-devel@alsa-project.org>; Thu, 25 Apr 2019 10:50:38 +0200 (CEST)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

SGkgYWxsLAoKIMKgwqDCoMKgwqDCoMKgIEkgYW0gd29ya2luZyBvbiBzb3VuZCBvcGVuIGZpcm13
YXJlIGluIEFTb0MgdG8gZW5hYmxlIEhEQXVkaW8gCndpdGggcHVsc2UgYXVkaW8gaW4gdWJ1bnR1
LgogwqDCoMKgwqDCoMKgwqAgVGhlcmUgaXMgYSBIREF1ZGlvIGNvZGVjIGRyaXZlciBoZGFjX2hk
YS5jIGluIEFTb0MsIHdoaWNoIAppbnZva2VzIEhEQXVkaW8gZnVuY3Rpb25zIGRlZmluZWQKIMKg
wqDCoMKgwqDCoMKgIGluIHNvdW5kL3BjaS9oZGEsIGZvciBBU29DIHRvIHV0aWxpemUgdGhlIEhE
QXVkaW8gY29kZWMuIE5vdyBJIApnZXQgYSBpc3N1ZTogcHVsc2UgYXVkaW8gY2FuJ3TCoCBkZXRl
Y3QKIMKgwqDCoMKgwqDCoCBoZWFkcGhvbmUgcGx1Z2VkIG9yIG5vdC4KCiDCoMKgwqDCoMKgwqDC
oCBDb3VsZCBhbnlvbmUgaGVscCB0byB0ZWxsIG1lIGFib3V0IEphY2sgZGV0ZWN0aW9uIGZsb3cg
aW4gCkhEQXVkaW8gYW5kIGhvdyBkb2VzIEhEQXVkaW8KIMKgwqDCoMKgwqDCoMKgIHdvcmsgd2l0
aCBwdWxzZSBhdWRpbyA/IERvZXMgSERBdWRpbyByZXBvcnQgYSBldmVudCB0byBwdWxzZSAKYXVk
aW8gd2hlbiBoZWFkcGhvbmUgZGV0ZWN0ZWQgPwogwqDCoMKgwqDCoMKgIEFzIEkga25vdyzCoCBB
U29DIGNvZGVjIGRyaXZlciB3b3VsZCBpbnZva2Ugc25kX3NvY19qYWNrX3JlcG9ydCAKdG8gbm90
aWZ5IHVzZXIgbW9kZSwgaG93IGFib3V0IEhEQXVkaW8KIMKgwqDCoMKgwqDCoCBkcml2ZXIgPwoK
VGhhbmtzIQoKUmFuZGVyCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5v
cmcKaHR0cHM6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNh
LWRldmVsCg==
