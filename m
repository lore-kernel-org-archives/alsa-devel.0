From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH] ASoC: fsl_ssi: Set default slot number for
 common cases
Date: Thu, 9 Jan 2014 08:40:58 -0200
Message-ID: <CAOMZO5DTbZXE3zzWoVyuM98HcbRNqMOjfK_1VW7=hAKVijtMKQ@mail.gmail.com>
References: <1389260514-11365-1-git-send-email-Guangyu.Chen@freescale.com>
 <CAOMZO5C8hGYehqJ6WFUKye8wENuAejT-YXggeYy7V+DQ2_OMHg@mail.gmail.com>
 <20140109103453.GC14809@MrMyself>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ve0-f171.google.com (mail-ve0-f171.google.com
 [209.85.128.171])
 by alsa0.perex.cz (Postfix) with ESMTP id 1EE1326515C
 for <alsa-devel@alsa-project.org>; Thu,  9 Jan 2014 11:40:59 +0100 (CET)
Received: by mail-ve0-f171.google.com with SMTP id pa12so2220743veb.30
 for <alsa-devel@alsa-project.org>; Thu, 09 Jan 2014 02:40:58 -0800 (PST)
In-Reply-To: <20140109103453.GC14809@MrMyself>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolin Chen <Guangyu.Chen@freescale.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, Timur Tabi <timur@tabi.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Jan 9, 2014 at 8:34 AM, Nicolin Chen <Guangyu.Chen@freescale.com> wrote:

> Is this for the initial line? The CodingStyle contains two types of multi-line

Yes, correct.

> comment, one of which drops the initial line just like mine, even though it's
> saying 'For files in net/ and drivers/net/ the preferred style', so I thought
> it shouldn't be quite bother.

Yes, net and drivers/net are different and checkpatch reports it accordingly.

Regards,

Fabio Estevam
