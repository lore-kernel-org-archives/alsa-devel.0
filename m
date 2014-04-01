From: Nicolin Chen <Guangyu.Chen@freescale.com>
Subject: [PATCH bisect 0/2] ASoC: fsl_sai: Overwrite trigger()
Date: Tue, 1 Apr 2014 11:17:05 +0800
Message-ID: <1396322227-482-1-git-send-email-Guangyu.Chen@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, Li.Xiubo@freescale.com, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, timur@tabi.org
List-Id: alsa-devel@alsa-project.org

VGhpcyBzZXJpZXMgb2YgcGF0Y2hlcyBhcmUgYmlzZWN0ZWQgZnJvbSB0aGUgcHJlaXZvdXMgdmVy
c2lvbiBzbyBhcyB0bwphcHBseSB0aGUgUEFUQ0gtMSBvbnRvIGFzb2MtdjMuMTUtNC4KCiogVGhl
IHBhdGNoZXMgYXJlIGdlbmVyYXRlZCBieSB1c2luZyAnLVUyJyBiZWNhdXNlIHRoZSBkZWZhdWx0
ICctVTMnCiAgd291bGQgY29uZmxpY3QgdGhlIGJhc2VsaW5lIHdpdGhvdXQgZnNsX3NhaV9pc3Ig
cGF0Y2hlcy4KCk5pY29saW4gQ2hlbiAoMik6CiAgQVNvQzogZnNsX3NhaTogRml4IGJ1Z2d5IGNv
bmZpZ3VyYXRpb25zIGluIHRyaWdnZXIoKQogIEFTb0M6IGZzbF9zYWk6IFNlcGFyYXRlbHkgZW5h
YmxlIGludGVycnVwdHMgZm9yIFR4IGFuZCBSeCBzdHJlYW1zCgogc291bmQvc29jL2ZzbC9mc2xf
c2FpLmMgfCA0MyArKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0tCiBz
b3VuZC9zb2MvZnNsL2ZzbF9zYWkuaCB8IDExICsrKysrKysrKysrCiAyIGZpbGVzIGNoYW5nZWQs
IDM0IGluc2VydGlvbnMoKyksIDIwIGRlbGV0aW9ucygtKQoKLS0gCjEuOC40CgoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXhwcGMtZGV2IG1haWxp
bmcgbGlzdApMaW51eHBwYy1kZXZAbGlzdHMub3psYWJzLm9yZwpodHRwczovL2xpc3RzLm96bGFi
cy5vcmcvbGlzdGluZm8vbGludXhwcGMtZGV2
