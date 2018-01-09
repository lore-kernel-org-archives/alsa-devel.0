From: Jiada Wang <jiada_wang@mentor.com>
Subject: Re: Applied "ASoC: rsnd: ssi: fix race condition in rsnd_ssi_pointer_update"
 to the asoc tree
Date: Mon, 8 Jan 2018 21:42:52 -0800
Message-ID: <5A54565C.70805@mentor.com>
References: <E1eNNl3-0003pn-VV@debutante> <661598a7-b62c-074a-a12e-12ed87f4700e@sakamocchi.jp> <20171211113809.GA9854@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171211113809.GA9854@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Takashi Sakamoto <o-takashi@sakamocchi.jp>, alsa-devel@alsa-project.org, kuninori.morimoto.gx@renesas.com, linux-kernel@vger.kernel.org, tiwai@suse.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

Hi Mark

Only the first patch in
https://www.spinics.net/lists/alsa-devel/msg71021.html
was applied, but the second patch "ASoC: rsnd: ssi: remove unnesessary 
period_pos"
was missed

Could you please have a look


Thanks,
Jiada

On 12/11/2017 03:38 AM, Mark Brown wrote:
> On Sat, Dec 09, 2017 at 02:22:50PM +0900, Takashi Sakamoto wrote:
>> On Dec 9 2017 03:52, Mark Brown wrote:
>> The applied patches are in v1 patchset, but we have v2 patchset already:
>> http://mailman.alsa-project.org/pipermail/alsa-devel/2017-December/128970.html
>> Would you please replace the applied patches with the renewed ones? There're
>> slight differences between them.
> As far as I can tell what's applied is v2?
