From: Quentin Lambert <lambert.quentin@gmail.com>
Subject: Re: [PATCH v3] ALSA: aoa: convert bus code to use dev_groups
Date: Fri, 12 Jun 2015 12:01:42 +0200
Message-ID: <557AAE06.7020002@gmail.com>
References: <1432817307-28380-1-git-send-email-lambert.quentin@gmail.com>	<1434098322-12178-1-git-send-email-lambert.quentin@gmail.com> <87mw05w8kz.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <87mw05w8kz.fsf@igel.home>
Sender: kernel-janitors-owner@vger.kernel.org
To: Andreas Schwab <schwab@linux-m68k.org>
Cc: Johannes Berg <johannes@sipsolutions.net>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, linuxppc-dev@lists.ozlabs.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org



On 12/06/2015 11:59, Andreas Schwab wrote:
> Quentin Lambert <lambert.quentin@gmail.com> writes:
>
>> The dev_attrs field of struct bus_type is going away, sue dev_groups instead.
> s/sue/use/
I meant use do you need to fix something else or should I resend with 
the typo correction ?

Quentin
