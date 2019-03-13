From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH] ALSA: hda - add more quirks for HP Z2 G4
	and HP Z240
Date: Wed, 13 Mar 2019 14:34:04 +0100
Message-ID: <6c77a8ad-bfea-d0a6-fde2-c184a7726ab3@perex.cz>
References: <20190313124015.25379-1-perex@perex.cz>
 <s5h7ed2vrau.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3FFF0F80799
 for <alsa-devel@alsa-project.org>; Wed, 13 Mar 2019 14:34:08 +0100 (CET)
In-Reply-To: <s5h7ed2vrau.wl-tiwai@suse.de>
Content-Language: en-US
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@perex.cz>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Dne 13. 03. 19 v 14:26 Takashi Iwai napsal(a):
> On Wed, 13 Mar 2019 13:40:15 +0100,
> Jaroslav Kysela wrote:
>>
>> From: Jaroslav Kysela <jkysela@redhat.com>
>>
>> Apply the HP_MIC_NO_PRESENCE fixups for the more HP Z2 G4 and
>> HP Z240 models.
>>
>> Reported-by: Jeff Burrell <jeff.burrell@hp.com>
>> Signed-off-by: Jaroslav Kysela <perex@perex.cz>
> 
> Thanks, I'm going to apply it with Cc to stable.
> BTW, would you like to keep your sign-off with @perex.cz while the
> author is @redhat.com?  Or is it just an overlook?

It's just an overlook. It should be perex@perex.cz for all. Thanks.

					Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
