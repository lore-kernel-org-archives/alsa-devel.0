From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [alsa-devel] [PATCH 5/5 v4] ASoC: dwc: Update DOCUMENTATION for
 I2S Driver
Date: Fri, 8 Apr 2016 17:52:13 +0200
Message-ID: <5707D3AD.8030308@metafoo.de>
References: <cover.1460047238.git.joabreu@synopsys.com>
 <ce97e6bb7ddb71e532c4066334ceead4d4d3e692.1460047238.git.joabreu@synopsys.com>
 <20160407175326.GX1924@sirena.org.uk> <570782BF.10402@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <570782BF.10402@synopsys.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Jose Abreu <Jose.Abreu@synopsys.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Vineet.Gupta1@synopsys.com, Alexey.Brodkin@synopsys.com, lgirdwood@gmail.com, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, CARLOS.PALMINHA@synopsys.com, tiwai@suse.com, linux-snps-arc@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

T24gMDQvMDgvMjAxNiAxMjowNiBQTSwgSm9zZSBBYnJldSB3cm90ZToKPiBIaSBNYXJrLAo+IAo+
IAo+IE9uIDA3LTA0LTIwMTYgMTg6NTMsIE1hcmsgQnJvd24gd3JvdGU6Cj4+IE9uIFRodSwgQXBy
IDA3LCAyMDE2IGF0IDA1OjUzOjU5UE0gKzAxMDAsIEpvc2UgQWJyZXUgd3JvdGU6Cj4+Cj4+PiAr
IE9wdGlvbmFsIHByb3BlcnRpZXM6Cj4+PiArIC0gc25wcyx1c2UtZG1hZW5naW5lOiBJZiBzZXQg
dGhlIGRyaXZlciB3aWxsIHVzZSBBTFNBIERNQSBlbmdpbmUuIElmIHNldAo+Pj4gKyAgIGl0IGlz
IHJlcXVpcmVkIHRvIHVzZSB0aGUgcHJvcGVydGllcyAnZG1hcycgYW5kICdkbWEtbmFtZXMnLgo+
PiBUaGlzIGlzIG5vdCBhIGdvb2QgaW50ZXJmYWNlLCBpdCdzIGRlc2NyaWJpbmcgTGludXggaW50
ZXJuYWwgQVBJcy4gIElmCj4+IHRoZSBkZXZpY2UgbmVlZHMgdG8gb3BlcmF0ZSBpbiBQSU8gbW9k
ZSBpdCBzaG91bGQganVzdCBkbyB0aGF0Lgo+IAo+IEkgYWRkZWQgdGhpcyBpbnRlcmZhY2UgYmVj
YXVzZSB0aGVyZSBpcyBubyBkaXJlY3Qgd2F5IHRvIGNoZWNrIGlmIERNQSBpcwo+IGF2YWlsYWJs
ZSBvbiB0aGUgSTJTIGNvbnRyb2xsZXIgc28gaXQgaXMgbm90IHBvc3NpYmxlIHRvIGF1dG9tYXRp
Y2FsbHkgY2hhbmdlCj4gYmV0d2VlbiBETUEgYW5kIFBJTyBtb2RlLiBBcyB0aGUgSTJTIGNvbnRy
b2xsZXIgY2FuIGJlIGJ1aWx0IHdpdGggb3Igd2l0aG91dCBETUEKPiBzdXBwb3J0IGl0IGlzIG5l
Y2Vzc2FyeSB0byBzb21laG93IGNoZWNrIGlmIERNQSBpcyBlbmFibGVkIG9yIG5vdCBhbmQgYWNj
b3JkaW5nCj4gdG8gdGhhdCB1c2UgZWl0aGVyIEFMU0EgRE1BIGVuZ2luZSBvciB0aGUgY3VzdG9t
IHBsYXRmb3JtIGRyaXZlciBzZW50IGluIHRoZXNlCj4gcGF0Y2hlcy4gSSBkaWQgbm90IHdhbnQg
dG8gcmVtb3ZlIGRyaXZlcnMgZnVuY3Rpb25hbGl0eSBzbyBJIGFkZGVkIHRoaXMgcHJvcGVydHkK
PiB0byB0aGUgRFQuIFRoaXMgd2F5IGEgdXNlciBjYW4gc2VsZWN0IGJldHdlZW4gRE1BIGFuZCBQ
SU8gbW9kZS4KClRoYXQncyBPSywgYnV0IHlvdSBuZWVkIHRvIGRlc2NyaWJlIHRoZSBoYXJkd2Fy
ZSwgbm90IHRoZSBpbmRlbnRlZCBiZWhhdmlvcgpvZiB0aGUgc29mdHdhcmUgZHJpdmVyLgoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVsIG1h
aWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==
