From: "Alexander E. Patrakov" <patrakov@gmail.com>
Subject: Re: [Intel HDA][ALC3226] Too much white noise from
	microphone
Date: Fri, 06 Feb 2015 20:34:06 +0500
Message-ID: <54D4DEEE.3000005@gmail.com>
References: <8841801.KiuVFG1hDJ@segfault> <54D4A9F9.6090709@gmail.com>
 <3516931.ENm5BxjSkv@segfault>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f177.google.com (mail-wi0-f177.google.com
 [209.85.212.177])
 by alsa0.perex.cz (Postfix) with ESMTP id AE84F2605E8
 for <alsa-devel@alsa-project.org>; Fri,  6 Feb 2015 16:34:09 +0100 (CET)
Received: by mail-wi0-f177.google.com with SMTP id r20so3267741wiv.4
 for <alsa-devel@alsa-project.org>; Fri, 06 Feb 2015 07:34:09 -0800 (PST)
In-Reply-To: <3516931.ENm5BxjSkv@segfault>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Shawn Starr <shawn.starr@rogers.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

06.02.2015 20:22, Shawn Starr wrote:
>>> http://www.alsa-project.org/db/?f=29d3c45e2d66c58be03a10bd0186067a9d735a11

> Hello Alexander,
>
> Indeed, adjusting VREF to 50 cuts the background noise noticeably, it's still
> there but it is lesser.

The voice also becomes more quiet, but the SNR indeed improves. Although 
I'd still consider the situation as too noisy.

So, the original request stands.

-- 
Alexander E. Patrakov
