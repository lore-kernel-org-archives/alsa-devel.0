From: Maxim Kachur <mcdebugger@duganet.ru>
Subject: Re: [PATCH] emu10k1: add chip details for E-mu 1010
	PCIe card
Date: Wed, 17 Oct 2012 21:46:07 +0400
Message-ID: <507EEEDF.2010300@duganet.ru>
References: <507EC615.4070306@duganet.ru> <s5hfw5dqdea.wl%tiwai@suse.de>
Reply-To: mcdebugger@duganet.ru
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lb0-f179.google.com (mail-lb0-f179.google.com
 [209.85.217.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 44A72265285
 for <alsa-devel@alsa-project.org>; Wed, 17 Oct 2012 19:46:47 +0200 (CEST)
Received: by mail-lb0-f179.google.com with SMTP id c1so4853658lbg.38
 for <alsa-devel@alsa-project.org>; Wed, 17 Oct 2012 10:46:46 -0700 (PDT)
In-Reply-To: <s5hfw5dqdea.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 17.10.2012 20:19, Takashi Iwai wrote:
> At Wed, 17 Oct 2012 18:52:05 +0400,
> Maxim Kachur wrote:
>> emu10k1_main.c: Add chip details for E-mu 1010 PCIe card. It has the same
>> chip as found in E-mu 1010b but it uses different PCI id.
>>
>> Signed-off-by: Maxim Kachur<mcdebugger@duganet.ru>
> Thanks, applied.
>
>
> Takashi
>
Thank you! I hope it will reduce headache for some users not so familiar 
with kernel patching when using this type of cards.
