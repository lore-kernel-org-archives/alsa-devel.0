From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH 0/5] ASoC: pxa: Fix enum ctl accesses
Date: Wed, 02 Mar 2016 20:06:02 +0100
Message-ID: <8760x4r97p.fsf@belgarion.home>
References: <1456763033-2900-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.smtpout.orange.fr (smtp04.smtpout.orange.fr
 [80.12.242.126])
 by alsa0.perex.cz (Postfix) with ESMTP id 0F5932614BB
 for <alsa-devel@alsa-project.org>; Wed,  2 Mar 2016 20:06:07 +0100 (CET)
In-Reply-To: <1456763033-2900-1-git-send-email-tiwai@suse.de> (Takashi Iwai's
 message of "Mon, 29 Feb 2016 17:23:48 +0100")
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Daniel Mack <daniel@zonque.org>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai <tiwai@suse.de> writes:

> Hi,
>
> here is a patchset to correct the wrong type accesses in pxa drivers
> for enum ctls.  I didn't put Cc to stable for them, supposing these
> are only for 32bit systems.  If not, feel free to put Cc to stable. 
>
>
> thanks,
>
> Takashi
For the whole serie:
Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>

And yes, these are only 32 bits systems :)

Cheers.

--
Robert
