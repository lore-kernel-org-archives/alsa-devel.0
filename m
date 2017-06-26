From: John Stultz <john.stultz@linaro.org>
Subject: Re: [PATCH] drm: adv7511_audio: Add .get_dai_id callback to map port
 number to dai id
Date: Mon, 26 Jun 2017 09:31:34 -0700
Message-ID: <CALAqxLUqt-pyRimWjJL6QYnvX17wSjbkdy_Vsynbhrf8bfgfnQ@mail.gmail.com>
References: <1497391189-9301-1-git-send-email-john.stultz@linaro.org>
 <20170614000543.l636aslxdt5xd32f@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20170614000543.l636aslxdt5xd32f@sirena.org.uk>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Mark Brown <broonie@kernel.org>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, lkml <linux-kernel@vger.kernel.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, Rob Herring <robh+dt@kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

T24gVHVlLCBKdW4gMTMsIDIwMTcgYXQgNTowNSBQTSwgTWFyayBCcm93biA8YnJvb25pZUBrZXJu
ZWwub3JnPiB3cm90ZToKPiBPbiBUdWUsIEp1biAxMywgMjAxNyBhdCAwMjo1OTo0OVBNIC0wNzAw
LCBKb2huIFN0dWx0eiB3cm90ZToKPj4gQUxTQSBTb0MgbmVlZHMgdG8ga25vdyBjb25uZWN0ZWQg
REFJIElEIGZvciBwcm9iaW5nLiBVc2luZwo+PiB0aGUgbmV3IGF1ZGlvLWNhcmQtZ3JhcGggYXBw
cm9hY2gsIHBvcnRzL2VuZHBvaW50cyBhcmUgdXNlZAo+PiB0byBkZXNjcmliZSBob3cgdGhlIGxp
bmtzIGFyZSBjb25uZWN0ZWQuIFVuZm9ydHVuYXRlbHksIHNpbmNlCj4KPiBVbmxlc3Mgc29tZW9u
ZSBvYmplY3RzIGluIHRoZSBuZXh0IHdlZWsgb3Igc28gSSBpbnRlbmQgdG8gYXBwbHkgdGhpcy4K
CgpIZXkgTWFyaywKICBKdXN0IHdhbnRlZCB0byBjaGVjayBvbiB0aGlzIHRvIG1ha2Ugc3VyZSBp
dCBkaWRuJ3Qgc2xpcCBieS4gSSd2ZQpub3Qgc2VlbiBpdCBzaG93IHVwIGluIC1uZXh0IHlldC4K
CnRoYW5rcwotam9obgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwpkcmktZGV2ZWwgbWFpbGluZyBsaXN0CmRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5v
cmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2
ZWwK
