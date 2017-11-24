From: "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
Subject: Re: [PATCH] ASoC: amd: added error checks in dma driver
Date: Fri, 24 Nov 2017 19:49:00 +0530
Message-ID: <f9306aaa-616f-99cd-0c4e-00652b0d6a79@amd.com>
References: <1511454602-7259-1-git-send-email-Vijendar.Mukunda@amd.com>
 <CABXOdTezJbmEU=Oa+G1NN+WHoZqJERH8DAapJqgbPXkLnyweLw@mail.gmail.com>
 <20171123172904.4akrfhlonlwkmgs6@sirena.org.uk>
 <5ec79579-c6c6-6a74-5eca-fecf87defb59@amd.com>
 <CABXOdTeR9P3mAithS++cZaGkWRjgjPrPfT4dGDojyT5VSUsNRA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CABXOdTeR9P3mAithS++cZaGkWRjgjPrPfT4dGDojyT5VSUsNRA@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Guenter Roeck <groeck@google.com>
Cc: Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, perex@perex.cz, Alex Deucher <Alexander.Deucher@amd.com>, Akshu.Agrawal@amd.com, Guenter Roeck <linux@roeck-us.net>, linux-kernel <linux-kernel@vger.kernel.org>, Dominik Behr <dbehr@chromium.org>, Daniel Kurtz <djkurtz@chromium.org>, Guenter Roeck <groeck@chromium.org>
List-Id: alsa-devel@alsa-project.org



On Friday 24 November 2017 01:41 PM, Guenter Roeck wrote:
> On Fri, Nov 24, 2017 at 3:07 AM, Mukunda,Vijendar
> <vijendar.mukunda@amd.com> wrote:
>>
>>
>> On Thursday 23 November 2017 10:59 PM, Mark Brown wrote:
>>> On Thu, Nov 23, 2017 at 08:59:43AM -0800, Guenter Roeck wrote:
>>>> On Thu, Nov 23, 2017 at 8:30 AM, Vijendar Mukunda
>>>> <Vijendar.Mukunda@amd.com> wrote:
>>>>> added error checks in acp dma driver
>>>>> Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
>>>>> Signed-off-by: Akshu Agrawal <Akshu.Agrawal@amd.com>
>>>>> Signed-off-by: Guenter Roeck <groeck@chromium.org>
>>>> This is inappropriate.
>>> Specifically: if Guenter wasn't involved in writing or forwarding the
>>> patch he shouldn't have a signoff in there, and if you're the one
>>> sending the mail you should be the last person in the chain of signoffs.
>>> Please see SubmittingPatches for details of what a signoff means and why
>>> they're important.
>>
>>    This patch was implemented on top of changes implemented by Guenter.
>>    There is a separate thread - RE: [PATCH] ASoC: amd: Add error checking
>>    to probe function in which Guenter posted changes.
> That was my patch. This is yours.
>
> Guenter
     Got it , Let your patch go as it is. Will submit a fresh patch for additional
     error checks in acp dma driver.
>
>>        Got it, apologies will post changes as v2 version.
>>
