From: =?ISO-8859-1?Q?J=F6rg?= Krause <joerg.krause@embedded.rocks>
Subject: Re: [PATCH] pcm: softvol: add support for S24_LE
Date: Tue, 12 Sep 2017 08:13:37 +0200
Message-ID: <1505196817.26012.4.camel@embedded.rocks>
References: <20170908101151.29368-1-joerg.krause@embedded.rocks>
 <720f5f32-9d90-35a5-ec4c-9b0af013f905@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.142])
 by alsa0.perex.cz (Postfix) with ESMTP id ED844266B23
 for <alsa-devel@alsa-project.org>; Tue, 12 Sep 2017 08:13:41 +0200 (CEST)
In-Reply-To: <720f5f32-9d90-35a5-ec4c-9b0af013f905@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

T24gRnJpLCAyMDE3LTA5LTA4IGF0IDEyOjUyICswMjAwLCBDbGVtZW5zIExhZGlzY2ggd3JvdGU6
Cj4gSsO2cmcgS3JhdXNlIHdyb3RlOgo+ID4gVGVzdGVkIHdpdGggYSBXb2xmc29uIFdNODUyNCBE
QUMgb24gYSBpLk1YNlVMIGJvYXJkIHJ1bm5pbmcgTGludXggdmVyc2lvbgo+ID4gNC4xMy4wLW5l
eHQtMjAxNzA5MDcuCj4gPiArCWNhc2UgU05EX1BDTV9GT1JNQVRfUzI0X0xFOgo+ID4gKwkJLyog
MjRiaXQgc2FtcGxlcywgZmFsbHRocm91Z2ggKi8KPiA+ICAJY2FzZSBTTkRfUENNX0ZPUk1BVF9T
MzJfTEU6Cj4gCj4gUzI0X0xFIGNhbm5vdCBiZSBoYW5kbGVkIHdpdGggdGhlIHNhbWUgYWxnb3Jp
dGhtIGFzIFMzMl9MRS4KClRoYXQgd291bGQgaGF2ZSBiZWVuIHRvbyBlYXN5LgoKPiBJIHN1c3Bl
Y3QgdGhhdCB0aGUgaGFyZHdhcmUgZG9lcyBub3QgYWN0dWFsbHkgdXNlIFMyNF9MRSwgYW5kCj4g
dGhhdCB0aGUgZHJpdmVyIHVzZXMgdGhlIHdyb25nIGxhYmVsIGZvciB0aGlzIGZvcm1hdC4KCk1h
eWJlIHlvdSBhcmUgcmlnaHQgYWJvdXQgdGhhdC4gSSB3aWxsIGhhdmUgYSBsb29rLgoKPiBQbGVh
c2UgZGVzY3JpYmUgZXhhY3RseSBob3cgdGhlIDI0LWJpdCBzYW1wbGUgaXMgYWxpZ25lZCBpbnRv
Cj4gdGhlIDMyLWJpdCBtZW1vcnkgY2VsbC4KCkFjY29yZGluZyB0byB0aGlzIG9sZCBwb3N0IFsx
XSBpdCBpcyBhbGlnbmVkIGFzIGZvbGxvd2VkOgoKMDBmZmZmM2YgMDBmZmZmM2YgMDBlYmQ5NmUg
MDBlYmQ5NmUgMDBmZmZmN2YgMDBmZmZmN2YKTWVhbmluZyB0aGUgbGVmdC1tb3N0IGJ5dGUgaXMg
emVyb2VkLCByaWdodD8KClsxXSBodHRwOi8vbWFpbG1hbi5hbHNhLXByb2plY3Qub3JnL3BpcGVy
bWFpbC9hbHNhLWRldmVsLzIwMDgtSnVseS8wMDkwCjk5Lmh0bWwKCkJlc3QgcmVnYXJkcywKSsO2
cmcgS3JhdXNlCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRw
Oi8vbWFpbG1hbi5hbHNhLXByb2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=
