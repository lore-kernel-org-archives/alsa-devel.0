From: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
Subject: Re: [PATCH] sound: pci: asihpi: hpifunc.c: Remove some unused functions
Date: Mon, 22 Dec 2014 22:41:29 +0100
Message-ID: <CAFo99gazBQ=dYJX=2484m0ZydTZ9FRetPHdj=sgAVogtsxzfvQ@mail.gmail.com>
References: <1419180627-8986-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
 <54974A66.8010209@blennerhassett.gen.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <54974A66.8010209@blennerhassett.gen.nz>
Sender: linux-kernel-owner@vger.kernel.org
To: Eliot Blennerhassett <eliot@blennerhassett.gen.nz>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Hi Eliot!

This is one of the largest remove patches I made.
Is it just one function you disagree with?

Then I obviously send a new Patch!
Will be busy few days, but then I send a new one.

Kind regards
Rickard Strandqvist


2014-12-21 23:32 GMT+01:00 Eliot Blennerhassett <eliot@blennerhassett.gen.nz>:
> On 22/12/14 05:50, Rickard Strandqvist wrote:
>> Removes some functions that are not used anywhere:
>
> NAK - because  hpi_adapter_set_property() is now used in for-next branch
> of git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git
>
> Otherwise I have no problem with the patch.
