From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v2] ASoC: use seq_file to dump the contents of
 dai_list,platform_list and codec_list
Date: Wed, 7 Feb 2018 16:15:04 +0200
Message-ID: <CAHp75VdvTdwB=EM1DejYHcazBRRgoy5cw=Rs0U5kSTXHWeuUOA@mail.gmail.com>
References: <20180118053126.22082-1-dolinux.peng@gmail.com>
 <CAHp75VcefO1L-E8ymHX7MibLiOXkRZ3+3FbkF_L+ywMV-i3Mvw@mail.gmail.com>
 <20180123173732.GI7600@sirena.org.uk> <CAErzpmt5Z_bVkO-86yCNNWMNSYXWMzvABGtTEuYV1Y1qk=2LJQ@mail.gmail.com>
 <20180126112838.GA32674@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180126112838.GA32674@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Donglin Peng <dolinux.peng@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Fri, Jan 26, 2018 at 1:28 PM, Mark Brown <broonie@kernel.org> wrote:
> On Fri, Jan 26, 2018 at 03:16:00PM +0800, Donglin Peng wrote:
>> On Wed, Jan 24, 2018 at 1:37 AM, Mark Brown <broonie@kernel.org> wrote:
>
>> > Too late, I already applied this - a further conversion for the new
>> > macro would be good.
>
>> I can send another patch after the following patch is merged:
>> https://patchwork.kernel.org/patch/10178813/
>
> Yes, please - that'd be great!

I have sent PR to Linus. If everything goes fine, it will be in
upstream today evening.

-- 
With Best Regards,
Andy Shevchenko
