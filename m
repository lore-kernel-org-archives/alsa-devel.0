From: Daniel Chen <seven.steps@gmail.com>
Subject: Re: [PATCH] ALSA: hda: Use LPIB for Toshiba A100-259
Date: Sat, 22 May 2010 16:23:55 -0400
Message-ID: <AANLkTil6WBT7UlomPGzeIUcSzNn1PWsN0ztp3e0dXwGU@mail.gmail.com>
References: <AANLkTikdfY6kUNYqlXCKRgUjystXVoPyYqviryMCrHjk@mail.gmail.com>
	<1274556463.21620.1.camel@mattotaupa>
	<AANLkTilDJbBQYwnSiRW-Bwtfr-syvnBO0tIluhMnHBhk@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-px0-f179.google.com (mail-px0-f179.google.com
	[209.85.212.179])
	by alsa0.perex.cz (Postfix) with ESMTP id BCA7B2414A
	for <alsa-devel@alsa-project.org>;
	Sat, 22 May 2010 22:23:57 +0200 (CEST)
Received: by pxi13 with SMTP id 13so1080230pxi.38
	for <alsa-devel@alsa-project.org>; Sat, 22 May 2010 13:23:56 -0700 (PDT)
In-Reply-To: <AANLkTilDJbBQYwnSiRW-Bwtfr-syvnBO0tIluhMnHBhk@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Paul Menzel <paulepanter@users.sourceforge.net>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

KFNvcnJ5IGZvciB0b3AgcG9zdGluZyBkdWUgdG8gTVVBKQoKQ29udmVudGlvbiBpcyB0byBzb3J0
IGFzY2VuZGluZzsgMHgxMTA2IHByb2NlZWRzIDB4MTA0My4KCk9uIE1heSAyMiwgMjAxMCAzOjI3
IFBNLCAiUGF1bCBNZW56ZWwiIDxwYXVsZXBhbnRlckB1c2Vycy5zb3VyY2Vmb3JnZS5uZXQ+Cndy
b3RlOgoKRGVhciBEYW5pZWwsCgoKQW0gU2Ftc3RhZywgZGVuIDIyLjA1LjIwMTAsIDEzOjI1IC0w
NDAwIHNjaHJpZWIgRGFuaWVsIENoZW46Cgpb4oCmXQoKPiAtICAgICAgIFNORF9QQ0lfUVVJUkso
MHgxMTA2LCAweDMyODgsICJBU1VTIE0yVi1NWCBTRSIsIFBPU19GSVhfTFBJQiksCj4gICAgICAg
ICBTTkRfUENJX1FVSVJLKDB4MTA0MywgMHg4MTNkLCAiQVNVUyBQNUFEMiIsIFBPU19GSVhfTFBJ
QiksCj4gKyAgICAgICBTTkRfUENJX1FVSVJLKDB4MTEwNiwgMHgzMjg4LCAiQVNVUyBNMlYtTVgg
U0UiLCBQT1NfRklYX0xQSUIpLAo+ICsgICAgICAgU05EX1BDSV9RVUlSSygweDExNzksIDB4ZmYx
MCwgIlRvc2hpYmEgQTEwMC0yNTkiLCBQT1NfRklYX0xQSUIpLAoKSXMgbm90IMK7bcKrIGJlZm9y
ZSDCu3DCqyBpbiB0aGUgYWxwaGFiZXQ/CgoKVGhhbmtzLAoKUGF1bAoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KQWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QK
QWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0dHA6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5v
cmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVsCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxA
YWxzYS1wcm9qZWN0Lm9yZwpodHRwOi8vbWFpbG1hbi5hbHNhLXByb2plY3Qub3JnL21haWxtYW4v
bGlzdGluZm8vYWxzYS1kZXZlbAo=
