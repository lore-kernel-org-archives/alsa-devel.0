From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [PATCH] hda-emu: Add idt_set_gpio verb for stac92xx
Date: Thu, 16 Aug 2012 14:59:42 +0200
Message-ID: <502CEEBE.6010106@canonical.com>
References: <1345119958-8259-1-git-send-email-david.henningsson@canonical.com>
 <s5ha9xvvx45.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id CCD60264EF8
 for <alsa-devel@alsa-project.org>; Thu, 16 Aug 2012 14:29:55 +0200 (CEST)
In-Reply-To: <s5ha9xvvx45.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 08/16/2012 02:29 PM, Takashi Iwai wrote:
> At Thu, 16 Aug 2012 14:25:58 +0200,
> David Henningsson wrote:
>>
>> According to Takashi, this verb is valid and given by Sigmatel.
>>
>> Also merge two identical arrays and sort the table a little.
>>
>> Signed-off-by: David Henningsson <david.henningsson@canonical.com>
>
> Thanks, applied.

And with that, the number of codecs failing is down from nine to three 
today. Thanks for your helpfulness, as always :-)


-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
