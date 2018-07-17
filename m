From: Lukas Wunner <lukas@wunner.de>
Subject: Re: [V3] vga_switcheroo: set audio client id according to bound GPU id
Date: Tue, 17 Jul 2018 10:38:58 +0200
Message-ID: <20180717083858.GA29241@wunner.de>
References: <1531815650-9786-1-git-send-email-Jim.Qu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <1531815650-9786-1-git-send-email-Jim.Qu@amd.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Jim Qu <Jim.Qu@amd.com>, tiwai@suse.com
Cc: alexander.deucher@amd.com, alsa-devel@alsa-project.org, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
List-Id: alsa-devel@alsa-project.org

T24gVHVlLCBKdWwgMTcsIDIwMTggYXQgMDQ6MjA6NTBQTSArMDgwMCwgSmltIFF1IHdyb3RlOgo+
IE9uIG1vZGVybiBsYXB0b3AsIHRoZXJlIGFyZSBtb3JlIGFuZCBtb3JlIHBsYXRmb3Jtcwo+IGhh
dmUgdHdvIEdQVXMsIGFuZCBlYWNoIG9mIHRoZW0gbWF5YmUgaGF2ZSBhdWRpbyBjb2RlYwo+IGZv
ciBIRE1QL0RQIG91dHB1dC4gRm9yIHNvbWUgZEdQVSB3aGljaCBpcyBubyBvdXRwdXQsCj4gYXVk
aW8gY29kZWMgdXN1YWxseSBpcyBkaXNhYmxlZC4KPiAKPiBJbiBjdXJyZWN0IEhEQSBhdWRpbyBk
cml2ZXIsIGl0IHdpbGwgc2V0IGFsbCBjb2RlYyBhcwo+IFZHQV9TV0lUQ0hFUk9PX0RJUywgdGhl
IGF1ZGlvIHdoaWNoIGlzIGJpbmRlZCB0byBVTUEKPiB3aWxsIGJlIHN1c3BlbmRlZCBpZiB1c2Vy
IHVzZSBkZWJ1Z2ZzIHRvIGNvbnRvcmwgcG93ZXIKPiAKPiBJbiBIREEgZHJpdmVyIHNpZGUsIGl0
IGlzIGRpZmZpY3VsdCB0byBrbm93IHdoaWNoIEdQVQo+IHRoZSBhdWRpbyBoYXMgYmluZGVkIHRv
LiBTbyBzZXQgdGhlIGJvdW5kIGdwdSBwY2kgZGV2Cj4gdG8gdmdhX3N3aXRjaGVyb28uCj4gCj4g
aWYgdGhlIGF1ZGlvIGNsaWVudCBpcyBub3QgdGhlIHRoaXJkIHJlZ2lzdHJhdGlvbiwgYXVkaW8K
PiBpZCB3aWxsIHNldCBpbiB2Z2Ffc3dpdGNoZXJvbyBlbmFibGUgZnVuY3Rpb24uIGlmIHRoZQo+
IGF1ZGlvIGNsaWVudCBpcyB0aGUgbGFzdCByZWdpc3RyYXRpb24gd2hlbiB2Z2Ffc3dpdGNoZXJv
bwo+IF9yZWFkeSgpIGdldCB0cnVlLCB3ZSBzaG91bGQgZ2V0IGF1ZGlvIGNsaWVudCBpZCBmcm9t
IGJvdW5kCj4gR1BVIGRpcmVjdGx5Lgo+IAo+IFNpZ25lZC1vZmYtYnk6IEppbSBRdSA8SmltLlF1
QGFtZC5jb20+CgpSZXZpZXdlZC1ieTogTHVrYXMgV3VubmVyIDxsdWthc0B3dW5uZXIuZGU+CgpA
VGFrYXNoaSwgYW55IHByZWZlcmVuY2Ugd2hpY2ggdHJlZSB0byBtZXJnZSB0aGlzIHRocm91Z2g/
CnNvdW5kIG9yIGRybS1taXNjLCBlaXRoZXIgd2F5IHdvdWxkIHNlZW0gZmluZSB0byBtZS4gIEkg
dGhpbmsKdGhlcmUncyBnb2luZyB0byBiZSBvbmUgZmluYWwgZHJtLW1pc2MgcHVsbCBzZW50IHRv
IERhdmUgdGhpcwp3ZWVrLCBhZnRlciB0aGF0IGl0J3MgNC4yMC4KClRoYW5rcywKCkx1a2FzCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmRyaS1kZXZlbCBt
YWlsaW5nIGxpc3QKZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3Rz
LmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZlbAo=
