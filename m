From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 0/2] Remove set_fs() from drivers
Date: Tue, 16 May 2017 20:41:24 +0900
Message-ID: <40d1a7aa-ba94-da7a-a751-e1d3f6143c4c@sakamocchi.jp>
References: <20170516073200.29504-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id 33026266587
 for <alsa-devel@alsa-project.org>; Tue, 16 May 2017 13:41:31 +0200 (CEST)
In-Reply-To: <20170516073200.29504-1-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

T24gMjAxN+W5tDA15pyIMTbml6UgMTY6MzEsIFRha2FzaGkgSXdhaSB3cm90ZToKPiBIaSwKPgo+
IHRoaXMgaXMgYWdhaW4gYSByZXN1Ym1pc3Npb24gb2YgYSBwYXJ0IG9mIHRoZSBwcmV2aW91cyBS
RkMgcGF0Y2hzZXQuCj4gTm8gY2hhbmdlcyBmb3IgdGhlbSwganVzdCBzdWJtaXR0ZWQgYXMgdGhl
IG9mZmljaWFsIHBhdGNoZXMgZm9yCj4gbWVyZ2luZyB0byA0LjEzLgo+Cj4KPiBUYWthc2hpCj4K
PiA9PT0KPgo+IFRha2FzaGkgSXdhaSAoMik6Cj4gICBBTFNBOiBvcGwzOiBLaWxsIHVudXNlZCBz
ZXRfZnMoKQo+ICAgQUxTQTogZW11MTBrMTogR2V0IHJpZCBvZiBzZXRfZnMoKSB1c2FnZQo+Cj4g
IHNvdW5kL2RyaXZlcnMvb3BsMy9vcGwzX29zcy5jIHwgIDE0IC0tLS0tCj4gIHNvdW5kL3BjaS9l
bXUxMGsxL2VtdWZ4LmMgICAgIHwgMTI3ICsrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0t
LS0tLS0tLS0tLQo+ICAyIGZpbGVzIGNoYW5nZWQsIDczIGluc2VydGlvbnMoKyksIDY4IGRlbGV0
aW9ucygtKQoKQWxsIGNoYW5nZXM6CgpSZXZpZXdlZC1ieTogVGFrYXNoaSBTYWthbW90byA8by10
YWthc2hpQHNha2Ftb2NjaGkuanA+CgoKUmVnYXJkcwoKVGFrYXNoaSBTYWthbW90bwpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxp
bmcgbGlzdApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cDovL21haWxtYW4uYWxzYS1w
cm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
