From: Jean-Francois Moine <moinejf@free.fr>
Subject: Re: [alsa-devel] [PATCH RFC V2 0/5] another generic audio hdmi
 codec proposal
Date: Tue, 6 Oct 2015 16:33:11 +0200
Message-ID: <20151006163311.03067bb5@OPI2>
References: <1443718221-5120-1-git-send-email-arnaud.pouliquen@st.com>
 <56127ADB.6080700@ti.com> <561392F7.90608@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <561392F7.90608@st.com>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, Benjamin Gaignard <benjamin.gaignard@linaro.org>, "broonie@kernel.org" <broonie@kernel.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "peter.ujfalusi@ti.com" <peter.ujfalusi@ti.com>, "tony@atomide.com" <tony@atomide.com>, "tomi.valkeinen@ti.com" <tomi.valkeinen@ti.com>, Jyri Sarha <jsarha@ti.com>, "bcousson@baylibre.com" <bcousson@baylibre.com>
List-Id: alsa-devel@alsa-project.org

T24gVHVlLCA2IE9jdCAyMDE1IDExOjIzOjAzICswMjAwCkFybmF1ZCBQb3VsaXF1ZW4gPGFybmF1
ZC5wb3VsaXF1ZW5Ac3QuY29tPiB3cm90ZToKCVtzbmlwXQo+IEFzIEFQSSBpcyBkZWZpbmVkIGlu
IERSTSwgaXQgc2VlbXMgbW9yZSBsb2dpY2FsIHRvIG1hdGNoIGl0IHdpdGggdGhlIG9uZQo+IGRl
ZmluZWQgZm9yIHZpZGVvLiBGcm9tIG15IHdpbmRvd3MsIGkgZGlkbid0IHNlZSBhbnkgYmxvY2tp
bmcgcG9pbnQgdG8KPiBjb25uZWN0IGNvZGVjIGNhbGxiYWNrIHdpdGggdGhpcyBBUEkuCj4gQnV0
IGFueXdheSwgdGhpcyBBUEkgaXMgbm90IGZyZWV6ZWQsIGl0IGNvdWxkIGJlIGltcHJvdmVkIHdp
dGggeW91ciBoZWxwLgoKQXJuYXVkLCB5b3VyIGltcGxlbWVudGF0aW9uIHNlZW1zIG1vcmUgaGVh
dnkgdGhhbiBKeXJpJ3MsIGFuZCBJIGRvbid0CmZlZWwgdGhlIERSTSBicmlkZ2UuCgpGb3IgSERN
SSwgdGhlIGV4Y2hhbmdlcyBiZXR3ZWVuIERSTSBhbmQgQUxTQSBhcmUgb25seToKLSBEUk0gLT4g
QUxTQQogIC0gZGV2aWNlIGNvbm5lY3Rpb24gd2l0aCB0aGUgYXVkaW8gY29uc3RyYWludHMKICAt
IGRldmljZSBkaXNjb25uZWN0aW9uCi0gQUxTQSAtPiBEUk0KICAtIHN0YXJ0IGF1ZGlvIHdpdGgg
dGhlIGNob3NlbiBhdWRpbyBwYXJhbWV0ZXJzCiAgLSBzdG9wIGF1ZGlvCgphbmQsIGluIHRoZSBz
eXN0ZW0sIHRoZSBIRE1JIGRldmljZXMgYXJlIHNlZW4gYXMgRFJNIGNvbm5lY3RvcnMgKHZpZGVv
CnZpZXcpIGFuZCBhcyBBU29DIENPREVDcyAoYXVkaW8gdmlldykuCgpXZSBqdXN0IG5lZWQgYSBs
aW5rIGJldHdlZW4gdGhlc2UgZW50aXRpZXMuCkkgZG9uJ3QgdGhpbmsgdGhhdCB0aGUgYnJpZGdl
IG9mZmVycyB0aGlzLgoKKGdvaW5nIGZ1cnRoZXIsIGl0IHNlZW1zIG5hdHVyYWwgdG8gbWUgdGhh
dCBib3RoIGVudGl0aWVzIHdvdWxkIGJlCnN1cHBvcnRlZCBieSB0aGUgc2FtZSBrZXJuZWwgZGV2
aWNlIGFuZCB0aGF0IHRoZSBleGNoYW5nZSBmdW5jdGlvbnMgYW5kCnZhbHVlcyBjb3VsZCBiZSBk
ZWZpbmVkIGJvdGggd2F5cyBmcm9tIGEgY29tbW9uIHN0cnVjdHVyZSAtIGF1ZGlvCmNvbnN0cmFp
bnRzLCBwbGF5YmFjayBwYXJhbWV0ZXJzLCBjb25uZWN0b3IyY29kZWMgZnVuY3Rpb25zLApjb2Rl
YzJjb25uZWN0b3IgZnVuY3Rpb25zIC0gYnV0IHRoaXMgaXMgYW4gb3RoZXIgc3RvcnkuLi4pCgot
LSAKS2VuIGFyIGMnaGVudGHDsQl8CSAgICAgICoqIEJyZWl6aCBoYSBMaW51eCBhdGF2ISAqKgpK
ZWYJCXwJCWh0dHA6Ly9tb2luZWpmLmZyZWUuZnIvCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmRyaS1kZXZlbCBtYWlsaW5nIGxpc3QKZHJpLWRldmVsQGxp
c3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4v
bGlzdGluZm8vZHJpLWRldmVsCg==
