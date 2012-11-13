From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH v3 1/2] aplay: Show usage if no parameter
	is passed
Date: Tue, 13 Nov 2012 12:10:28 -0200
Message-ID: <CAOMZO5B6YUr=uFc5rR2A7EmiOuTU8m7EQEc5HjTFE9vgneySOw@mail.gmail.com>
References: <1352808340-10561-1-git-send-email-fabio.estevam@freescale.com>
 <s5h7gppiq1v.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ob0-f179.google.com (mail-ob0-f179.google.com
 [209.85.214.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 8DADE265176
 for <alsa-devel@alsa-project.org>; Tue, 13 Nov 2012 15:10:29 +0100 (CET)
Received: by mail-ob0-f179.google.com with SMTP id eq6so3325358obc.38
 for <alsa-devel@alsa-project.org>; Tue, 13 Nov 2012 06:10:28 -0800 (PST)
In-Reply-To: <s5h7gppiq1v.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, clemens@ladisch.de
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

On Tue, Nov 13, 2012 at 11:35 AM, Takashi Iwai <tiwai@suse.de> wrote:
> At Tue, 13 Nov 2012 10:05:39 -0200,
> Fabio Estevam wrote:
>>
>> When aplay/arecord are called without any argument the application hangs forever.
>>
>> Instead of hanging, print the usage and exit.
>>
>> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
>
> Applied this one.  I suppose there is no v4 for aplay, right?

Yes, correct.

Thanks,

Fabio Estevam
