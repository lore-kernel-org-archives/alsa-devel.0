From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH] ASoC: da9055: Partially fix device
	registration
Date: Wed, 8 Jan 2014 21:26:17 +0000
Message-ID: <20140108212617.GA18611@lee--X1>
References: <1389213535-10801-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wg0-f49.google.com (mail-wg0-f49.google.com [74.125.82.49])
 by alsa0.perex.cz (Postfix) with ESMTP id 2C8AF265176
 for <alsa-devel@alsa-project.org>; Wed,  8 Jan 2014 22:26:21 +0100 (CET)
Received: by mail-wg0-f49.google.com with SMTP id x12so1976519wgg.28
 for <alsa-devel@alsa-project.org>; Wed, 08 Jan 2014 13:26:21 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1389213535-10801-1-git-send-email-broonie@kernel.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, linaro-kernel@lists.linaro.org, Samuel Ortiz <sameo@linux.intel.com>, Mark Brown <broonie@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>, Anthony Olech <anthony.olech.opensource@diasemi.com>
List-Id: alsa-devel@alsa-project.org

PiBpbmRleCA5NTZhZmE0NDU5OTguLmUyOTM3OTdkZWQ2NiAxMDA2NDQKPiAtLS0gYS9pbmNsdWRl
L2xpbnV4L21mZC9kYTkwNTUvY29yZS5oCj4gKysrIGIvaW5jbHVkZS9saW51eC9tZmQvZGE5MDU1
L2NvcmUuaAo+IEBAIC00Miw3ICs0Miw3IEBAIHN0cnVjdCBkYTkwNTUgewo+ICAJc3RydWN0IHJl
Z21hcCAqcmVnbWFwOwo+ICAJc3RydWN0IHJlZ21hcF9pcnFfY2hpcF9kYXRhICppcnFfZGF0YTsK
PiAgCXN0cnVjdCBkZXZpY2UgKmRldjsKPiAtCXN0cnVjdCBpMmNfY2xpZW50ICppMmNfY2xpZW50
Owo+ICsJc3RydWN0IGkyY19jbGllbnQgKmkyY19jbGllbnQsICpjb2RlYzsKCkknZCBwcmVmZXIg
dGhpcyBvbiBpdHMgb3duIGluIGEgc3RydWN0IGRlY2xhcmF0aW9uLgoKQXBhcnQgZnJvbSB0aGF0
IE1GRCBwYXJ0cyBsb29rIGdvb2QgdG8gbWUuCgpDYW4geW91IGNyZWF0ZSBhbiBJQiBmb3IgbWUg
dG8gcHVsbCBmcm9tPwoKLS0gCkxlZSBKb25lcwpMaW5hcm8gU1RNaWNyb2VsZWN0cm9uaWNzIExh
bmRpbmcgVGVhbSBMZWFkCkxpbmFyby5vcmcg4pSCIE9wZW4gc291cmNlIHNvZnR3YXJlIGZvciBB
Uk0gU29DcwpGb2xsb3cgTGluYXJvOiBGYWNlYm9vayB8IFR3aXR0ZXIgfCBCbG9nCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkFsc2EtZGV2ZWwgbWFpbGlu
ZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRwOi8vbWFpbG1hbi5hbHNhLXBy
b2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=
