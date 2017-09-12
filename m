From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH] pcm: softvol: add support for S24_LE
Date: Tue, 12 Sep 2017 23:53:19 +0900
Message-ID: <3c215843-344c-0e32-c870-a8f133b867cb@sakamocchi.jp>
References: <20170908101151.29368-1-joerg.krause@embedded.rocks>
 <720f5f32-9d90-35a5-ec4c-9b0af013f905@ladisch.de>
 <1505196817.26012.4.camel@embedded.rocks>
 <3587a5fe-6624-109b-d291-10ee592f02ba@ladisch.de>
 <1505198948.26012.15.camel@embedded.rocks>
 <c6d2072a-5403-cc67-519e-f7dda0ceb147@ladisch.de>
 <s5h377spezh.wl-tiwai@suse.de> <1505225758.2863.11.camel@embedded.rocks>
 <s5hshfsasxi.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id 6F4F8266B23
 for <alsa-devel@alsa-project.org>; Tue, 12 Sep 2017 16:53:25 +0200 (CEST)
In-Reply-To: <s5hshfsasxi.wl-tiwai@suse.de>
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
To: Takashi Iwai <tiwai@suse.de>, =?UTF-8?Q?J=c3=b6rg_Krause?= <joerg.krause@embedded.rocks>
Cc: alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

SGksCgpPbiAyMDE35bm0MDnmnIgxMuaXpSAyMzozMiwgVGFrYXNoaSBJd2FpIHdyb3RlOgo+IFlv
dSBjYW4gc2ltcGx5IG1hc2sgMHhmZmZmZmYgKG9yIDB4ZmZmZmZmMDAsIGRlcGVuZGluZyBvbiBD
UFUtbmF0aXZlCj4gb3Igbm90KSB0byB0aGUgaW50IHZhbHVlIGluc3RlYWQgb2YgYXNzaWduaW5n
IC8gY2FsY3VsYXRpbmcgZWFjaCBieXRlLgo+IEFuZCBpdCdzIG5lZWRlZCBvbmx5IHdoZW4gdm9s
X3NjYWxlICE9MCAmJiB2b2xfc2NhbGUgIT0gMHhmZmZmLgoKVnVtZXRlciBpbXBsZW1lbnRhdGlv
biBvZiBhcGxheSBpbiBhbHNhLXV0aWxzLmdpdCBnZW5lcmF0ZXMgbWFzayBmcm9tIApyZXR1cm4g
dmFsdWUgb2YgJ3NuZF9wY21fZm9ybWF0X3NpbGVuY2VbfF8xNnxfMzJ8XzY0XSgpJy4gSSBzdXBw
b3NlIHRoaXMgCmlzIGFsc28gdXNlZnVsIGluIHlvdXIgY2FzZS4KCgpSZWdhcmRzCgpUYWthc2hp
IFNha2Ftb3RvCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRw
Oi8vbWFpbG1hbi5hbHNhLXByb2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=
