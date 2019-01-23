From: "Zhu, Yingjiang" <yingjiang.zhu@linux.intel.com>
Subject: How ALSA handle PCM playing when the ALSA modules are
	removing
Date: Wed, 23 Jan 2019 13:01:57 +0800
Message-ID: <130c0184-88f9-df56-ac32-98627a1acb0e@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by alsa0.perex.cz (Postfix) with ESMTP id 69AF12674AC
 for <alsa-devel@alsa-project.org>; Wed, 23 Jan 2019 06:02:01 +0100 (CET)
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, tiwai@suse.de, "pierre-louis.bossart@linux.intel.com; liam.r.girdwood"@linux.intel.com
List-Id: alsa-devel@alsa-project.org

SGksIFRha2FzaGkKCiDCoMKgwqAgwqDCoMKgIEkgYW0gZG9pbmcgYW4gQUxTQSBtb2R1bGUgdGVz
dCB3aXRoIGluc2VydCBtb2R1bGUvcmVtb3ZlIG1vZHVsZSAKbG9vcCwgd2hlbiBwbGF5aW5nIGEg
d2F2ZSBkdXJpbmcgdGhpcyBsb29wLCB0aGVyZSB3aWxsIGJlIGtlcm5lbCBvb3BzLiAKRG9lcyBB
TFNBIG5lZWQgaGFuZGxlIHRoaXMgY2FzZT8gT3IganVzdCBmb3JiaWQgd2F2ZSBwbGF5aW5nIGR1
cmluZyB0aGUgCm1vZHVsZSBsb2FkL3VubG9hZD8KCiDCoMKgwqAgwqDCoMKgIElmIHRoaXMgbmVl
ZCB0byBiZSBoYW5kbGVkLCBtb2R1bGUgdW5sb2FkIHdpbGwgd2FpdCB0aGUgd2F2ZSAKcGxheSBl
bmRpbmcsIG9yIGp1c3Qgc3RvcCB0aGUgd2F2ZSBwbGF5IGF0IHRoZSBmaXJzdCBvZiB0aGUgbG9h
ZC91bmxvYWQ/CgpCUgoKWWluZ2ppYW5nCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNhLWRldmVsQGFsc2Et
cHJvamVjdC5vcmcKaHR0cDovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2Fsc2EtZGV2ZWwK
