From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH v2] ALSA: snd-usb-audio: set the timeout
 for usb control set messages to 5000 ms
Date: Sat, 20 Apr 2013 22:19:55 +0200
Message-ID: <5172F86B.2060207@gmail.com>
References: <CABVYHNhfzWNhi0Jv=Z-WET-4amLnhB7Kq1Gi_bKc-Pf4cqqHHw@mail.gmail.com>
 <20130420192414.GB5650@pvv.ntnu.no>
 <CABVYHNjK4THGcVnak4-_-SPGdSGHNoRtmznMqStQ=U8t6f1VBg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f44.google.com (mail-bk0-f44.google.com
 [209.85.214.44])
 by alsa0.perex.cz (Postfix) with ESMTP id 535D22651AE
 for <alsa-devel@alsa-project.org>; Sat, 20 Apr 2013 22:19:49 +0200 (CEST)
Received: by mail-bk0-f44.google.com with SMTP id jk13so2114797bkc.3
 for <alsa-devel@alsa-project.org>; Sat, 20 Apr 2013 13:19:49 -0700 (PDT)
In-Reply-To: <CABVYHNjK4THGcVnak4-_-SPGdSGHNoRtmznMqStQ=U8t6f1VBg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: =?UTF-8?B?RGFuaWVsIFNjaMO8cm1hbm4=?= <daschuer@mixxx.org>
Cc: Takashi Iwai <tiwai@suse.de>, Torstein Hegge <hegge@resisty.net>, alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>, "Gabriel M. Beddingfield" <gabrbedd@gmail.com>
List-Id: alsa-devel@alsa-project.org

T24gMjAuMDQuMjAxMyAyMjoxNywgRGFuaWVsIFNjaMO8cm1hbm4gd3JvdGU6Cj4gSGkgVG9yc3Rl
aW4sIEhpIERhbmllbCAKPiAKPiBUaGFuayB5b3UgZm9yIHlvdXIgaGludC4KPiAKPiBKdXN0IG5v
dGljZWQgdGhhdCB0aGUgZ2V0IHRpbWVvdXQgaXMgYWxzbyBzZXQgdG8gNTAwMCBtcyBldmVuIGlm
IHRoZSBVU0IKPiAyIHNwZWMgb25seSBhbGxvd3MgNTAwIG1zLgo+IAo+IERvIHlvdSB0aGluayBp
dCBpcyBhbHNvIGEgZ29vZCBpZGVhIHRvIGFkb3B0IHRoZSA1MDAwIG1zIGdldCB0aW1vdXQgZm9y
Cj4gc25kLXVzYi1hdWRpbz8KCldlbGwsIGluIHRoYXQgY2FzZSwgd2UgY2FuIGluZGVlZCBqdXN0
IHNldCBpdCB0byA1MDAwIHVuY29uZGl0aW9uYWxseSwKd2hpY2ggbWFrZXMgeW91ciBwYXRjaCBh
IG9uZS1saW5lci4KCgpUaGFua3MsCkRhbmllbAoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KQWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBh
bHNhLXByb2plY3Qub3JnCmh0dHA6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9hbHNhLWRldmVsCg==
