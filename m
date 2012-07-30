From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 13/18] ARM: ux500: Add ux500 PCM to DB8500
	Device Tree
Date: Mon, 30 Jul 2012 08:32:43 +0100
Message-ID: <5016389B.4020003@linaro.org>
References: <1343393162-11938-1-git-send-email-lee.jones@linaro.org>
 <1343393162-11938-14-git-send-email-lee.jones@linaro.org>
 <20120729205001.GK4384@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ee0-f51.google.com (mail-ee0-f51.google.com [74.125.83.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 4644426525A
 for <alsa-devel@alsa-project.org>; Mon, 30 Jul 2012 09:32:43 +0200 (CEST)
Received: by eeke50 with SMTP id e50so922881eek.38
 for <alsa-devel@alsa-project.org>; Mon, 30 Jul 2012 00:32:45 -0700 (PDT)
In-Reply-To: <20120729205001.GK4384@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: ola.o.lilja@stericsson.com, alsa-devel@alsa-project.org, linus.walleij@stericsson.com, arnd@arndb.de, olalilja@yahoo.se, linux-kernel@vger.kernel.org, STEricsson_nomadik_linux@list.st.com, lrg@ti.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

T24gMjkvMDcvMTIgMjE6NTAsIE1hcmsgQnJvd24gd3JvdGU6Cj4gT24gRnJpLCBKdWwgMjcsIDIw
MTIgYXQgMDE6NDU6NTdQTSArMDEwMCwgTGVlIEpvbmVzIHdyb3RlOgo+PiBOb3RoaW5nIHNwZWNp
YWwgaGVyZS4gV2UncmUgb25seSBwcm92aWRpbmcgYSBjb21wYXRpYmxlIHN0cmluZwo+PiB0byBl
bnN1cmUgdGhlIGRyaXZlciBpcyBwcm9iZWQgdXNpbmcgYSBEZXZpY2UgVHJlZSBib290Lgo+Cj4+
ICsJCXBjbTogdXg1MDAtcGNtIHsKPj4gKwkJCWNvbXBhdGlibGUgPSAic3Rlcmljc3Nvbix1eDUw
MC1wY20iOwo+PiArCQl9Owo+PiArCj4KPiBPbmUgb2YgdHdvIHRoaW5ncyBpcyB3cm9uZyBoZXJl
LiAgRWl0aGVyIHlvdSd2ZSBub3QgcHJvdmlkZWQgYW55Cj4gaW5mb3JtYXRpb24gYWJvdXQgdGhl
IGhhcmR3YXJlIHNvIHRoZSBkcml2ZXIgd29uJ3QgYmUgYWJsZSB0byB3b3JrIG91dAo+IHdoYXQg
dG8gdGFsayB0byBvciB5b3UndmUgbm90IHByb3ZpZGVkIGFueSBkYXRhIHNvIHlvdSdyZSByZWdp
c3RlcmluZyBhCj4gcHVyZWx5IHZpcnR1YWwgTGludXgtaW50ZXJuYWwgZGV2aWNlIHZpYSB0aGUg
ZGV2aWNlIHRyZWUuCj4KPiBPbmNlIG1vcmUsIHRoZSBpZGVhIGhlcmUgaXMgdG8gZGVzY3JpYmUg
dGhlIGhhcmR3YXJlIG5vdCB0byBkdW1wIExpbnV4J3MKPiBpbnRlcm5hbCBkYXRhIHN0cnVjdHVy
ZXMgaW50byB0aGUgZGV2aWNlIHRyZWUuCgpXZSB1c2UgaXQgcmVnaXN0ZXIgdGhlIGRyaXZlciBm
b3IgcHJvYmUoKWluZy4gSW4gdGhlIHNhbWUgd2F5IHdlIGRvIGZvciAKdGhlIFBNVSBhbmQgUmVn
dWxhdG9ycy4gQWxsIHRocmVlIG9mIHdoaWNoIGFjdHVhbGx5IGJlbG9uZyB0byBhIApkaWZmZXJl
bnQgaGFyZHdhcmUgYmxvY2suIERvIHlvdSBrbm93IG9mIGEgYmV0dGVyIHdheSB0byByZWdpc3Rl
ciB0aG9zZSAKZGV2aWNlcz8KCi0tIApMZWUgSm9uZXMKTGluYXJvIFNULUVyaWNzc29uIExhbmRp
bmcgVGVhbSBMZWFkCkxpbmFyby5vcmcg4pSCIE9wZW4gc291cmNlIHNvZnR3YXJlIGZvciBBUk0g
U29DcwpGb2xsb3cgTGluYXJvOiBGYWNlYm9vayB8IFR3aXR0ZXIgfCBCbG9nCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkFsc2EtZGV2ZWwgbWFpbGluZyBs
aXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRwOi8vbWFpbG1hbi5hbHNhLXByb2pl
Y3Qub3JnL21haWxtYW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=
