From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [alsa-devel] [PATCH 1/2] ASoC: fsl: imx-ssi: fix probe on imx31
Date: Mon, 7 Oct 2013 07:29:29 -0300
Message-ID: <CAOMZO5B8uHE1F2AKt9QA_b=9gbDb-RDQshk17nJs-q68r_6iKQ@mail.gmail.com>
References: <1380630971-11431-1-git-send-email-philippe.retornaz@epfl.ch>
 <1380630971-11431-2-git-send-email-philippe.retornaz@epfl.ch>
 <20131003155954.GV27287@sirena.org.uk> <524D963F.5080507@epfl.ch>
 <CAOMZO5C_kjTJ8iVGc67pcLLaO43arTiyMRQ1822VkBLDm7hzPw@mail.gmail.com>
 <525279CC.8080309@epfl.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <525279CC.8080309@epfl.ch>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: =?UTF-8?Q?Philippe_R=C3=A9tornaz?= <philippe.retornaz@epfl.ch>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Sascha Hauer <s.hauer@pengutronix.de>, Mark Brown <broonie@kernel.org>, Shawn Guo <shawn.guo@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

T24gTW9uLCBPY3QgNywgMjAxMyBhdCA2OjA3IEFNLCBQaGlsaXBwZSBSw6l0b3JuYXoKPHBoaWxp
cHBlLnJldG9ybmF6QGVwZmwuY2g+IHdyb3RlOgoKPiBXZWxsLCBJIGRvbid0IHRoaW5rIGl0J3Mg
ZmFpciB0byBicmVhayBib2FyZHMganVzdCBiZWNhdXNlIHRoZXkgYXJlIG5vdAo+ICh5ZXQpIGNv
bnZlcnRlZCB0byBEVCAuLi4gdGhpcyBib2FyZCB3YXMgbWVyZ2VkIGJlZm9yZSB0aGUgRFQgZXJh
IG9uIEFSTS4KClN1cmUsIEkgYWdyZWUuIEp1c3QgdHJ5aW5nIHRvIGF2b2lkIHRvIGtlZXAgdHdv
IGRyaXZlcnMgZm9yIHRoZSBzYW1lIGhhcmR3YXJlLgoKSSB3aWxsIHRyeSB0byBjb252ZXJ0IG14
MzEgdG8gdXNlIHNvdW5kL3NvYy9mc2wvZnNsX3NzaS5jIHdoZW4gdGltZSBhbGxvd3MuCgpSZWdh
cmRzLAoKRmFiaW8gRXN0ZXZhbQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5l
bEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4v
bGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
