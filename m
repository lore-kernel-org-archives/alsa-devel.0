From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v1 00/14] ASoC: qcom: Add capture support.
Date: Wed, 10 Feb 2016 10:39:41 +0000
Message-ID: <56BB136D.2010705@linaro.org>
References: <1455099418-311-1-git-send-email-srinivas.kandagatla@linaro.org>
 <20160210102250.GV13270@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160210102250.GV13270@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Patrick Lai <plai@codeaurora.org>, alsa-devel@alsa-project.org, Banajit Goswami <bgoswami@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, kwestfie@codeaurora.org
List-Id: alsa-devel@alsa-project.org



On 10/02/16 10:22, Mark Brown wrote:
> On Wed, Feb 10, 2016 at 10:16:58AM +0000, Srinivas Kandagatla wrote:
>
>> LPASS IP on QCOM SOC supports both Playback and capture
>> via I2S, but this feature is missing in existing code.
>> This patchset aims at adding capture support to lpass IP.
>> First few patches in this series does cleanup the driver
>> to make easy to add capture support.
>
>> Most of these patches are acked by Kenneth.
>
> ...when previously posted so this isn't version 1 of the series.  :/
Yes you are correct, If we consider RFC as v1.

I can repost the series with change to version if that's Ok with you.

--srini

>
