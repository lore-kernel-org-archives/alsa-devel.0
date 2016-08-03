From: Dhinakaran Pandiyan <dhinakaran.pandiyan@intel.com>
Subject: DP audio API changes for identifying displays connected
	to a port
Date: Tue,  2 Aug 2016 19:14:29 -0700
Message-ID: <1470190470-32326-1-git-send-email-dhinakaran.pandiyan@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: intel-gfx-bounces@lists.freedesktop.org
Sender: "Intel-gfx" <intel-gfx-bounces@lists.freedesktop.org>
To: intel-gfx@lists.freedesktop.org
Cc: tiwai@suse.de, libin.yang@linux.intel.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

CkFuIGFkZGl0aW9uYWwgcGFyYW1ldGVyIGhhcyBiZWVuIGFkZGVkIHRvIHRoZSBBUEkncyBiZXR3
ZWVuIGk5MTUgYW5kIGF1ZGlvCmRyaXZlcnMgdG8gaWRlbnRpZnkgZGlzcGxheSBkZXZpY2VzIHRo
YXQgY2FuIGJlIGNvbm5lY3RlZCB0byB0aGUgc2FtZSBwb3J0LgpDdXJyZW50bHkgb25seSB0aGUg
cG9ydCBpZGVudGl0eSBpcyBiZWluZyBzaGFyZWQsIGJ1dCB0aGlzIGlzIG5vdApzdWZmaWNpZW50
IGFzIG11bHRpcGxlIGRpc3BsYXlzIGNhbiBiZSBkcml2ZW4gZnJvbSB0aGUgc2FtZSBwb3J0CihF
LmcuIERQIE1TVCkuIFRoaXMgcGF0Y2ggbWFrZXMgdGhlIEFQSSBjaGFuZ2VzIHdpdGggZHVtbXkg
Y2hhbmdlcyBpbiB0aGUKYXVkaW8gZHJpdmVyIChUaGFua3MgTGliaW4pLiBJbXBsZW1lbnRhdGlv
biB0byBmdWxseSBlbmFibGUgRFAgTVNUIGF1ZGlvCndpbGwgZm9sbG93IGxhdGVyLgoKRGhpbmFr
YXJhbiBQYW5kaXlhbigxKToKZHJtL2k5MTUvZHA6IERQIGF1ZGlvIEFQSSBjaGFuZ2VzIGZvciBN
U1QKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KSW50ZWwt
Z2Z4IG1haWxpbmcgbGlzdApJbnRlbC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8v
bGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vaW50ZWwtZ2Z4Cg==
