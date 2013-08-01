From: Felipe Ferreri Tonello <eu@felipetonello.com>
Subject: Re: [PATCH v2 1/3] ALSA: Added jack detection kcontrol support
Date: Wed, 31 Jul 2013 20:52:52 -0700
Message-ID: <51F9DB94.1090906@felipetonello.com>
References: <1374878713-11922-1-git-send-email-eu@felipetonello.com> <1374878713-11922-2-git-send-email-eu@felipetonello.com> <s5hli4pe9ds.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5hli4pe9ds.wl%tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>, David Henningsson <david.henningsson@canonical.com>, Wang Xingchao <xingchao.wang@linux.intel.com>, Jaroslav Kysela <perex@perex.cz>
List-Id: alsa-devel@alsa-project.org

On 07/29/2013 07:19 AM, Takashi Iwai wrote:
> At Fri, 26 Jul 2013 15:45:11 -0700,
> Felipe F. Tonello wrote:
>>
>> From: "Felipe F. Tonello" <eu@felipetonello.com>
>>
>> This patch adds jack support for alsa kcontrol.
>>
>> This support is necessary since the new kcontrol is used by user-space
>> daemons, such as PulseAudio(>=2.0), to do jack detection.)
>>
>> Signed-off-by: Felipe F. Tonello <eu@felipetonello.com>
>
> This patch breaks the build.

I'm planing to send a v3 in few days.

Felipe Tonello
