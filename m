From: Ruslan Bilovol <ruslan.bilovol@gmail.com>
Subject: Re: [PATCH v2 1/2] ALSA: usb-audio: move audioformat quirks to quirks.c
Date: Tue, 20 Mar 2018 01:42:42 +0200
Message-ID: <CAB=otbTjO_e2Ad2C=PR2uP20i0qOkOpx9uNJgqYfThm2K1haPA@mail.gmail.com>
References: <1521423963-24677-1-git-send-email-ruslan.bilovol@gmail.com>
 <1521423963-24677-2-git-send-email-ruslan.bilovol@gmail.com> <s5h7eq8vyva.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5h7eq8vyva.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Jorge <jorge.sanjuan@codethink.co.uk>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Mon, Mar 19, 2018 at 6:00 PM, Takashi Iwai <tiwai@suse.de> wrote:
> On Mon, 19 Mar 2018 02:46:02 +0100,
> Ruslan Bilovol wrote:
>>
>> Offload USB audio interface parsing function by
>> moving quirks to a specially designed location (quirks.c)
>>
>> Signed-off-by: Ruslan Bilovol <ruslan.bilovol@gmail.com>
>
> This one is applied now to for-next branch.
>

Good, I'll drop this one from my series (although don't see it
in the for-next branch yet)

Thanks,
Ruslan
